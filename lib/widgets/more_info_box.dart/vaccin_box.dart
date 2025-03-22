import 'package:flutter/material.dart';
import 'package:tiklove_fe/theme/app_colors.dart';

class VaccinBox extends StatefulWidget {
  const VaccinBox({super.key, required this.vaccin, required this.callback});
  final String vaccin;
  final ValueChanged<String> callback;

  @override
  State<VaccinBox> createState() => _VaccinBoxState();
}

class _VaccinBoxState extends State<VaccinBox> {
  List<String> _vaccine = [
    'Đã tiêm 1 mũi',
    'Đã tiêm 2 mũi',
    'Chưa tiêm',
    'Không tiêm'
  ];
  late String _selectVaccine;
  @override
  void initState() {
    super.initState();
    _selectVaccine = widget.vaccin;
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
              'Bạn đã tiêm vaccin?',
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
                    options: _vaccine,
                    selectedOptions: _selectVaccine,
                    onOptionSelected: (value) {
                      setState(() {
                        _selectVaccine = value;
                      });
                      widget.callback(_selectVaccine);
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
