import 'dart:ffi';

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
        actions: [
          Container(
              child: Row(children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/avatar.png'), // ユーザーのアイコン
            ),
            SizedBox(width: 8),
            Chip(
              avatar: Icon(Icons.monetization_on, color: Colors.yellow),
              label: Text('\$20.00'),
            )
          ])),
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
                  child: Image.network(
                    '', // デモ用の画像URL
                    fit: BoxFit.cover,
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.monetization_on, color: Colors.yellow),
                  title: Text(
                    '20.00',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
