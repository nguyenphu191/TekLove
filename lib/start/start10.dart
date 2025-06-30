import 'package:flutter/material.dart';
import 'package:tiklove_fe/start/start11.dart';

class Start10Page extends StatefulWidget {
  const Start10Page(
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
      required this.university,
      required this.habits});
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
  State<Start10Page> createState() => _Start10PageState();
}

class _Start10PageState extends State<Start10Page> {
  String selectedOption1 = '';
  String selectedOption2 = '';
  String selectedOption3 = '';
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
            top: 165 * pix,
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
                      height: 480,
                      width: double.maxFinite,
                      margin: EdgeInsets.all(16 * pix),
                      child: Column(
                        children: [
                          Container(
                            height: 20 * pix,
                            width: double.maxFinite,
                            child: Text(
                              '10/12',
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
                            height: 90 * pix,
                            width: double.maxFinite,
                            child: Text(
                              'Điều gì tạo nên phiên bản chân thật nhất về bạn? (Có thể bỏ qua)',
                              style: TextStyle(
                                fontSize: 18 * pix,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'BeVietnamPro',
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          SizedBox(
                            height: 5 * pix,
                          ),
                          Container(
                            width: double.maxFinite,
                            child: Text(
                              'Hãy cứ chia sẻ thật nhé. Cần chân thành mới đổi được chân tình.',
                              style: TextStyle(
                                fontSize: 12 * pix,
                                fontFamily: 'BeVietnamPro',
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5 * pix,
                          ),
                          Container(
                            width: double.maxFinite,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Start11Page(
                                      name: widget.name,
                                      birthday: widget.birthday,
                                      gender: widget.gender,
                                      sexual: widget.sexual,
                                      genderLike: widget.genderLike,
                                      showSexInProfile: widget.showSexInProfile,
                                      showGenderInProfile:
                                          widget.showGenderInProfile,
                                      findFor: widget.findFor,
                                      priorityDistance: widget.priorityDistance,
                                      university: widget.university,
                                      habits: widget.habits,
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
                            height: 5 * pix,
                          ),
                          Divider(),
                          SizedBox(
                            height: 5 * pix,
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildQuestion(
                                    icon: Icons.local_drink,
                                    question:
                                        "Chế độ ăn uống của bạn như thế nào?",
                                    options: [
                                      "Ăn chay",
                                      "Ăn thuần chay (vegan)",
                                      "Ăn chay linh hoạt (flexitarian)",
                                      "Ăn kiêng keto",
                                      "Ăn kiêng low-carb",
                                      "Yêu thích đồ ngọt",
                                      "Thích ăn cay",
                                      "Chỉ ăn thực phẩm hữu cơ",
                                      "Không kiêng khem",
                                      "Thích nấu ăn",
                                      "Ăn uống theo chế độ lành mạnh",
                                      "Ưu tiên đồ ăn nhanh",
                                      "Không thích rau củ",
                                      "Bị dị ứng thực phẩm",
                                      "Không uống rượu",
                                      "Thích thử món ăn mới"
                                    ],
                                    selectedOption: selectedOption1,
                                    onOptionSelected: (value) {
                                      setState(() {
                                        selectedOption1 = value;
                                        widget.habits["eat"] = value;
                                      });
                                    },
                                  ),
                                  SizedBox(height: 16 * pix),
                                  _buildQuestion(
                                    icon: Icons.smoking_rooms,
                                    question: "Giấc ngủ của bạn như thế nào?",
                                    options: [
                                      'Ngủ một mình',
                                      'Ngủ cùng người yêu',
                                      'Ngủ với gấu bông',
                                      'Ngủ với thú cưng',
                                      'Ngủ vắt chân',
                                      'Ngủ nhiều gối',
                                      'Ngủ nhiều chăn',
                                      'Thích ngủ nệm cứng',
                                      'Thích ngủ nệm mềm',
                                      'Thích ngủ nệm êm',
                                      'Thích ngủ nệm lò xo',
                                    ],
                                    selectedOption: selectedOption2,
                                    onOptionSelected: (value) {
                                      setState(() {
                                        selectedOption2 = value;
                                        widget.habits["sleep"] = value;
                                      });
                                    },
                                  ),
                                  SizedBox(height: 16 * pix),
                                  _buildQuestion(
                                    icon: Icons.local_drink,
                                    question: "Bạn có nuôi thú cưng không ?",
                                    options: [
                                      'Chó',
                                      'Mèo',
                                      'Chim',
                                      'Cá',
                                      'Gà'
                                          'Vịt',
                                      'Lợn',
                                      'Rắn',
                                      'Nhện',
                                      'Chuột',
                                      'Bò sát',
                                      'Không nuôi thú cưng',
                                      "Yêu thích động vật nhưng chưa nuôi",
                                      "Dị ứng với động vật",
                                      'Khác'
                                    ],
                                    selectedOption: selectedOption3,
                                    onOptionSelected: (value) {
                                      setState(() {
                                        selectedOption3 = value;
                                        widget.habits["pet"] = value;
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Start11Page(
                                      name: widget.name,
                                      birthday: widget.birthday,
                                      gender: widget.gender,
                                      sexual: widget.sexual,
                                      genderLike: widget.genderLike,
                                      showSexInProfile: widget.showSexInProfile,
                                      showGenderInProfile:
                                          widget.showGenderInProfile,
                                      findFor: widget.findFor,
                                      priorityDistance: widget.priorityDistance,
                                      university: widget.university,
                                      habits: widget.habits,
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
                  onOptionSelected(option);
                  widget.habits[question] = option;
                });
              },
              child: Text(option,
                  style: TextStyle(fontFamily: 'BeVietnamPro', fontSize: 14),
                  textAlign: TextAlign.center),
            );
          }).toList(),
        ),
      ],
    );
  }
}
