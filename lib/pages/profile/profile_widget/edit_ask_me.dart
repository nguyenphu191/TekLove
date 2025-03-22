import 'package:flutter/material.dart';
import 'package:tiklove_fe/pages/profile/profile_widget/box_infor.dart';
import 'package:tiklove_fe/res/images/app_images.dart';

class EditAskMe extends StatefulWidget {
  const EditAskMe({super.key});

  @override
  State<EditAskMe> createState() => _EditAskMeState();
}

class _EditAskMeState extends State<EditAskMe> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pix = size.width / 393;
    return Column(
      children: [
        Container(
          height: 50 * pix,
          width: size.width,
          color: Colors.grey[200],
          padding: EdgeInsets.only(left: 16 * pix, top: 14 * pix),
          child: Text(
            'Hãy hỏi mình',
            style: TextStyle(
              fontSize: 16 * pix,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'BeVietnamPro',
            ),
            textAlign: TextAlign.left,
          ),
        ),
        BoxInfor(
            icon: AppImages.iconEditAirplane,
            title: "Chuyện đi chơi",
            content: '',
            callback: () {}),
        BoxInfor(
            icon: AppImages.iconEditCalendar,
            title: "Cuối tuần",
            content: '',
            callback: () {}),
        BoxInfor(
            icon: AppImages.iconEditMobile,
            title: "Dùng điện thoại",
            content: '',
            callback: () {}),
      ],
    );
  }
}
