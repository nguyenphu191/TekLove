import 'package:flutter/material.dart';
import 'package:tiklove_fe/start/start10.dart';

class Start9Page extends StatefulWidget {
  const Start9Page(
      {super.key,
      required this.name,
      required this.birthday,
      required this.gender,
      required this.sexual,
      required this.showSexInProfile,
      required this.showGenderInProfile,
      required this.genderLike,
      required this.findFor,
      required this.priorityDistance,
      required this.university});
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
  @override
  State<Start9Page> createState() => _Start9PageState();
}

class _Start9PageState extends State<Start9Page> {
  String selectedOption1 = '';
  String selectedOption2 = '';
  String selectedOption3 = '';
  Map<String, String> habits = {};
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
                      height: 510,
                      width: double.maxFinite,
                      margin: EdgeInsets.all(18),
                      child: Column(
                        children: [
                          Container(
                            height: 16,
                            width: double.maxFinite,
                            child: Text(
                              '9/12',
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
                              'Phong cách sống của bạn?',
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
                              'Liệu thói quen của người ấy có giống bạn không? ',
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'BeVietnamPro',
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(),
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildQuestion(
                                    icon: Icons.local_drink,
                                    question:
                                        "Bạn thường uống rượu bia như nào?",
                                    options: [
                                      "Không bao giờ uống",
                                      "Hiếm khi uống",
                                      "Chỉ uống vào dịp đặc biệt",
                                      "Thỉnh thoảng uống",
                                      "Thường xuyên uống",
                                      "Uống xã giao",
                                      "Không uống nhưng không ngại người khác uống"
                                    ],
                                    selectedOption: selectedOption1,
                                    onOptionSelected: (value) {
                                      setState(() {
                                        selectedOption1 = value;
                                        habits["drink"] = value;
                                      });
                                    },
                                  ),
                                  SizedBox(height: 16),
                                  _buildQuestion(
                                    icon: Icons.smoking_rooms,
                                    question: "Bạn có hay hút thuốc không?",
                                    options: [
                                      "Không bao giờ hút thuốc",
                                      "Thỉnh thoảng hút",
                                      "Hút thuốc xã giao",
                                      "Hút thuốc thường xuyên",
                                      "Đang cố bỏ thuốc",
                                      "Không quan tâm"
                                    ],
                                    selectedOption: selectedOption2,
                                    onOptionSelected: (value) {
                                      setState(() {
                                        selectedOption2 = value;
                                        habits["smoke"] = value;
                                      });
                                    },
                                  ),
                                  SizedBox(height: 16),
                                  _buildQuestion(
                                    icon: Icons.local_drink,
                                    question: "Bạn có chơi thể thao không?",
                                    options: [
                                      "Không tập thể dục",
                                      "Thích gym & thể hình",
                                      "Thích chạy bộ",
                                      "Thích yoga & thiền",
                                      "Thích bơi lội",
                                      "Thích thể thao ngoài trời",
                                    ],
                                    selectedOption: selectedOption3,
                                    onOptionSelected: (value) {
                                      setState(() {
                                        selectedOption3 = value;
                                        habits["gym"] = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
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
                                if (selectedOption1.isEmpty ||
                                    selectedOption2.isEmpty ||
                                    selectedOption3.isEmpty) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content:
                                        Text('Vui lòng chọn hết các câu hỏi'),
                                  ));

                                  return;
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Start10Page(
                                        name: widget.name,
                                        birthday: widget.birthday,
                                        gender: widget.gender,
                                        sexual: widget.sexual,
                                        genderLike: widget.genderLike,
                                        showSexInProfile:
                                            widget.showSexInProfile,
                                        showGenderInProfile:
                                            widget.showGenderInProfile,
                                        findFor: widget.findFor,
                                        priorityDistance:
                                            widget.priorityDistance,
                                        university: widget.university,
                                        habits: habits,
                                      ),
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

  Widget _buildQuestion({
    required IconData icon,
    required String question,
    required List<String> options,
    required String selectedOption,
    required Function(String) onOptionSelected,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 20),
            SizedBox(width: 8),
            Text(
              question,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'BeVietnamPro'),
            ),
          ],
        ),
        SizedBox(height: 5),
        Wrap(
          spacing: 5,
          runSpacing: -8,
          children: options.map((option) {
            final isSelected = selectedOption == option;
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isSelected ? Colors.pink : Colors.grey[200],
                foregroundColor: isSelected ? Colors.white : Colors.black,
                padding: EdgeInsets.symmetric(horizontal: 10),
                minimumSize: Size(0, 30),
              ),
              onPressed: () {
                setState(() {
                  // Cập nhật selectedOption
                  onOptionSelected(option);
                  // Cập nhật Map habits với key là câu hỏi
                  // habits[question] = option;
                });
              },
              child: Text(option,
                  style: TextStyle(fontSize: 14, fontFamily: 'BeVietnamPro'),
                  textAlign: TextAlign.center),
            );
          }).toList(),
        ),
      ],
    );
  }
}
