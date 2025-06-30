import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiklove_fe/pages/love/love/love_widget/love_bottom_bar.dart';
import 'package:tiklove_fe/pages/profile/profile_widget/profile_card.dart';
import 'package:tiklove_fe/provider/ProfileProvider.dart';
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
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    final profile = profileProvider.profile;
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
          bottom: 16 * pix,
          left: 0,
          right: 0,
          child: profile!.isLove
              ? LoveBottomBar(type: 3)
              : BottomBar(
                  type: 5,
                ),
        ),
      ],
    ));
  }
}
