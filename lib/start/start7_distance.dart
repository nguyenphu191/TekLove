import 'package:flutter/material.dart';
import 'package:tiklove_fe/start/start8_university.dart';

class Start7Page extends StatefulWidget {
  const Start7Page(
      {super.key,
      required this.name,
      required this.birthday,
      required this.gender,
      required this.sexual,
      required this.showSexInProfile,
      required this.showGenderInProfile,
      required this.genderLike,
      required this.findFor});
  final String name;
  final String birthday;
  final String gender;
  final String sexual;
  final bool showSexInProfile;
  final bool showGenderInProfile;
  final String genderLike;
  final String findFor;
  @override
  State<Start7Page> createState() => _Start7PageState();
}

class _Start7PageState extends State<Start7Page> {
  TextEditingController _priorityDistance = TextEditingController();
  bool isPositiveInteger(String input) {
    int? number = int.tryParse(input);
    return number != null && number > 0;
  }

  @override
  Widget build(BuildContext context) {
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
                      height: 250,
                      width: double.maxFinite,
                      margin: EdgeInsets.all(18),
                      child: Column(
                        children: [
                          Container(
                            height: 16,
                            width: double.maxFinite,
                            child: Text(
                              '7/12',
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
                              'Khoảng cách ưu tiên của bạn?',
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
                            height: 10,
                          ),
                          Container(
                            width: double.maxFinite,
                            child: Text(
                              'Đặt khoảng cách tối đa từ vị trí của bạn tương hợp tiềm năng đến bạn.',
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'BeVietnamPro',
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            width: double.maxFinite,
                            child: Text(
                              'Khoảng cách ưu tiên ',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'BeVietnamPro',
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 3,
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
                              controller: _priorityDistance,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                hintText: 'Km',
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          Container(
                            width: double.maxFinite,
                            child: Text(
                              'Bạn có thể thay đổi lại trong cài đặt.',
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
                      height: 260,
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
                                if (_priorityDistance.text.isEmpty ||
                                    !isPositiveInteger(
                                        _priorityDistance.text)) {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text('Thông báo'),
                                        content: Text(
                                            'Vui lòng nhập khoảng cách ưu tiên của bạn'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('OK'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Start8Page(
                                          name: widget.name,
                                          birthday: widget.birthday,
                                          gender: widget.gender,
                                          genderLike: widget.genderLike,
                                          sexual: widget.sexual,
                                          showSexInProfile:
                                              widget.showSexInProfile,
                                          showGenderInProfile:
                                              widget.showGenderInProfile,
                                          findFor: widget.findFor,
                                          priorityDistance: int.parse(
                                              _priorityDistance.text)),
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
