import 'package:flutter/material.dart';
import 'package:tiklove_fe/models/Profile.dart';
import 'package:tiklove_fe/res/images/app_images.dart';
import 'package:tiklove_fe/utils.dart' as utils;

class CoupleCard extends StatelessWidget {
  const CoupleCard(
      {super.key,
      required this.type,
      required this.myProfile,
      required this.candidate});
  final String type;
  final Profile myProfile;
  final Profile candidate;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pix = size.width / 393;
    final String imgUrl = utils.imgUrl;
    return Container(
      height: 160 * pix,
      width: 274 * pix,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              height: 160 * pix,
              width: 160 * pix,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
                image: DecorationImage(
                  image: NetworkImage('$imgUrl/${candidate.images[0]}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              height: 160 * pix,
              width: 160 * pix,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
                image: DecorationImage(
                  image: NetworkImage('$imgUrl/${myProfile.images[0]}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          this.type == 'love'
              ? Positioned(
                  bottom: 0,
                  left: 114 * pix,
                  child: Container(
                    width: 46 * pix,
                    height: 46 * pix,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(AppImages.iconHeartCircle),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
