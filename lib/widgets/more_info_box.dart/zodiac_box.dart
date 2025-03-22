import 'package:flutter/material.dart';
import 'package:tiklove_fe/theme/app_colors.dart';

class ZodiacBox extends StatefulWidget {
  const ZodiacBox({
    super.key,
    required this.zodiac,
    required this.callback,
  });
  final String zodiac;
  final ValueChanged<String> callback;
  @override
  State<ZodiacBox> createState() => _ZodiacBoxState();
}

class _ZodiacBoxState extends State<ZodiacBox> {
  List<String> zodiac = [
    'Bạch Dương',
    'Kim Ngưu',
    'Song Tử',
    'Cự Giải',
    'Sư Tử',
    'Xử Nữ',
    'Thiên Bình',
    'Thiên Yết',
    'Nhân Mã',
    'Ma Kết',
    'Bảo Bình',
    'Song Ngư'
  ];
  late String _selectZodiac;
  @override
  void initState() {
    super.initState();
    _selectZodiac = widget.zodiac;
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
              'Cung hoàng đạo của bạn là gì?',
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
                    options: zodiac,
                    selectedOptions: _selectZodiac,
                    onOptionSelected: (value) {
                      setState(() {
                        _selectZodiac = value;
                      });
                      widget.callback(_selectZodiac);
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
