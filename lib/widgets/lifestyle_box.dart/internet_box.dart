import 'package:flutter/material.dart';
import 'package:tiklove_fe/theme/app_colors.dart';

class InternetBox extends StatefulWidget {
  const InternetBox(
      {super.key, required this.internet, required this.callback});
  final String internet;
  final ValueChanged<String> callback;

  @override
  State<InternetBox> createState() => _InternetBoxState();
}

class _InternetBoxState extends State<InternetBox> {
  List<String> ins = [
    "Thường xuyên online",
    "Chỉ dùng khi cần thiết",
    "Chia sẻ mọi khoảnh khắc",
    "Thích lướt nhưng ít đăng",
    "Thích xem video ngắn (Reels, TikTok...)",
    "Thích tranh luận trên mạng",
    "Thích đăng story",
    "Ưu tiên gặp mặt trực tiếp hơn",
    "Ít hoặc không dùng mạng xã hội",
    "Chỉ dùng để làm việc",
    "Thích nhắn tin hơn gọi điện",
    "Thích gọi video hơn nhắn tin"
  ];
  late String _select;
  @override
  void initState() {
    super.initState();
    _select = widget.internet;
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
              'Bạn có dùng mạng xã hội khác?',
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
                    options: ins,
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
