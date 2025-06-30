import 'package:flutter/material.dart';

class SexualBox extends StatefulWidget {
  const SexualBox(
      {super.key,
      required this.onSexualSelected,
      required this.showSexInProfile,
      required this.currentshowSexInProfile,
      required this.currentselectedSexual});
  final ValueChanged<String> onSexualSelected;
  final ValueChanged<bool> showSexInProfile;
  final bool currentshowSexInProfile;
  final String currentselectedSexual;

  @override
  State<SexualBox> createState() => _SexualBoxState();
}

class _SexualBoxState extends State<SexualBox> {
  late bool _showSexInProfile;
  late String _selectedSexual;
  final Map<String, bool> _options = {
    'Dị tính': false,
    'Đồng tính': false,
    'Đồng tính nữ': false,
    'Song tính': false,
    'Vô tính': false,
    'Á tính': false,
    'Toàn tính': false,
    'Queer': false,
  };
  @override
  void initState() {
    super.initState();
    _showSexInProfile = widget.currentshowSexInProfile;
    _selectedSexual = widget.currentselectedSexual;
  }

  void _showInfo(String option) {
    String infoMessage;

    // Cung cấp thông tin cho từng loại
    switch (option) {
      case 'Dị tính':
        infoMessage = 'Thông tin về Dị tính.';
        break;
      case 'Đồng tính':
        infoMessage = 'Thông tin về Đồng tính.';
        break;
      case 'Đồng tính nữ':
        infoMessage = 'Thông tin về Đồng tính nữ.';
        break;
      case 'Song tính':
        infoMessage = 'Thông tin về Song tính.';
        break;
      case 'Vô tính':
        infoMessage = 'Thông tin về Vô tính.';
        break;
      case 'Á tính':
        infoMessage = 'Thông tin về Á tính.';
        break;
      case 'Toàn tính':
        infoMessage = 'Thông tin về Toàn tính.';
        break;
      case 'Queer':
        infoMessage = 'Thông tin về Queer.';
        break;
      default:
        infoMessage = 'Thông tin không có.';
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(infoMessage)),
    );
  }

  void _onCheckboxChanged(String option, bool? value) {
    setState(() {
      _options.updateAll((key, val) => false);
      _options[option] = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pix = size.width / 393;
    return Column(
      children: [
        Container(
          height: 32 * pix,
          width: double.maxFinite,
          child: Text(
            'Khuynh hướng tình dục của bạn?',
            style: TextStyle(
              fontSize: 20 * pix,
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontFamily: 'BeVietnamPro',
            ),
            textAlign: TextAlign.left,
          ),
        ),
        SizedBox(
          height: 15 * pix,
        ),
        Container(
          height: 330 * pix,
          child: ListView(
            children: _options.keys.map((String option) {
              return CustomCheckbox(
                title: option,
                value: _options[option] ?? false,
                onChanged: (bool? value) {
                  _onCheckboxChanged(option, value);
                  widget.onSexualSelected(option);
                },
                onInfoTap: () => _showInfo(option),
              );
            }).toList(),
          ),
        ),
        SizedBox(
          height: 10 * pix,
        ),
        Container(
          height: 30 * pix,
          width: double.maxFinite,
          padding: EdgeInsets.only(top: 6 * pix, bottom: 6 * pix),
          child: Row(
            children: [
              Transform.scale(
                scale:
                    0.6, // Giảm kích thước, giá trị < 1 làm nhỏ hơn, giá trị > 1 làm lớn hơn
                child: Switch(
                  value: _showSexInProfile,
                  onChanged: (value) {
                    setState(() {
                      _showSexInProfile = value;
                    });
                    widget.showSexInProfile(value);
                  },
                ),
              ),
              SizedBox(width: 5 * pix),
              Text(
                'Hiển thị khuynh hướng trên hồ sơ của bạn',
                style: TextStyle(fontSize: 12 * pix, color: Colors.black),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomCheckbox extends StatelessWidget {
  final String title;
  final bool value;
  final ValueChanged<bool?> onChanged;
  final VoidCallback onInfoTap;

  CustomCheckbox({
    required this.title,
    required this.value,
    required this.onChanged,
    required this.onInfoTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
        ),
        Text(title),
        IconButton(
          icon: Icon(Icons.help_outline),
          onPressed: onInfoTap,
        ),
      ],
    );
  }
}
