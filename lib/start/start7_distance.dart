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
  double _currentDistance = 10; // Giá trị mặc định là 10km
  final List<double> _distanceOptions = [5, 10, 15, 20, 25, 30, 50, 100, 200];

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
            bottom: 15 * pix,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 300 * pix, // Tăng chiều cao để chứa slider
                      width: double.maxFinite,
                      margin: EdgeInsets.all(16 * pix),
                      child: Column(
                        children: [
                          Container(
                            height: 20 * pix,
                            width: double.maxFinite,
                            child: Text(
                              '7/12',
                              style: TextStyle(
                                fontSize: 15 * pix,
                                color: Colors.red,
                                fontFamily: 'BeVietnamPro',
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          SizedBox(height: 15 * pix),
                          Container(
                            height: 32 * pix,
                            width: double.maxFinite,
                            child: Text(
                              'Khoảng cách ưu tiên của bạn?',
                              style: TextStyle(
                                fontSize: 20 * pix,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'BeVietnamPro',
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          SizedBox(height: 10 * pix),
                          Container(
                            width: double.maxFinite,
                            child: Text(
                              'Đặt khoảng cách tối đa từ vị trí của bạn tương hợp tiềm năng đến bạn.',
                              style: TextStyle(
                                fontSize: 12 * pix,
                                fontFamily: 'BeVietnamPro',
                              ),
                            ),
                          ),
                          SizedBox(height: 25 * pix),
                          Container(
                            width: double.maxFinite,
                            child: Text(
                              'Khoảng cách ưu tiên: ${_currentDistance.round()} km',
                              style: TextStyle(
                                fontSize: 16 * pix,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'BeVietnamPro',
                              ),
                            ),
                          ),
                          SizedBox(height: 20 * pix),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20 * pix),
                            child: SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                activeTrackColor: Color(0xFFFF295F),
                                inactiveTrackColor: Colors.grey[300],
                                trackHeight: 4 * pix,
                                thumbColor: Color(0xFFFF295F),
                                thumbShape: RoundSliderThumbShape(
                                    enabledThumbRadius: 10 * pix),
                                overlayColor: Color(0xFFFF295F).withAlpha(32),
                                overlayShape: RoundSliderOverlayShape(
                                    overlayRadius: 20 * pix),
                              ),
                              child: Slider(
                                value: _currentDistance,
                                min: 1,
                                max: 200,
                                divisions: 199,
                                label: _currentDistance.round().toString(),
                                onChanged: (double value) {
                                  setState(() {
                                    _currentDistance = value;
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 10 * pix),
                          // Hoặc có thể sử dụng Dropdown thay vì Slider
                          /*
                          Container(
                            height: 46 * pix,
                            width: double.maxFinite,
                            padding: EdgeInsets.symmetric(horizontal: 10 * pix),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: DropdownButton<double>(
                              value: _currentDistance,
                              isExpanded: true,
                              underline: SizedBox(),
                              items: _distanceOptions.map((double value) {
                                return DropdownMenuItem<double>(
                                  value: value,
                                  child: Text('$value km'),
                                );
                              }).toList(),
                              onChanged: (double? newValue) {
                                setState(() {
                                  _currentDistance = newValue!;
                                });
                              },
                            ),
                          ),
                          */
                          SizedBox(height: 15 * pix),
                          Container(
                            width: double.maxFinite,
                            child: Text(
                              'Bạn có thể thay đổi lại trong cài đặt.',
                              style: TextStyle(
                                fontSize: 14 * pix,
                                color: const Color.fromARGB(255, 90, 90, 90),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 150 * pix),
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
                                      blurRadius: 16,
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    'Trước',
                                    style: TextStyle(
                                      color: Colors.black,
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
                                        priorityDistance: _currentDistance
                                            .round()), // Làm tròn giá trị
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
                                      blurRadius: 6,
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    'Tiếp theo',
                                    style: TextStyle(
                                      color: Colors.white,
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
