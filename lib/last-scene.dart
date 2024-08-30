import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Image and Button Screen',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    ),
    home: MainScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 画像を表示するウィジェット
            Image.asset(
              'assets/last.png', // 画像のパスを指定
              width: 300, // 画像の幅
              height: 300, // 画像の高さ
            ),
            // 画像とボタンの間にスペースを追加
            // ボタンを表示するウィジェット
            ElevatedButton(
                onPressed: () {
                  // ボタンが押されたときのアクションをここに書く
                  print('Button Pressed');
                },
                child: const Text('Fight!'),
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color(0xFF5E6DF2))),
          ],
        ),
      ),
    );
  }
}
