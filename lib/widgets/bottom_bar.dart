import 'package:flutter/material.dart';
import 'package:tiklove_fe/pages/discovery/discovery_page.dart';
import 'package:tiklove_fe/pages/like/like_page.dart';
import 'package:tiklove_fe/pages/message/message_page.dart';
import 'package:tiklove_fe/pages/home/home.dart';
import 'package:tiklove_fe/pages/profile/profile_page.dart';
import 'package:tiklove_fe/res/images/app_images.dart';
import 'package:tiklove_fe/theme/app_colors.dart';

class BottomBar extends StatefulWidget {
  final int type;
  const BottomBar({super.key, required this.type});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> with TickerProviderStateMixin {
  final _isSpeed = false;
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
              width: 285 * pix,
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
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage()));
                      },
                      image: AppImages.iconItemBottomVavigationSearch,
                      enabled: widget.type == 1 ? true : false),
                  _buildActionButton(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DiscoveryPage()));
                      },
                      image: AppImages.iconItemBottomVavigationCategory,
                      enabled: widget.type == 2 ? true : false),
                  _buildActionButton(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LikePage()));
                      },
                      image: AppImages.iconItemBottomVavigationLike,
                      enabled: widget.type == 3 ? true : false),
                  _buildActionButton(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MessagePage()));
                      },
                      image: AppImages.iconItemBottomVavigationMessage,
                      enabled: widget.type == 4 ? true : false),
                  _buildActionButton(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfilePage()));
                      },
                      image: AppImages.iconItemBottomVavigationUser,
                      enabled: widget.type == 5 ? true : false),
                ],
              ),
            ),
            SizedBox(width: 16 * pix),
            Container(
              height: 48 * pix,
              width: 48 * pix,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 0, 0, 0),
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  color: const Color.fromARGB(255, 242, 130, 11),
                  width: 2 * pix,
                ),
              ),
              child: (_isSpeed == true)
                  ? Text(
                      '23',
                      style: TextStyle(
                          fontSize: 18 * pix,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    )
                  : Image.asset(
                      'assets/images/Teklove/Property 1=Speed, Style=3D.png'),
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
