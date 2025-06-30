import 'package:flutter/material.dart';
import 'package:tiklove_fe/pages/discovery/discovery_page.dart';
import 'package:tiklove_fe/pages/home/home.dart';
import 'package:tiklove_fe/pages/like/like_page.dart';
import 'package:tiklove_fe/pages/message/chat_page.dart';
import 'package:tiklove_fe/pages/message/message_page.dart';
import 'package:tiklove_fe/pages/profile/profile_page.dart';
import 'package:tiklove_fe/res/images/app_images.dart';
import 'package:tiklove_fe/theme/app_colors.dart';

class LoveBottomBar extends StatefulWidget {
  final int type;
  const LoveBottomBar({super.key, required this.type});

  @override
  State<LoveBottomBar> createState() => _LoveBottomBarState();
}

class _LoveBottomBarState extends State<LoveBottomBar> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pix = size.width / 393;
    return SafeArea(
      child: Container(
        height: 64 * pix,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 16 * pix),
        child: Row(
          children: [
            Container(
              height: 64 * pix,
              width: 190 * pix,
              margin: EdgeInsets.only(left: 80 * pix),
              padding: EdgeInsets.symmetric(horizontal: 8 * pix),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 0, 0, 0),
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  color: const Color.fromARGB(255, 130, 130, 130),
                  width: 1 * pix,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    offset: Offset(0, 0),
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildActionButton(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage()));
                      },
                      image: AppImages.heart,
                      enabled: widget.type == 1 ? true : false),
                  _buildActionButton(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MessagePage()));
                      },
                      image: AppImages.messfavorite,
                      enabled: widget.type == 2 ? true : false),
                  _buildActionButton(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfilePage()));
                      },
                      image: AppImages.iconItemBottomVavigationUser,
                      enabled: widget.type == 3 ? true : false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required VoidCallback onTap,
    required String image,
    required bool enabled,
  }) {
    final size = MediaQuery.of(context).size;
    final pix = size.width / 393;
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 52 * pix,
        width: 52 * pix,
        decoration: BoxDecoration(
          color: enabled ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: Image.asset(image, width: 32 * pix, height: 32 * pix),
        ),
      ),
    );
  }
}
