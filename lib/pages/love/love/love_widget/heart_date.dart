import 'dart:ui';

import 'package:flutter/material.dart';

class HeartDate extends StatefulWidget {
  const HeartDate({super.key, required this.daysTogether});
  final String daysTogether;

  @override
  State<HeartDate> createState() => _HeartDateState();
}

class _HeartDateState extends State<HeartDate> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pix = size.width / 393;

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 159 * pix,
        width: 159 * pix,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(Icons.favorite,
                size: 180 * pix,
                color: Colors.white.withOpacity(0.3)), // Icon trái tim lớn

            // Văn bản hiển thị số ngày
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 10 * pix),
                Text(
                  "Bên nhau",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14 * pix,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'BeVietnamPro'),
                ),
                Text(
                  "${widget.daysTogether}",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 36 * pix,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "ngày",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14 * pix,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'BeVietnamPro'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
