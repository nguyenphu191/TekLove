import 'package:flutter/material.dart';
import 'package:tiklove_fe/models/Profile.dart';

class TopSendLove extends StatelessWidget {
  const TopSendLove({super.key, required this.candidate});
  final Profile candidate;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pix = size.width / 393;
    return Container(
      height: 80,
      width: size.width,
      padding: EdgeInsets.only(top: 16 * pix, left: 16 * pix, right: 16 * pix),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.close,
              color: Colors.black,
              size: 30 * pix,
            ),
          ),
          SizedBox(width: 16 * pix),
          Container(
            margin: EdgeInsets.only(top: 12 * pix),
            child: Text(
              'Gửi yêu cầu hẹn hò',
              style: TextStyle(
                fontSize: 16 * pix,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: 'BeVietnamPro',
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }
}
