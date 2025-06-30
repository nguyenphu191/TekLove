import 'package:flutter/material.dart';

class OptionWidget extends StatelessWidget {
  final String icon;
  final Color color;
  final double price;
  final double oldPrice;
  final String unit;
  final bool isSelected;
  final VoidCallback onTap;
  final int quantity;
  final String type;

  OptionWidget({
    required this.icon,
    required this.color,
    required this.isSelected,
    required this.onTap,
    required this.price,
    required this.unit,
    required this.quantity,
    required this.type,
    required this.oldPrice,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pix = size.width / 393;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 158 * pix,
        width: 115 * pix,
        padding: EdgeInsets.all(10 * pix),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.grey[200],
          border: isSelected
              ? Border.all(color: color, width: 2 * pix)
              : Border.all(
                  color: Colors.grey[300] ?? Colors.grey, width: 2 * pix),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  icon,
                  fit: BoxFit.contain,
                  height: 32 * pix,
                  width: 32 * pix,
                ),
                SizedBox(
                  width: 5 * pix,
                ),
                type != "premium"
                    ? Text(
                        'x$quantity',
                        style: TextStyle(
                            fontSize: 14 * pix,
                            color: Colors.black,
                            fontFamily: 'BeVietnamPro',
                            fontWeight: FontWeight.w600),
                      )
                    : Container(),
              ],
            ),
            SizedBox(
              height: 10 * pix,
            ),
            type == "premium"
                ? Text(
                    quantity < 30
                        ? "${(quantity / 7).toInt()} tuần"
                        : "${(quantity / 30).toInt()} tháng",
                    style: TextStyle(
                        fontSize: 16 * pix,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'BeVietnamPro'),
                  )
                : Container(),
            SizedBox(
              height: 10 * pix,
            ),
            Text(
              "${price.toInt()}đ/$unit",
              style: TextStyle(
                fontSize: 12 * pix,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 8 * pix,
            ),
            oldPrice != price
                ? Container(
                    child: Text(
                      "Tiết kiệm ${((oldPrice - price) / oldPrice * 100).toInt()}%",
                      style: TextStyle(
                        fontSize: 12 * pix,
                        color: color,
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
