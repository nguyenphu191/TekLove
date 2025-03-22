import 'package:flutter/material.dart';
import 'package:tiklove_fe/theme/app_colors.dart';

class DrinkBox extends StatefulWidget {
  const DrinkBox({super.key, required this.drink, required this.callback});
  final String drink;
  final ValueChanged<String> callback;

  @override
  State<DrinkBox> createState() => _DrinkBoxState();
}

class _DrinkBoxState extends State<DrinkBox> {
  List<String> drinks = [
    "Không bao giờ uống",
    "Hiếm khi uống",
    "Chỉ uống vào dịp đặc biệt",
    "Thỉnh thoảng uống",
    "Thường xuyên uống",
    "Uống xã giao",
    "Không uống nhưng không ngại người khác uống"
  ];
  late String _select;
  @override
  void initState() {
    super.initState();
    _select = widget.drink;
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
              'Bạn có uống được rượu?',
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
                    options: drinks,
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
