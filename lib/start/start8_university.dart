import 'package:flutter/material.dart';
import 'package:tiklove_fe/start/start9.dart';

class Start8Page extends StatefulWidget {
  const Start8Page({
    super.key,
    required this.name,
    required this.birthday,
    required this.gender,
    required this.sexual,
    required this.showSexInProfile,
    required this.showGenderInProfile,
    required this.genderLike,
    required this.findFor,
    required this.priorityDistance,
  });
  final String name;
  final String birthday;
  final String gender;
  final String sexual;
  final bool showSexInProfile;
  final bool showGenderInProfile;
  final String genderLike;
  final String findFor;
  final int priorityDistance;
  @override
  State<Start8Page> createState() => _Start8PageState();
}

class _Start8PageState extends State<Start8Page> {
  String university = '';
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pix = size.width / 393;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
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
            top: 80 * pix,
            left: 79 * pix,
            child: Container(
              height: 53 * pix,
              width: 235 * pix,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/Teklove/teklove2.png'),
                ),
              ),
            ),
          ),
          Positioned(
            top: 175 * pix,
            left: 8 * pix,
            right: 8 * pix,
            bottom: 15 * pix,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 250 * pix,
                      width: double.maxFinite,
                      margin: EdgeInsets.all(16 * pix),
                      child: Column(
                        children: [
                          Container(
                            height: 20 * pix,
                            width: double.maxFinite,
                            child: Text(
                              '8/12',
                              style: TextStyle(
                                fontSize: 15 * pix,
                                color: Colors.red,
                                fontFamily: 'BeVietnamPro',
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          SizedBox(
                            height: 15 * pix,
                          ),
                          Container(
                            height: 32 * pix,
                            width: double.maxFinite,
                            child: Text(
                              'Thêm trường học của bạn?',
                              style: TextStyle(
                                fontSize: 20 * pix,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'BeVietnamPro',
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          SizedBox(
                            height: 10 * pix,
                          ),
                          Container(
                            width: double.maxFinite,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Start9Page(
                                      name: widget.name,
                                      birthday: widget.birthday,
                                      gender: widget.gender,
                                      genderLike: widget.genderLike,
                                      sexual: widget.sexual,
                                      findFor: widget.findFor,
                                      showSexInProfile: widget.showSexInProfile,
                                      showGenderInProfile:
                                          widget.showGenderInProfile,
                                      priorityDistance: widget.priorityDistance,
                                      university: '',
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                'Bỏ qua',
                                style: TextStyle(
                                  fontSize: 15 * pix,
                                  fontFamily: 'BeVietnamPro',
                                  color: Color(0xFFFF295F),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15 * pix,
                          ),
                          Container(
                            height: 46 * pix,
                            width: double.maxFinite,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: TextField(
                              onChanged: (value) {
                                university = value;
                              },
                              keyboardType: TextInputType.streetAddress,
                              decoration: InputDecoration(
                                hintText: 'Nhập tên trường đã hoặc đang học',
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 200 * pix,
                    ),
                    Container(
                      height: 60 * pix,
                      width: double.maxFinite,
                      margin: EdgeInsets.all(16 * pix),
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
                                height: 56 * pix,
                                width: 164 * pix,
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
                                      fontSize: 17 * pix,
                                      fontFamily: 'BeVietnamPro',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                if (university.length == 0) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text('Vui lòng nhập trường học'),
                                  ));
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Start9Page(
                                        name: widget.name,
                                        birthday: widget.birthday,
                                        gender: widget.gender,
                                        genderLike: widget.genderLike,
                                        sexual: widget.sexual,
                                        findFor: widget.findFor,
                                        showSexInProfile:
                                            widget.showSexInProfile,
                                        showGenderInProfile:
                                            widget.showGenderInProfile,
                                        priorityDistance:
                                            widget.priorityDistance,
                                        university: university,
                                      ),
                                    ),
                                  );
                                }
                              },
                              borderRadius: BorderRadius.circular(30),
                              child: Container(
                                height: 56 * pix,
                                width: 164 * pix,
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
                                      fontSize: 18 * pix,
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

class GenderOption extends StatelessWidget {
  final String label;
  final String icon;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  GenderOption({
    required this.label,
    required this.icon,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 110,
        width: 110,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: isSelected ? color.withOpacity(0.2) : Colors.grey[200],
          border: isSelected
              ? Border.all(color: color, width: 2)
              : Border.all(color: Colors.transparent),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Container(
              height: 75,
              width: 75,
              padding: EdgeInsets.all(5),
              child: Image.asset(
                icon,
                fit: BoxFit.contain,
              ),
            ),
            Container(
              height: 30,
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 15,
                  color: isSelected ? color : Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
