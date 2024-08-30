import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Image and Button Screen',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    ),
    home: MainScreen(),
  ));
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Main Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 画像を表示するウィジェット
            Image.asset(
              'assets/sample_image.png', // 画像のパスを指定
              width: 200, // 画像の幅
              height: 200, // 画像の高さ
            ),
            SizedBox(height: 20), // 画像とボタンの間にスペースを追加
            // ボタンを表示するウィジェット
            ElevatedButton(
              onPressed: () {
                // ボタンが押されたときのアクションをここに書く
                print('Button Pressed');
              },
              child: const Text('Press Me'),
            ),
          ],
        ),
      ),
    );
  }
}
