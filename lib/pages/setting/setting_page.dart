import 'package:flutter/material.dart';
import 'package:tiklove_fe/pages/profile/profile_widget/edit_ask_me.dart';
import 'package:tiklove_fe/pages/profile/profile_widget/edit_audio.dart';
import 'package:tiklove_fe/pages/profile/profile_widget/edit_basic_info.dart';
import 'package:tiklove_fe/pages/profile/profile_widget/edit_intro.dart';
import 'package:tiklove_fe/pages/profile/profile_widget/edit_lifestyle.dart';
import 'package:tiklove_fe/pages/profile/profile_widget/edit_more_infor.dart';
import 'package:tiklove_fe/pages/profile/profile_widget/edit_slogen.dart';
import 'package:tiklove_fe/pages/setting/setting_acount.dart';
import 'package:tiklove_fe/pages/setting/setting_find.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key, required this.issetaccount});
  final bool issetaccount;

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pix = size.width / 393;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 80 * pix,
              width: size.width,
              color: Colors.white,
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Text(
                    'Cài đặt',
                    style: TextStyle(
                      fontSize: 20 * pix,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'BeVietnamPro',
                    ),
                  ),
                ],
              ),
            ),
            widget.issetaccount ? SettingAcount() : SettingFind(),
          ],
        ),
      ),
    );
  }
}
