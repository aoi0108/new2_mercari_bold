import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  final XFile image;
  final String pose;

  const SecondPage({super.key, required this.image, required this.pose});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.file(File(image.path)),
            const SizedBox(height: 20),
            Text('Pose: $pose'),
          ],
        ),
      ),
    );
  }
}
