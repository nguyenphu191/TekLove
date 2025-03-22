import 'package:flutter/material.dart';
import 'package:tiklove_fe/theme/app_colors.dart';

class GymBox extends StatefulWidget {
  const GymBox({super.key, required this.gym, required this.callback});
  final String gym;
  final ValueChanged<String> callback;

  @override
  State<GymBox> createState() => _GymBoxState();
}

class _GymBoxState extends State<GymBox> {
  List<String> gyms = [
    "Tập luyện hằng ngày",
    "Tập vài lần mỗi tuần",
    "Tập không thường xuyên",
    "Chỉ tập khi có động lực",
    "Không tập thể dục",
    "Thích gym & thể hình",
    "Thích chạy bộ",
    "Thích yoga & thiền",
    "Thích bơi lội",
    "Thích thể thao ngoài trời",
    "Thích leo núi & trekking",
    "Thích khiêu vũ & nhảy múa",
    "Ưu tiên vận động nhẹ nhàng",
    "Chỉ tập khi có bạn tập"
  ];
  late String _select;
  @override
  void initState() {
    super.initState();
    _select = widget.gym;
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
              'Bạn có tập gym, chơi thể thao?',
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
                    options: gyms,
                    selectedOptions: _select,
                    onOptionSelected: (value) {
                      setState(() {
                        _select = value;
                      });
                      widget.callback(_select);
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
