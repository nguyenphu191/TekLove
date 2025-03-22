import 'package:flutter/material.dart';
import 'package:tiklove_fe/theme/app_colors.dart';

class LanguageBox extends StatefulWidget {
  const LanguageBox(
      {super.key, required this.onSelected, required this.current});
  final ValueChanged<List<String>> onSelected;
  final List<String> current;

  @override
  State<LanguageBox> createState() => _LanguageBoxState();
}

class _LanguageBoxState extends State<LanguageBox> {
  TextEditingController _controller = TextEditingController();
  List<String> _options = [
    "Tiếng Việt",
    "Tiếng Anh",
    "Tiếng Pháp",
    "Tiếng Tây Ban Nha",
    "Tiếng Đức",
    "Tiếng Trung",
    "Tiếng Nhật",
    "Tiếng Hàn",
    "Tiếng Nga",
    "Tiếng Ả Rập"
  ];
  List<String> _selectedOptions = [];
  List<String> _filteredOptions = [];
  void _toggleSelection(String value) {
    setState(() {
      if (_selectedOptions.contains(value)) {
        _selectedOptions.remove(value);
      } else {
        _selectedOptions.add(value);
      }
      widget.onSelected(
          List.from(_selectedOptions)); // ✅ Gửi dữ liệu ngay khi cập nhật
    });
  }

  void _filterOptions(String keyword) {
    setState(() {
      if (keyword.isEmpty) {
        _filteredOptions = _options;
      } else {
        _filteredOptions = _options
            .where((option) =>
                option.toLowerCase().contains(keyword.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _filteredOptions =
        _options; // Khởi tạo danh sách hiển thị toàn bộ danh sách
    _selectedOptions = widget.current; // Khởi tạo danh sách đã chọn từ widget
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
              'Ngôn ngữ của bạn?',
              style: TextStyle(
                fontSize: 20 * pix,
                color: const Color.fromARGB(255, 53, 39, 39),
                fontWeight: FontWeight.bold,
                fontFamily: 'BeVietnamPro',
              ),
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(height: 10 * pix),
          Container(
            width: double.maxFinite,
            child: Text(
              'Bạn thành thạo những ngôn ngữ nào, giờ hãy cho mọi người cùng biết nhé',
              style: TextStyle(
                fontSize: 12 * pix,
                fontFamily: 'BeVietnamPro',
              ),
            ),
          ),
          SizedBox(height: 10 * pix),
          Divider(),
          SizedBox(height: 10 * pix),
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
                            controller: _controller,
                            keyboardType: TextInputType.text,
                            onChanged: _filterOptions,
                            decoration: InputDecoration(
                              hintText: 'Tìm kiếm ',
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
                    options: _filteredOptions,
                    selectedOptions: _selectedOptions,
                    onOptionSelected: _toggleSelection,
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
          onPressed: () {
            setState(() {
              onOptionSelected(option);
              widget.onSelected(_selectedOptions);
            });
          },
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
