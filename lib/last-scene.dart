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
              'assets/last2.png', // 画像のパスを指定
              width: 300, // 画像の幅
              height: 300, // 画像の高さ
              fit: BoxFit.cover,
            ),
            // 画像とボタンの間にスペースを追加せず、隙間を埋める
            ElevatedButton(
              onPressed: () {
                // ボタンが押されたときのアクションをここに書く
                print('Button Pressed');
              },
              child: const Text('Fight!', style: TextStyle(fontSize: 18)),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Color(0xFF5E6DF2),
              ),
            ),
            SizedBox(height: 35), // ボタンの下にスペースを追加
          ],
        ),
      ),
    );
  }
}
