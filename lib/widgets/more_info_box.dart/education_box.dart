import 'package:flutter/material.dart';
import 'package:tiklove_fe/theme/app_colors.dart';

class EducationBox extends StatefulWidget {
  const EducationBox(
      {super.key, required this.education, required this.callback});
  final String education;
  final ValueChanged<String> callback;

  @override
  State<EducationBox> createState() => _EducationBoxState();
}

class _EducationBoxState extends State<EducationBox> {
  List<String> _educations = [
    'Tiến sĩ',
    'Thạc sĩ',
    'Cử nhân',
    'Trung cấp',
    'Sơ cấp',
    'Khác'
  ];
  late String _selectEducation;
  @override
  void initState() {
    _selectEducation = widget.education;
    super.initState();
  }

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
              'Trình độ học vấn của bạn là gì?',
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
                    options: _educations,
                    selectedOptions: _selectEducation,
                    onOptionSelected: (value) {
                      setState(() {
                        _selectEducation = value;
                      });
                      widget.callback(_selectEducation);
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
