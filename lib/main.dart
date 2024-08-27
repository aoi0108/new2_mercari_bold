import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Grid',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const ProductGridPage(),
    );
  }
}

class ProductGridPage extends StatelessWidget {
  const ProductGridPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/avatar.png'), // ユーザーのアイコン
            ),
            SizedBox(width: 8),
            Chip(
              avatar: Icon(Icons.monetization_on, color: Colors.yellow),
              label: Text('\$20.00'),
            ),
            Spacer(), // 左寄せにするために追加
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {},
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('List on item'),
            ),
          ],
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, // 横画面で4列
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: 8, // デモのためのアイテム数
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 4.0,
            child: Column(
              children: [
                Expanded(
                  child: Image.asset('assets/img1.png', fit: BoxFit.cover),

                  // 画像の表示
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
