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
              width: 200, // 画像の幅
              height: 200, // 画像の高さ
              fit: BoxFit.cover,
            ),
            Text(
              'Excellent! Send the data to your parents!',
              style: TextStyle(fontSize: 20),
            ),
            // 画像とボタンの間にスペースを追加せず、隙間を埋める
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // ボタンが押されたときのアクションをここに書く
                print('Button Pressed');
              },
              child: const Text('Send', style: TextStyle(fontSize: 16)),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Color(0xFF5E6DF2),
              ),
            ),
            SizedBox(height: 20), // ボタンの下にスペースを追加
          ],
        ),
      ),
    );
  }
}
