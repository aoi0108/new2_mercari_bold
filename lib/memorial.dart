import 'package:flutter/material.dart';

class Memorial extends StatefulWidget {
  const Memorial({
    super.key,
  });
  @override
  State<Memorial> createState() => _MemorialState();
}

class _MemorialState extends State<Memorial> {
  Widget image = Image.asset("assets/img1.png", height: 216);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Child Memorial',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: LayoutBuilder(builder: (context, constraints) {
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: const Text('Child Memorial'),
              ),
              body: Column(children: [
                Container(
                    color: Colors.white,
                    padding: const EdgeInsets.only(
                        left: 16, right: 16, top: 24, bottom: 24),
                    child: Column(
                      children: [
                        Container(
                            alignment: Alignment.centerLeft,
                            child: Chip(
                                backgroundColor: Color(0xFFF2F3FE),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100)),
                                ),
                                // color: Color(0xFF5E6DF2),
                                label: Text(
                                  "Emily",
                                  style: TextStyle(color: Color(0xFF5E6DF2)),
                                ))),
                        SizedBox(height: 16),
                        // Expanded(child:
                        Row(
                          // crossAxisAlignment: CrossAxisAlignment.e,
                          children: [
                            Text(
                              "Frequent words",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Icon(
                              Icons.question_mark_rounded,
                              size: 14,
                            ),
                            Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "See all",
                                  style: TextStyle(
                                      color: Color(0xFF5E6DF2),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ))
                          ],
                          // )
                        ),
                        SizedBox(height: 16),
                        image,
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Icon(Icons.timelapse_outlined,
                                size: 16, color: Colors.grey),
                            SizedBox(width: 8),
                            Text(
                              "08.01.2024-08.31.2024",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                            )
                          ],
                        )
                      ],
                    )),
                Container(
                  height: 4,
                  color: Colors.grey[300],
                ),
                Container(
                    color: Colors.white,
                    padding:
                        const EdgeInsets.only(top: 24, bottom: 16, left: 16),
                    alignment: Alignment.centerLeft,
                    child: Text(
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                        "Recommend to your child")),
                Container(
                    color: Colors.white,
                    width: constraints.maxWidth,
                    height: constraints.maxHeight * 0.3,
                    child: GridView.builder(
                      padding: const EdgeInsets.all(0.0),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, // 横画面で4列
                        crossAxisSpacing: 3.0,
                        mainAxisSpacing: 3.0,
                      ),
                      itemCount: 6, // デモのためのアイテム数
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          elevation: 4.0,
                          child: Column(
                            children: [
                              Expanded(
                                child: Image.asset(
                                  'assets/img1.png',
                                  width: 128,
                                ),
                                // 画像の表示
                              )
                            ],
                          ),
                        );
                      },
                    ))
              ]));
        }));
  }
}
