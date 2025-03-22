import 'package:flutter/material.dart';
import 'package:tiklove_fe/theme/app_colors.dart';

class SleepBox extends StatefulWidget {
  const SleepBox({super.key, required this.sleep, required this.callback});
  final String sleep;
  final ValueChanged<String> callback;

  @override
  State<SleepBox> createState() => _SleepBoxState();
}

class _SleepBoxState extends State<SleepBox> {
  List<String> sleepstyles = [
    'Ngủ một mình',
    'Ngủ cùng người yêu',
    'Ngủ với gấu bông',
    'Ngủ với thú cưng',
    'Ngủ vắt chân',
    'Ngủ nhiều gối',
    'Ngủ nhiều chăn',
    'Thích ngủ nệm cứng',
    'Thích ngủ nệm mềm',
    'Thích ngủ nệm êm',
    'Thích ngủ nệm lò xo',
  ];
  late String _selectSleep;
  @override
  void initState() {
    super.initState();
    _selectSleep = widget.sleep;
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
              'Phong cách ngủ của bạn là gì?',
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
                    options: sleepstyles,
                    selectedOptions: _selectSleep,
                    onOptionSelected: (value) {
                      setState(() {
                        _selectSleep = value;
                      });
                      widget.callback(_selectSleep);
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
