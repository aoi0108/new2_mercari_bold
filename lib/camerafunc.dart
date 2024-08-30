import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 横向きに固定
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);

  final cameras = await availableCameras();
  final firstCamera = cameras.first;
  runApp(CameraFunc(
    cameras: cameras,
    initialCamera: firstCamera,
  ));
}

class DetectionResult {
  final List<double> box;
  final String title;
  final double price;
  final Size imageSize;

  DetectionResult(
      {required this.box,
      required this.title,
      required this.price,
      required this.imageSize});

  factory DetectionResult.fromJson(Map<String, dynamic> json) {
    return DetectionResult(
      box: [
        json['box'][0].toDouble(),
        json['box'][1].toDouble(),
        json['box'][2].toDouble(),
        json['box'][3].toDouble()
      ],
      title: json['title'],
      price: json['price'].toDouble(),
      imageSize: Size(json['width'].toDouble(), json['height'].toDouble()),
    );
  }
}

class CameraFunc extends StatelessWidget {
  const CameraFunc(
      {super.key, required this.cameras, required this.initialCamera});

  final List<CameraDescription> cameras;
  final CameraDescription initialCamera;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Camera App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: CameraScreen(cameras: cameras, initialCamera: initialCamera),
    );
  }
}

class CameraScreen extends StatefulWidget {
  const CameraScreen(
      {super.key, required this.cameras, required this.initialCamera});

  final List<CameraDescription> cameras;
  final CameraDescription initialCamera;

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  late CameraDescription _currentCamera;
  late FlashMode _flashMode = FlashMode.off;
  bool _isZoomed = false;

  @override
  void initState() {
    super.initState();
    _currentCamera = widget.initialCamera;
    _controller = CameraController(
      _currentCamera,
      ResolutionPreset.max, // 画面全体に表示するために最大解像度に変更
    );
    _initializeControllerFuture = _controller.initialize();
    _controller.lockCaptureOrientation(DeviceOrientation.landscapeRight);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _onSwitchCamera() async {
    final newCamera = widget.cameras.firstWhere(
      (camera) => camera != _currentCamera,
    );

    setState(() {
      _currentCamera = newCamera;
      _controller = CameraController(
        _currentCamera,
        ResolutionPreset.max,
      );
      _initializeControllerFuture = _controller.initialize();
    });
  }

  Future<void> _toggleFlashMode() async {
    setState(() {
      _flashMode =
          _flashMode == FlashMode.off ? FlashMode.always : FlashMode.off;
    });
    await _controller.setFlashMode(_flashMode);
  }

  Future<void> _toggleZoom() async {
    setState(() {
      _isZoomed = !_isZoomed;
    });
    final zoomLevel = _isZoomed ? 2.0 : 1.0;
    await _controller.setZoomLevel(zoomLevel);
  }

  Future<void> _takePicture() async {
    await _controller.setFlashMode(_flashMode);
    final image = await _controller.takePicture();

    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DisplayPictureScreen(imagePath: image.path),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: CameraPreview(_controller),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          Positioned(
            top: 30.0,
            left: 10.0,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 40,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Positioned(
            bottom: 30.0,
            left: 0.0,
            right: 0.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(
                    _flashMode == FlashMode.off
                        ? Icons.flash_off
                        : Icons.flash_on,
                    color: Colors.white,
                    size: 40,
                  ),
                  onPressed: _toggleFlashMode,
                ),
                    ShutterButton(
                      onPressed: () async {
                        // 写真を撮る
                        final image = await _controller.takePicture();
                        showProgressDialog(context);
                        final DetectionResult res = await _sendRequest(image);
                        Navigator.of(context, rootNavigator: true).pop();
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetectionFrame(
                                  image: image,
                                  box: res.box,
                                  title: res.title,
                                  price: res.price,
                                  imageSize: res.imageSize)),
                        );
                      },
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                    IconButton(
                      icon: const Icon(
                        Icons.flip_camera_android_rounded,
                        color: Colors.black,
                        size: 45.0,
                      ),
                      onPressed: _onSwitchCamera,
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(
                    _isZoomed ? Icons.zoom_out : Icons.zoom_in,
                    color: Colors.white,
                    size: 40,
                  ),
                  onPressed: _toggleZoom,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<DetectionResult> _sendRequest(XFile file) async {
    final uri = Uri.parse('http://18.209.231.104:7000/detect');
    final request = http.MultipartRequest('POST', uri)
      ..headers['content-type'] = 'multipart/form-data'
      ..headers['upgrade-insecure-requests'] = '1'
      ..fields['Content-Disposition'] =
          'form-data; name="file"; filename="good.jpg"'
      ..files.add(await http.MultipartFile.fromPath('file', file.path));
    final response = await http.Response.fromStream(await request.send());
    // final response_body = {"title":"Empty Plastic Water Bottle","price":0.99,"box":[445.7776794433594,309.4581298828125,1281.6619873046875,1145.3424072265625]};
    if (response.statusCode == 200) {
      debugPrint('Response: ${response.body}');
      final dynamic detectionResultJson = json.decode(response.body);
      return DetectionResult.fromJson(detectionResultJson);
    } else {
      debugPrint('Error: ${response.statusCode}');
      return DetectionResult(
          box: [], title: '', price: 0.0, imageSize: Size(1920, 1080));
    }
    // return DetectionResult(box: [803.613525390625,485.6523742675781,1384.7322998046875,1066.7711181640625], title: 'Casio Baby-G Tough Solar Watch', price: 0.99, imageSize: Size(1920, 1080));
  }
}

class DisplayPictureScreen extends StatelessWidget {
  const DisplayPictureScreen({super.key, required this.imagePath});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Captured Picture')),
      body: Center(child: Image.file(File(imagePath))),
    );
  }
}

class ShutterButton extends StatelessWidget {
  final Function()? onPressed;

  const ShutterButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    const double size = 64.0;

    return OutlinedButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(0.0),
        fixedSize: const Size(size, size),
        side: const BorderSide(
          color: Color(0xFF5E6DF2),
          width: 4.0,
        ),
        shape: const CircleBorder(),
      ),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
