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
    print(box);
    print(imageSize);
    print(MediaQuery.of(context).size);
    final resizedBox = ResizeBox(box, MediaQuery.of(context).size);
    // final resizedBox = box;
    print(resizedBox);
    return Scaffold(
        body: Row(children: [
      Stack(children: [
        Image.file(File(image.path), fit: BoxFit.cover),
        Positioned(
            child: Container(
              width: resizedBox[2] - resizedBox[0],
              height: resizedBox[3] - resizedBox[1],
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red, width: 2),
              ),
            ),
            left: resizedBox[0],
            top: resizedBox[1]),
        Positioned(
            bottom: 10,
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Text(title),
                  Text(price.toString()),
                ],
              ),
            )),
      ]),
      Container(
          padding: EdgeInsets.only(left: 40),
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
