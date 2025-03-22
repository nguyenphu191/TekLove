import 'package:flutter/material.dart';
import 'package:tiklove_fe/theme/app_colors.dart';

class PetBox extends StatefulWidget {
  const PetBox({
    super.key,
    required this.pet,
    required this.callback,
  });
  final String pet;
  final ValueChanged<String> callback;

  @override
  State<PetBox> createState() => _PetBoxState();
}

class _PetBoxState extends State<PetBox> {
  List<String> pets = [
    'Chó',
    'Mèo',
    'Chim',
    'Cá',
    'Gà'
        'Vịt',
    'Lợn',
    'Rắn',
    'Nhện',
    'Chuột',
    'Bò sát',
    'Không nuôi thú cưng',
    "Yêu thích động vật nhưng chưa nuôi",
    "Dị ứng với động vật",
    'Khác'
  ];
  late String _select;
  @override
  void initState() {
    super.initState();
    _select = widget.pet;
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
              'Bạn có nuôi pets?',
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
                    options: pets,
                    selectedOptions: _select,
                    onOptionSelected: (option) {
                      setState(() {
                        _select = option;
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
