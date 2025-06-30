import 'package:flutter/material.dart';
import 'package:tiklove_fe/start/start6_findfor.dart';

class Start5Page extends StatefulWidget {
  const Start5Page(
      {super.key,
      required this.name,
      required this.birthday,
      required this.gender,
      required this.sexual,
      required this.showSexInProfile,
      required this.showGenderInProfile});
  final String name;
  final String birthday;
  final String gender;
  final String sexual;
  final bool showSexInProfile;
  final bool showGenderInProfile;

  @override
  State<Start5Page> createState() => _Start5PageState();
}

class _Start5PageState extends State<Start5Page> {
  String selectedGenderLike = "Nam";
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
              decoration: const BoxDecoration(
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
            bottom: 16 * pix,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 280 * pix,
                      width: double.maxFinite,
                      margin: EdgeInsets.all(16 * pix),
                      child: Column(
                        children: [
                          Container(
                            height: 20 * pix,
                            width: double.maxFinite,
                            child: Text(
                              '5/12',
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
                              'Bạn muốn thấy ai?',
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
                            height: 15 * pix,
                          ),
                          Container(
                            height: 110 * pix,
                            width: double.maxFinite,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GenderOption(
                                  label: 'Nam',
                                  icon: 'assets/images/Teklove/male.png',
                                  color: Colors.orange,
                                  isSelected: selectedGenderLike == 'Nam',
                                  onTap: () {
                                    setState(() {
                                      selectedGenderLike = 'Nam';
                                    });
                                  },
                                ),
                                GenderOption(
                                  label: 'Nữ',
                                  icon: 'assets/images/Teklove/female.png',
                                  color: Colors.pink,
                                  isSelected: selectedGenderLike == 'Nữ',
                                  onTap: () {
                                    setState(() {
                                      selectedGenderLike = 'Nữ';
                                    });
                                  },
                                ),
                                GenderOption(
                                  label: 'Mọi người',
                                  icon: 'assets/images/Teklove/profile.png',
                                  color: Colors.green,
                                  isSelected: selectedGenderLike == 'Mọi người',
                                  onTap: () {
                                    setState(() {
                                      selectedGenderLike = 'Mọi người';
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 168 * pix,
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
                                  boxShadow: const [
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
                                    builder: (context) => Start6Page(
                                      showSexInProfile: widget.showSexInProfile,
                                      showGenderInProfile:
                                          widget.showGenderInProfile,
                                      gender: widget.gender,
                                      sexual: widget.sexual,
                                      name: widget.name,
                                      birthday: widget.birthday,
                                      genderLike: selectedGenderLike,
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
                                  boxShadow: const [
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
    final size = MediaQuery.of(context).size;
    final pix = size.width / 393;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 110 * pix,
        width: 110 * pix,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: isSelected ? color.withOpacity(0.2) : Colors.grey[200],
          border: isSelected
              ? Border.all(color: color, width: 2)
              : Border.all(color: Colors.transparent),
          borderRadius: BorderRadius.circular(10 * pix),
        ),
        child: Column(
          children: [
            Container(
              height: 65 * pix,
              width: 65 * pix,
              padding: EdgeInsets.all(5 * pix),
              child: Image.asset(
                icon,
                fit: BoxFit.contain,
              ),
            ),
            Container(
              height: 30 * pix,
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 14 * pix,
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
