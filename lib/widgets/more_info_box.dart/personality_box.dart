import 'package:flutter/material.dart';
import 'package:tiklove_fe/theme/app_colors.dart';

class PersonalityBox extends StatefulWidget {
  const PersonalityBox(
      {super.key, required this.personality, required this.callback});
  final String personality;
  final ValueChanged<String> callback;

  @override
  State<PersonalityBox> createState() => _PersonalityBoxState();
}

class _PersonalityBoxState extends State<PersonalityBox> {
  List<String> personality = [
    "Hướng nội",
    "Hướng ngoại",
    "Lãng mạn",
    "Thực tế",
    "Tự tin",
    "Hài hước",
    "Trầm lặng",
    "Nhiệt huyết",
    "Bí ẩn",
    "Thích phiêu lưu",
    "Nhạy cảm",
    "Sáng tạo",
    "Thích kiểm soát",
    "Dịu dàng",
    "Tận tâm",
    "Độc lập",
    "Thích sự ổn định",
    "Thích khám phá",
    "Thích giúp đỡ người khác",
    "Thẳng thắn"
  ];
  late String _selectPersonality;
  @override
  void initState() {
    super.initState();
    _selectPersonality = widget.personality;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pix = size.width / 393;
    return Container(
      height: 448 * pix,
      width: double.maxFinite,
      child: Column(
        children: [
          Container(
            height: 32 * pix,
            width: double.maxFinite,
            child: Text(
              'Kiểu tính cách của bạn là gì?',
              style: TextStyle(
                fontSize: 18 * pix,
                color: const Color.fromARGB(255, 53, 39, 39),
                fontWeight: FontWeight.bold,
                fontFamily: 'BeVietnamPro',
              ),
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(
            height: 10 * pix,
          ),
          Divider(),
          SizedBox(
            height: 10 * pix,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildQuestion(
                    options: personality,
                    selectedOptions: _selectPersonality,
                    onOptionSelected: (value) {
                      setState(() {
                        _selectPersonality = value;
                      });
                      widget.callback(_selectPersonality);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestion({
    required List<String> options,
    required String selectedOptions,
    required Function(String) onOptionSelected,
  }) {
    return Wrap(
      spacing: 5,
      runSpacing: -8,
      children: options.map((option) {
        final isSelected = selectedOptions == option;
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: isSelected ? AppColors.primary : Colors.grey[200],
            foregroundColor: isSelected ? Colors.white : Colors.black,
            padding: EdgeInsets.symmetric(horizontal: 10),
            minimumSize: Size(0, 30),
          ),
          onPressed: () => onOptionSelected(option),
          child: Text(
            option,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'BeVietnamPro',
              fontSize: 14,
            ),
          ),
        );
      }).toList(),
    );
  }
}
