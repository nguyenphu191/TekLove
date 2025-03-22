import 'package:flutter/material.dart';
import 'package:tiklove_fe/theme/app_colors.dart';

class EatBox extends StatefulWidget {
  const EatBox({
    super.key,
    required this.eat,
    required this.callback,
  });
  final String eat;
  final ValueChanged<String> callback;

  @override
  State<EatBox> createState() => _EatBoxState();
}

class _EatBoxState extends State<EatBox> {
  List<String> eats = [
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
  ];
  late String _select;
  @override
  void initState() {
    super.initState();
    _select = widget.eat;
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
              'Chế độ ăn của bạn?',
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
                    options: eats,
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
