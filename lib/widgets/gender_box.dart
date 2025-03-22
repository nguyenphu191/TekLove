import 'package:flutter/material.dart';

class GenderBox extends StatefulWidget {
  const GenderBox(
      {super.key,
      required this.onGenderSelected,
      required this.showGenderInProfile,
      required this.currentGender,
      required this.currentShowGenderInProfile});
  final ValueChanged<String> onGenderSelected; // Thêm callback
  final ValueChanged<bool> showGenderInProfile;
  final String currentGender;
  final bool currentShowGenderInProfile;
  @override
  State<GenderBox> createState() => _GenderBoxState();
}

class _GenderBoxState extends State<GenderBox> {
  late String selectedGender;
  late bool showGenderInProfile;
  @override
  void initState() {
    super.initState();
    selectedGender = widget.currentGender;
    showGenderInProfile = widget.currentShowGenderInProfile;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pix = size.width / 393;
    return Container(
      height: 229 * pix,
      width: double.maxFinite,
      child: Column(
        children: [
          Container(
            height: 32 * pix,
            width: double.maxFinite,
            child: Text(
              'Giới tính của bạn?',
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
            height: 110 * pix,
            width: double.maxFinite,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GenderOption(
                  label: 'Nam',
                  icon: 'assets/images/Teklove/male.png',
                  color: Colors.orange,
                  isSelected: selectedGender == 'Nam',
                  onTap: () {
                    setState(() {
                      selectedGender = 'Nam';
                    });
                    widget.onGenderSelected('Nam');
                  },
                ),
                GenderOption(
                  label: 'Nữ',
                  icon: 'assets/images/Teklove/female.png',
                  color: Colors.pink,
                  isSelected: selectedGender == 'Nữ',
                  onTap: () {
                    setState(() {
                      selectedGender = 'Nữ';
                    });
                    widget.onGenderSelected('Nữ');
                  },
                ),
                GenderOption(
                  label: 'Khác',
                  icon: 'assets/images/Teklove/profile.png',
                  color: Colors.green,
                  isSelected: selectedGender == 'Khác',
                  onTap: () {
                    setState(() {
                      selectedGender = 'Khác';
                    });
                    widget.onGenderSelected('Khác');
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 15 * pix),
          Container(
            height: 18 * pix,
            width: double.maxFinite,
            child: Row(
              children: [
                Transform.scale(
                  scale:
                      0.6, // Giảm kích thước, giá trị < 1 làm nhỏ hơn, giá trị > 1 làm lớn hơn
                  child: Switch(
                    value: showGenderInProfile,
                    onChanged: (value) {
                      setState(() {
                        showGenderInProfile = value;
                      });
                      widget.showGenderInProfile(value);
                    },
                  ),
                ),
                SizedBox(width: 5),
                Text(
                  'Hiển thị giới tính trên hồ sơ của bạn',
                  style: TextStyle(fontSize: 14 * pix),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class GenderOption extends StatelessWidget {
  final String label;
  final String icon;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  GenderOption({
    required this.label,
    required this.icon,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 110,
        width: 110,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: isSelected ? color.withOpacity(0.2) : Colors.grey[200],
          border: isSelected
              ? Border.all(color: color, width: 2)
              : Border.all(color: Colors.transparent),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Container(
              height: 75,
              width: 75,
              padding: EdgeInsets.all(5),
              child: Image.asset(
                icon,
                fit: BoxFit.contain,
              ),
            ),
            Container(
              height: 30,
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 15,
                  color: isSelected ? color : Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
