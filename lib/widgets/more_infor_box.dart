import 'package:flutter/material.dart';
import 'package:tiklove_fe/theme/app_colors.dart';

class MoreInforBox extends StatefulWidget {
  const MoreInforBox({super.key});

  @override
  State<MoreInforBox> createState() => _MoreInforBoxState();
}

class _MoreInforBoxState extends State<MoreInforBox> {
  List<String> _options = [
    "Không dành cho mình",
    "Luôn tỉnh táo",
    "Uống có trách nhiệm",
    "Chỉ dịp đặc biệt",
    "Uống giao lưu cuối tuần",
    "Hầu như mỗi tối",
    "Không dành cho mình",
    "Luôn tỉnh táo",
    "Uống có trách nhiệm",
    "Chỉ dịp đặc biệt",
    "Uống giao lưu cuối tuần",
    "Hầu như mỗi tối"
  ];
  List<String> _selectedOptions = [];
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
              'Bạn thích điều gì?',
              style: TextStyle(
                fontSize: 20 * pix,
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
          Container(
            width: double.maxFinite,
            child: Text(
              'Bạn có những sở thích của mình, giờ hãy cho mọi người cùng biết nhé',
              style: TextStyle(
                fontSize: 12 * pix,
                fontFamily: 'BeVietnamPro',
              ),
            ),
          ),
          SizedBox(
            height: 10 * pix,
          ),
          Container(
            width: double.maxFinite,
            child: Text(
              'Bỏ qua',
              style: TextStyle(
                fontSize: 15 * pix,
                fontFamily: 'BeVietnamPro',
                color: Color(0xFFFF295F),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 15 * pix,
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
                  Container(
                    height: 46 * pix,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 300 * pix,
                          height: 46 * pix,
                          padding: EdgeInsets.only(left: 10 * pix),
                          child: TextField(
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              hintText: 'Tìm kiếm sở thích',
                              hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'BeVietnamPro'),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        SizedBox(width: 10 * pix),
                        Expanded(
                          child: Container(
                            height: 46 * pix,
                            width: 40 * pix,
                            child: IconButton(
                                onPressed: () {}, icon: Icon(Icons.search)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16 * pix),
                  _buildQuestion(
                    options: _options,
                    selectedOptions: _selectedOptions,
                    onOptionSelected: (value) {
                      setState(() {
                        _selectedOptions.contains(value)
                            ? _selectedOptions.remove(value)
                            : _selectedOptions.add(value);
                      });
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
    required List<String> selectedOptions,
    required Function(String) onOptionSelected,
  }) {
    return Wrap(
      spacing: 5,
      runSpacing: -8,
      children: options.map((option) {
        final isSelected = selectedOptions.contains(option);
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
