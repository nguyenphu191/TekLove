import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiklove_fe/provider/AuthProvider.dart';
import 'package:tiklove_fe/provider/ProfileProvider.dart';
import 'package:tiklove_fe/start/start12.dart';
import 'package:tiklove_fe/widgets/interesting_box.dart';

class Start11Page extends StatefulWidget {
  const Start11Page({
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
    this.university = "", // Giá trị mặc định để tránh lỗi
    this.habits = const {}, // Đảm bảo không null
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
  final String university;
  final Map<String, String> habits;
  @override
  State<Start11Page> createState() => _Start11PageState();
}

class _Start11PageState extends State<Start11Page> {
  List<String> _interests = [];
  Future<void> _submitProfile() async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);

      final profileProvider =
          Provider.of<ProfileProvider>(context, listen: false);
      await profileProvider.createProfile(
          authProvider.account!.id,
          widget.name,
          widget.gender,
          widget.genderLike,
          [],
          widget.birthday,
          widget.findFor,
          widget.sexual,
          widget.showSexInProfile,
          widget.showGenderInProfile,
          widget.priorityDistance,
          widget.university,
          _interests,
          widget.habits,
          context);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Start12Page()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Có lỗi xảy ra: $e")),
      );
    }
  }

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
                      height: 455 * pix,
                      width: double.maxFinite,
                      margin: EdgeInsets.all(18 * pix),
                      child: Column(
                        children: [
                          Container(
                            height: 20 * pix,
                            width: double.maxFinite,
                            child: Text(
                              '11/12',
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
                          InterestingBox(
                            currentInterests: [],
                            onSelected: (selected) {
                              Future.delayed(Duration(milliseconds: 50), () {
                                setState(() {
                                  _interests = List.from(selected);
                                });
                              });
                            },
                          ),
                        ],
                      ),
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
                                _submitProfile();
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
