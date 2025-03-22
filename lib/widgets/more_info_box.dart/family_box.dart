import 'package:flutter/material.dart';
import 'package:tiklove_fe/theme/app_colors.dart';

class FamilyBox extends StatefulWidget {
  const FamilyBox({
    super.key,
    required this.family,
    required this.callback,
  });
  final String family;
  final ValueChanged<String> callback;

  @override
  State<FamilyBox> createState() => _FamilyBoxState();
}

class _FamilyBoxState extends State<FamilyBox> {
  List<String> _family = [
    "Muốn có con",
    "Không muốn có con",
    "Chưa quyết định",
    "Có con rồi",
    "Muốn nhận con nuôi",
    "Muốn có gia đình lớn",
    "Muốn có gia đình nhỏ",
    "Ưu tiên sự nghiệp trước",
    "Cởi mở về tương lai",
    "Sống cùng gia đình nhiều thế hệ"
  ];
  late String _selectFamily;
  @override
  void initState() {
    super.initState();
    _selectFamily = widget.family;
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
              'Gia đình trong tương lai của bạn là gì?',
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
                    options: _family,
                    selectedOptions: _selectFamily,
                    onOptionSelected: (value) {
                      setState(() {
                        _selectFamily = value;
                      });
                      widget.callback(_selectFamily);
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
