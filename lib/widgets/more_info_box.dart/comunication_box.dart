import 'package:flutter/material.dart';
import 'package:tiklove_fe/theme/app_colors.dart';

class ComunicationBox extends StatefulWidget {
  const ComunicationBox(
      {super.key, required this.comunication, required this.callback});
  final String comunication;
  final ValueChanged<String> callback;

  @override
  State<ComunicationBox> createState() => _ComunicationBoxState();
}

class _ComunicationBoxState extends State<ComunicationBox> {
  List<String> _communication = [
    "Hài hước",
    "Lịch sự",
    "Chân thành",
    "Táo bạo",
    "Lãng mạn",
    "Thẳng thắn",
    "Hòa đồng",
    "Bí ẩn",
    "Thực tế",
    "Sáng tạo",
    "Tinh tế",
    "Sôi nổi",
    "Nhẹ nhàng",
    "Hòa nhã",
    "Thú vị",
    "Nghiêm túc",
    "Ngọt ngào",
    "Dịu dàng",
    "Hướng ngoại",
    "Hướng nội"
  ];
  late String _selectCommunication;
  @override
  void initState() {
    super.initState();
    _selectCommunication = widget.comunication;
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
              'Phong cách giao tiếp của bạn là gì?',
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
                    options: _communication,
                    selectedOptions: _selectCommunication,
                    onOptionSelected: (value) {
                      setState(() {
                        _selectCommunication = value;
                      });
                      widget.callback(_selectCommunication);
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
