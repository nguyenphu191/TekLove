import 'package:flutter/material.dart';
import 'package:tiklove_fe/theme/app_colors.dart';

class FindForBox extends StatefulWidget {
  const FindForBox({super.key, required this.onSelectedFindFor});
  final ValueChanged<String> onSelectedFindFor;
  @override
  State<FindForBox> createState() => _FindForBoxState();
}

class _FindForBoxState extends State<FindForBox> {
  String? findFor;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pix = size.width / 393;
    return Container(
      height: 449 * pix,
      width: double.maxFinite,
      child: Column(
        children: [
          Container(
            height: 32 * pix,
            width: double.maxFinite,
            child: Text(
              'Bạn đang tìm kiếm điều gì?',
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
            height: 10 * pix,
          ),
          Container(
            width: double.maxFinite,
            child: Text(
              'Nếu bạn thay đổi suy nghĩ thì cũng không sao. Sẽ luôn có ai đó phù hợp với mục đích của bạn',
              style: TextStyle(
                fontSize: 12 * pix,
                fontFamily: 'BeVietnamPro',
              ),
            ),
          ),
          SizedBox(
            height: 15 * pix,
          ),
          Expanded(
            child: Container(
              width: double.maxFinite,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GenderOption(
                        label: 'Người yêu',
                        icon: 'assets/images/Teklove/Finfor1.png',
                        color: AppColors.primary,
                        isSelected: findFor == 'Love',
                        onTap: () {
                          setState(() {
                            findFor = 'Love';
                          });
                          widget.onSelectedFindFor('Love');
                        },
                      ),
                      GenderOption(
                        label: 'Bạn hẹn hò lâu dài',
                        icon: 'assets/images/Teklove/Finfor2.png',
                        color: AppColors.primary,
                        isSelected: findFor == 'Dating',
                        onTap: () {
                          setState(() {
                            findFor = 'Dating';
                          });
                          widget.onSelectedFindFor('Dating');
                        },
                      ),
                      GenderOption(
                        label: 'Bất cứ điều gì có thể',
                        icon: 'assets/images/Teklove/Finfor3.png',
                        color: AppColors.primary,
                        isSelected: findFor == 'Every',
                        onTap: () {
                          setState(() {
                            findFor = 'Every';
                          });
                          widget.onSelectedFindFor('Every');
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10 * pix,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GenderOption(
                        label: 'Quan hệ không ràng buộc',
                        icon: 'assets/images/Teklove/Finfor4.png',
                        color: AppColors.primary,
                        isSelected: findFor == 'NoBinding',
                        onTap: () {
                          setState(() {
                            findFor = 'NoBinding';
                          });
                          widget.onSelectedFindFor('NoBinding');
                        },
                      ),
                      GenderOption(
                        label: 'Những người bạn mới',
                        icon: 'assets/images/Teklove/Finfor5.png',
                        color: AppColors.primary,
                        isSelected: findFor == 'Friends',
                        onTap: () {
                          setState(() {
                            findFor = 'Friends';
                          });
                          widget.onSelectedFindFor('Friends');
                        },
                      ),
                      GenderOption(
                        label: 'Mình chưa rõ lắm',
                        icon: 'assets/images/Teklove/Finfor6.png',
                        color: AppColors.primary,
                        isSelected: findFor == 'NotSure',
                        onTap: () {
                          setState(() {
                            findFor = 'NotSure';
                          });
                          widget.onSelectedFindFor('NotSure');
                        },
                      ),
                    ],
                  ),
                ],
              ),
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
    final size = MediaQuery.of(context).size;
    final pix = size.width / 393;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 136 * pix,
        width: 110 * pix,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.grey[200],
          border: isSelected
              ? Border.all(color: color, width: 2 * pix)
              : Border.all(color: Colors.transparent),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Container(
              height: 75 * pix,
              width: 75 * pix,
              padding: EdgeInsets.all(5 * pix),
              child: Image.asset(
                icon,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              height: 5 * pix,
            ),
            Container(
              height: 45 * pix,
              width: double.maxFinite,
              padding: EdgeInsets.only(left: 5 * pix),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 14 * pix,
                  color: isSelected ? color : Colors.black,
                ),
              ),
              alignment: Alignment.topCenter,
            ),
          ],
        ),
      ),
    );
  }
}
