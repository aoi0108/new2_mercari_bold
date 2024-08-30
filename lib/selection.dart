import 'dart:io';

import 'package:flutter/material.dart';
import 'package:new2_mercari_bold/last-scene.dart';
import 'package:cross_file/cross_file.dart';

// void main() {
//   runApp(SelectionPage());
// }

class SelectionPage extends StatelessWidget {
  final XFile image;
  final List<double> box; // x1, y1, x2, y2
  final Size imageSize;
  final String title;
  final double price;

  SelectionPage(
      {required this.image, required this.box, required this.imageSize, required this.title, required this.price});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: MyCustomLayout(image: image, box: box, imageSize: imageSize, title: title, price: price),
        backgroundColor: Colors.white,
      ),
    );
  }
}

class MyCustomLayout extends StatefulWidget {
  final XFile image;
  final List<double> box;
  final Size imageSize;
  final String title;
  final double price;

  const MyCustomLayout(
      {Key? key,
      required this.image,
      required this.box,
      required this.imageSize,
      required this.title,
      required this.price})
      : super(key: key);

  @override
  _MyCustomLayoutState createState() => _MyCustomLayoutState();
}

class _MyCustomLayoutState extends State<MyCustomLayout> {
  double _hp = 100; // モンスターのHP
  final double _hpDecreaseAmount = 5; // 各操作で減少するHPの量

  void _decreaseHp() {
    setState(() {
      if (_hp > 0) {
        _hp -= _hpDecreaseAmount;
        if (_hp < 0) _hp = 0; // HPが0未満にならないようにする
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        Expanded(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.png'), // 画像のパスを指定
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 50,
                  child: Image.asset('assets/rare.png'),
                ),
                Container(
                  width: 130,
                  height: 130,
                  child: Image.asset(
                    _hp <= 50
                        ? 'assets/monster-over.png'
                        : 'assets/monster.png',
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: 100,
                  height: 15,
                  color: Colors.grey,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: _hp,
                      height: 7,
                      color: Colors.yellow,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MainScreen()),
                    );
                  },
                  child: Text('Fight!'),
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Color(0xFF5E6DF2)),
                ),
              ],
            ),
          ),
        ),

        // 右側4分の3エリア
        Expanded(
          flex: 3,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'Photos',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
                // 上部に画像を5枚ディスプレイ
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(), // 外側のスクロールに統一
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.15,
                          child: Center(
                            child: index == 0
                                ? Transform.scale(
                                    scale: widget.imageSize.width /
                                        (widget.box[2] - widget.box[0]),
                                    child: ClipRect(
                                        child: Align(
                                      alignment: Alignment(
                                          (widget.box[0]) /
                                              widget.imageSize.width,
                                          (widget.box[1]) /
                                              widget.imageSize.height),
                                      widthFactor:
                                          (widget.box[2] - widget.box[0]) /
                                              widget.imageSize.width,
                                      heightFactor:
                                          (widget.box[3] - widget.box[1]) /
                                              widget.imageSize.height,
                                      child: Image.file(File(widget.image.path),
                                          fit: BoxFit.cover),
                                    )))
                                : Image.asset('assets/non-picture.png'),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // 下部にスクロール可能なテキストフィールドを8個配置
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        'Description',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        onChanged: (value) => _decreaseHp(),
                        onTap: () => _decreaseHp(),
                        decoration: InputDecoration(
                          labelText: 'What are you selling?',
                          border: OutlineInputBorder(),
                        ),
                        controller: TextEditingController(text: widget.title),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        onChanged: (value) => _decreaseHp(),
                        onTap: () => _decreaseHp(),
                        decoration: InputDecoration(
                          labelText: 'Describe your item',
                          border: OutlineInputBorder(),
                        ),
                        controller: TextEditingController(text: 'This is a great item!'),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        onChanged: (value) => _decreaseHp(),
                        onTap: () => _decreaseHp(),
                        decoration: InputDecoration(
                          labelText: 'Add up to 7 hashtags (optional)',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Details',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        hint: Text('Category 1'),
                        decoration: InputDecoration(
                          labelText: 'Category',
                          border: OutlineInputBorder(),
                        ),
                        items: ['Category 1', 'Category 2', 'Category 3']
                            .map((String category) {
                          return DropdownMenuItem<String>(
                            value: category,
                            child: Text(category),
                          );
                        }).toList(),
                        onChanged: (value) => _decreaseHp(),
                          onTap: () => _decreaseHp(),
                      ),
                      SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        hint : Text('New'),
                        decoration: InputDecoration(
                          labelText: 'Condition',
                          border: OutlineInputBorder(),
                        ),
                        items: ['New', 'Used', 'Refurbished']
                            .map((String condition) {
                          return DropdownMenuItem<String>(
                            value: condition,
                            child: Text(condition),
                          );
                        }).toList(),
                        onChanged: (value) => _decreaseHp(),
                        onTap: () => _decreaseHp(),
                      ),
                      SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        hint: Text('Red'),
                        decoration: InputDecoration(
                          labelText: 'Color',
                          border: OutlineInputBorder(),
                        ),
                        items: ['Red', 'Green', 'Blue', 'Other']
                            .map((String color) {
                          return DropdownMenuItem<String>(
                            value: color,
                            child: Text(color),
                          );
                        }).toList(),
                        onChanged: (value) => _decreaseHp(),
                        onTap: () => _decreaseHp(),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Pricing',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        onChanged: (value) => _decreaseHp(),
                        onTap: () => _decreaseHp(),
                        decoration: InputDecoration(
                          labelText: 'Set Your price',
                          border: OutlineInputBorder(),
                        ),
                        controller: TextEditingController(text: widget.price.toString()),
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
