import 'package:flutter/material.dart';
import 'package:tiklove_fe/start/start7_distance.dart';
import 'package:tiklove_fe/widgets/find_for_box.dart';

class Start6Page extends StatefulWidget {
  const Start6Page(
      {super.key,
      required this.name,
      required this.birthday,
      required this.gender,
      required this.sexual,
      required this.showSexInProfile,
      required this.showGenderInProfile,
      required this.genderLike});
  final String name;
  final String birthday;
  final String gender;
  final String sexual;
  final bool showSexInProfile;
  final bool showGenderInProfile;
  final String genderLike;

  @override
  State<Start6Page> createState() => _Start6PageState();
}

class _Start6PageState extends State<Start6Page> {
  String findFor = 'Love';
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pix = size.width / 393;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: size.height,
            width: size.width,
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
            top: 82 * pix,
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
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 480 * pix,
                      width: double.maxFinite,
                      margin: EdgeInsets.all(18 * pix),
                      child: Column(
                        children: [
                          Container(
                            height: 16 * pix,
                            width: double.maxFinite,
                            child: Text(
                              '6/12',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.red,
                                fontFamily: 'BeVietnamPro',
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          SizedBox(
                            height: 15 * pix,
                          ),
                          FindForBox(
                            onSelectedFindFor: (value) {
                              setState(() {
                                findFor = value;
                              });
                            },
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16 * pix,
                    ),
                    Container(
                      height: 60 * pix,
                      width: double.maxFinite,
                      margin: EdgeInsets.all(18 * pix),
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Start7Page(
                                      name: widget.name,
                                      birthday: widget.birthday,
                                      gender: widget.gender,
                                      sexual: widget.sexual,
                                      showSexInProfile: widget.showSexInProfile,
                                      showGenderInProfile:
                                          widget.showGenderInProfile,
                                      genderLike: widget.genderLike,
                                      findFor: findFor,
                                    ),
                                  ),
                                );
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
