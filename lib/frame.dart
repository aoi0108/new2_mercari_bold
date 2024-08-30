import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:new2_mercari_bold/selection.dart';

class DetectionFrame extends StatelessWidget {
  final XFile image;
  final List<double> box; // x1, y1, x2, y2
  final String title;
  final double price;
  final Size imageSize;

  const DetectionFrame(
      {super.key,
      required this.image,
      required this.box,
      required this.title,
      required this.price,
      required this.imageSize});

  List<double> ResizeBox(List<double> box, Size frameSize) {
    double ratio = frameSize.height / imageSize.height;
    return [
      box[0] * ratio,
      box[1] * ratio,
      box[2] * ratio,
      box[3] * ratio,
    ];
  }

  @override
  Widget build(BuildContext context) {
    final resizedBox = ResizeBox(box, MediaQuery.of(context).size);
    var rank = 0;
    if (price > 100) {
      rank = 2;
    } else if (price > 3) {
      rank = 1;
    }
    return Scaffold(
        body: Row(children: [
      Stack(children: [
        Image.file(File(image.path), fit: BoxFit.cover),
        Positioned(
            child: Container(
              width: resizedBox[2] - resizedBox[0],
              height: resizedBox[3] - resizedBox[1],
              decoration: BoxDecoration(
                border: Border.all(color: Colors.yellow, width: 2),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            left: resizedBox[0],
            top: resizedBox[1]),
        Positioned(
            left: 0,
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.height /
                  imageSize.height *
                  imageSize.width,
              padding: EdgeInsets.all(32),
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        for (var i = 0; i < 3; i++)
                          Image.asset(
                            i <= rank
                                ? 'assets/star_fill.png'
                                : 'assets/star_empty.png',
                            width: 24,
                            height: 24,
                          )
                      ],
                    ),
                    const SizedBox(width: 16),
                    Text(title,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 4),
                    Text("を見つけた！", style: TextStyle(fontSize: 9)),
                  ],
                ),
              ),
            )),
        Positioned(
            child: Image.asset("assets/fight_character.png", width: 110),
            right: 10,
            bottom: 8)
      ]),
      Container(
          padding: EdgeInsets.only(top: 16, left: 24, right: 40, bottom: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Icon(Icons.currency_exchange_outlined,
                  size: 36, color: Colors.grey),
              const SizedBox(height: 64),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SelectionPage(),
                    ),
                  );
                },
                icon: Image.asset(
                  'assets/launch.png',
                  width: 80,
                  height: 80,
                ),
              ),
              const SizedBox(height: 64),
              const Icon(
                Icons.flash_off,
                size: 36,
                color: Colors.grey,
              ),
            ],
          )),
    ]));
  }
}
