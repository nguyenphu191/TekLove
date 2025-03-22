import 'package:flutter/material.dart';
import 'package:tiklove_fe/start/start2_birth.dart';

class Start1Page extends StatefulWidget {
  const Start1Page({super.key});

  @override
  State<Start1Page> createState() => _Start1PageState();
}

class _Start1PageState extends State<Start1Page> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _nameController = TextEditingController();
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white,
                  Color(0xFFFF7A9C),
                ],
              ),
            ),
          ),
          Positioned(
            top: 82,
            left: 79,
            child: Container(
              height: 53,
              width: 235,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/Teklove/teklove2.png'),
                ),
              ),
            ),
          ),
          Positioned(
            top: 175,
            left: 8,
            right: 8,
            bottom: 15,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 190,
                      width: double.maxFinite,
                      margin: EdgeInsets.all(18),
                      child: Column(
                        children: [
                          Container(
                            height: 16,
                            width: double.maxFinite,
                            child: Text(
                              '1/12',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.red,
                                fontFamily: 'BeVietnamPro',
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            height: 32,
                            width: double.maxFinite,
                            child: Text(
                              'Tên của bạn là gì?',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'BeVietnamPro',
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            height: 46,
                            width: double.maxFinite,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: TextField(
                              controller: _nameController,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                hintText: 'Nhập tên của bạn',
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          Container(
                            width: double.maxFinite,
                            child: Text(
                              'Tên của bạn sẽ được hiển thị trên TekLove',
                              style: TextStyle(
                                fontSize: 14,
                                color: const Color.fromARGB(255, 90, 90, 90),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 320,
                    ),
                    Container(
                      height: 60,
                      width: double.maxFinite,
                      margin: EdgeInsets.all(18),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              borderRadius: BorderRadius.circular(30),
                              child: Container(
                                height: 56,
                                width: 164,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 240, 235, 235),
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xFFF4F4F4),
                                      offset: Offset(0, 2),
                                      spreadRadius: 1.5,
                                      blurRadius: 16, // Độ mờ của bóng
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    'Trước',
                                    style: TextStyle(
                                      color: Colors.black, // Màu chữ
                                      fontSize: 17,
                                      fontFamily: 'BeVietnamPro',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                if (_nameController.text.length < 6) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content:
                                        Text('Tên phải có ít nhất 6 ký tự'),
                                  ));
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Start2Page(
                                          name: _nameController.text),
                                    ),
                                  );
                                }
                              },
                              borderRadius: BorderRadius.circular(30),
                              child: Container(
                                height: 56,
                                width: 164,
                                decoration: BoxDecoration(
                                  color: Color(0xFFFF295F),
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromARGB(255, 250, 37, 90),
                                      offset: Offset(0, 2),
                                      spreadRadius: 1.5,
                                      blurRadius: 6, // Độ mờ của bóng
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    'Tiếp theo',
                                    style: TextStyle(
                                      color: Colors.white, // Màu chữ
                                      fontSize: 18,
                                      fontFamily: 'BeVietnamPro',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
