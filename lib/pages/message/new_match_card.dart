import 'package:flutter/material.dart';
import 'package:tiklove_fe/res/images/app_images.dart';
import 'package:tiklove_fe/theme/app_colors.dart';
import 'package:tiklove_fe/utils.dart' as utils;

class NewMatchCard extends StatelessWidget {
  const NewMatchCard({super.key, required this.match});
  final Map<String, dynamic> match;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pix = size.width / 393;
    final String baseurl = utils.imgUrl;
    return Container(
      height: 138 * pix,
      width: 99 * pix,
      margin: EdgeInsets.only(left: 16 * pix),
      padding: EdgeInsets.all(8 * pix),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 220, 220, 220),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.accent,
          width: 2 * pix,
        ),
        image: DecorationImage(
          image: NetworkImage('$baseurl/${match['image']}'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 10 * pix,
            left: 0,
            right: 0,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: pix * 99,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    match['name'],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12 * pix,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  match['verified']
                      ? Image.asset(
                          AppImages.iconVerify,
                          height: 14 * pix,
                          width: 14 * pix,
                        )
                      : Container(
                          height: 14 * pix,
                          width: 14 * pix,
                        )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
