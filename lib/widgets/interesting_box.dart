import 'package:flutter/material.dart';
import 'package:tiklove_fe/theme/app_colors.dart';

class InterestingBox extends StatefulWidget {
  const InterestingBox(
      {super.key, required this.onSelected, required this.currentInterests});
  final ValueChanged<List<String>> onSelected;
  final List<String> currentInterests;

  @override
  State<InterestingBox> createState() => _InterestingBoxState();
}

class _InterestingBoxState extends State<InterestingBox> {
  TextEditingController _controller = TextEditingController();
  List<String> _options = [
    "Đi du lịch",
    "Nghe nhạc",
    "Chơi thể thao",
    "Đọc sách",
    "Nấu ăn",
    "Xem phim",
    "Thể dục thể thao",
    "Chụp ảnh",
    "Khám phá ẩm thực",
    "Chơi game",
    "Học ngoại ngữ",
    "Tham gia các hoạt động tình nguyện",
    "Vẽ tranh",
    "Ngắm cảnh thiên nhiên",
    "Tham gia các lớp học yoga",
    "Đi bộ đường dài",
    "Thử sức với các môn thể thao mạo hiểm",
    "Làm vườn",
    "Tìm hiểu về công nghệ",
    "Xem các chương trình truyền hình thực tế",
    "Tham dự concert và lễ hội âm nhạc",
    "Nghe podcast",
    "Chơi nhạc cụ",
    "Tham gia các buổi thảo luận, hội thảo",
    "Khám phá văn hóa địa phương",
    "Chơi cờ (cờ vua, cờ tướng, v.v.)",
    "Tập luyện thể hình",
    "Thử sức với những món ăn mới",
    "Xem video hài hước",
    "Chơi thể thao mạo hiểm (như lướt sóng, leo núi)",
    "Tham gia các hoạt động ngoài trời (cắm trại, picnic)",
    "Xem các bộ phim tài liệu",
    "Chơi các trò chơi Board game với bạn bè",
    "Luyện tập thiền",
    "Viết nhật ký hoặc viết blog",
    "Tham gia vào các cuộc thi (hội thi nấu ăn, tài năng, v.v.)",
    "Khám phá các địa danh lịch sử",
    "Chơi các môn thể thao đội (bóng đá, bóng rổ, v.v.)",
    "Tham gia các lớp học nghệ thuật (như làm gốm)",
    "Thao tác trên mạng xã hội",
    "Tìm hiểu về tâm lý học",
    "Thử sức với các hoạt động mạo hiểm như nhảy bungee",
    "Làm thủ công mỹ nghệ (DIY)",
    "Tham gia các diễn đàn trực tuyến về sở thích cá nhân",
    "Xem các chương trình hài kịch",
    "Tham gia vào các nhóm cộng đồng trực tuyến",
    "Dạy học hoặc hướng dẫn (trong lĩnh vực của bạn)",
    "Đi xe đạp đường dài",
    "Khám phá nhiếp ảnh phong cảnh"
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
    _selectedOptions =
        widget.currentInterests; // Khởi tạo danh sách đã chọn từ widget
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
            height: 52 * pix,
            width: double.maxFinite,
            child: Text(
              'Bạn thích điều gì?(Có thể chọn nhiều)',
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
              'Bạn có những sở thích của mình, giờ hãy cho mọi người cùng biết nhé',
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
