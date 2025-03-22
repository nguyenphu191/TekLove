import 'package:flutter/material.dart';
import 'package:tiklove_fe/pages/profile/profile_widget/profile_card.dart';
import 'package:tiklove_fe/widgets/bottom_bar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pix = size.width / 393;
    return Scaffold(
        body: Stack(
      children: [
        Column(
          children: [
            Container(
              height: 700 * pix,
              width: size.width,
              color: Colors.white,
              margin: EdgeInsets.only(top: 10 * pix),
              padding: EdgeInsets.only(left: 8 * pix, right: 8 * pix),
              child: ProfileCard(),
            ),
          ],
        ),
        Positioned(
          bottom: 16,
          left: 0,
          right: 0,
          child: BottomBar(
            type: 5,
          ),
        ),
      ],
    ));
  }
}
