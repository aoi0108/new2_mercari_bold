import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:new2_mercari_bold/camerafunc.dart';
import 'package:new2_mercari_bold/memorial.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:new2_mercari_bold/product.dart';

void main() {
  // runApp(const Memorial());
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight])
      .then((_) {
    runApp(const MyApp());
  });
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

// 商品モデルクラス
class Product {
  final int id;
  final String imageUrl;
  final double price;

  Product({required this.id, required this.imageUrl, required this.price});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      imageUrl: json['url'],
      price: json['price'].toDouble(),
    );
  }
}

class ProductGridPage extends StatefulWidget {
  const ProductGridPage({super.key});

  @override
  _ProductGridPageState createState() => _ProductGridPageState();
}

class _ProductGridPageState extends State<ProductGridPage> {
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    final url =
        Uri.parse('http://18.209.231.104:9000/products'); // 商品リスト取得エンドポイント
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> productListJson = json.decode(response.body);
      setState(() {
        products =
            productListJson.map((json) => Product.fromJson(json)).toList();
      });
    } else {
      print('Failed to load products');
    }
  }

  Future<void> fetchProductDetail(int productId) async {
    final url =
        Uri.parse('http://18.209.231.104:9000/products/1'); // 商品詳細取得エンドポイント
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('Product Details: $data');
      // 閲覧記録用の処理などもここで行う
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ProductDetailsPage(product: Product.fromJson(data)),
        ),
      );
    } else {
      print('Failed to load product details');
    }
  }

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
              onPressed: () async {
                // カメラを初期化
                final cameras = await availableCameras();
                final firstCamera = cameras.first;

                // CameraFunc画面に遷移
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CameraFunc(
                      cameras: cameras,
                      initialCamera: firstCamera,
                    ),
                  ),
                );
              },
              child: Text('List on item'),
            ),
          ],
        ),
      ),
      body: products.isEmpty
          ? Center(child: CircularProgressIndicator()) // データがロード中の場合の表示
          : GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, // 横画面で4列
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: products.length,
              itemBuilder: (BuildContext context, int index) {
                final product = products[index];
                return GestureDetector(
                  onTap: () {
                    fetchProductDetail(product.id);
                  },
                  child: Card(
                    elevation: 4.0,
                    child: Column(
                      children: [
                        Expanded(
                          child: Image.network(product.imageUrl,
                              fit: BoxFit.cover),
                        ),
                        ListTile(
                          leading:
                              Icon(Icons.monetization_on, color: Colors.yellow),
                          title: Text(
                            product.price.toStringAsFixed(2),
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
