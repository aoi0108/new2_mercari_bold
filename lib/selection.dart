import 'package:flutter/material.dart';
import 'package:new2_mercari_bold/last-scene.dart';

void main() {
  runApp(SelectionPage());
}

class SelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: MyCustomLayout(),
        backgroundColor: Colors.white,
      ),
    );
  }
}

class MyCustomLayout extends StatefulWidget {
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
                            child: Image.asset(index == 0
                                ? 'assets/product.png'
                                : 'assets/non-picture.png'),
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
                        decoration: InputDecoration(
                          labelText: 'What are you selling?',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        onChanged: (value) => _decreaseHp(),
                        decoration: InputDecoration(
                          labelText: 'Describe your item',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        onChanged: (value) => _decreaseHp(),
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
                      ),
                      SizedBox(height: 10),
                      DropdownButtonFormField<String>(
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
                      ),
                      SizedBox(height: 10),
                      DropdownButtonFormField<String>(
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
                        decoration: InputDecoration(
                          labelText: 'Set Your price',
                          border: OutlineInputBorder(),
                        ),
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
