import 'package:flutter/material.dart';
import 'package:tiklove_fe/theme/app_colors.dart';

class LoveLanguageBox extends StatefulWidget {
  const LoveLanguageBox(
      {super.key, required this.loveLanguage, required this.callback});
  final String loveLanguage;
  final ValueChanged<String> callback;

  @override
  State<LoveLanguageBox> createState() => _LoveLanguageBoxState();
}

class _LoveLanguageBoxState extends State<LoveLanguageBox> {
  List<String> loveLanguage = [
    'Lời nói yêu thương',
    'Dành thời gian',
    'Quà tặng',
    'Hành động giúp đỡ',
    'Tiếp xúc cơ thể '
  ];
  late String _selectLanguage;
  @override
  void initState() {
    super.initState();
    _selectLanguage = widget.loveLanguage;
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
              'Ngôn ngữ tình yêu của bạn là gì?',
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
                    options: loveLanguage,
                    selectedOptions: _selectLanguage,
                    onOptionSelected: (value) {
                      setState(() {
                        _selectLanguage = value;
                      });
                      widget.callback(_selectLanguage);
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
