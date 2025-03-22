import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiklove_fe/models/Profile.dart';
import 'package:tiklove_fe/pages/love/request_love/couple_card.dart';
import 'package:tiklove_fe/provider/ProfileProvider.dart';
import 'package:tiklove_fe/res/images/app_images.dart';
import 'package:tiklove_fe/theme/app_colors.dart';

class SuccessLove extends StatefulWidget {
  const SuccessLove({super.key, required this.candidate});
  final Profile candidate;

  @override
  State<SuccessLove> createState() => _SuccessLoveState();
}

class _SuccessLoveState extends State<SuccessLove> {
  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    final myProfile = profileProvider.profile;
    final size = MediaQuery.of(context).size;
    final pix = size.width / 393;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: size.height,
            width: size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.requestDate),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 56 * pix,
              width: size.width,
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 16 * pix, top: 16 * pix),
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.close,
                    size: 30 * pix,
                    color: Colors.white,
                  )),
            ),
          ),
          Positioned(
            top: 80 * pix,
            left: (size.width - 245 * pix) / 2,
            right: (size.width - 245 * pix) / 2,
            child: Container(
              width: 245 * pix,
              height: 170 * pix,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImages.matchlove),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            top: 260 * pix,
            left: (size.width - 274 * pix) / 2,
            child: Column(
              children: [
                CoupleCard(
                  type: 'love',
                  candidate: widget.candidate,
                  myProfile: myProfile!,
                ),
                SizedBox(
                  height: 24 * pix,
                ),
                Text(
                  'Bạn đã hẹn hò với ${widget.candidate.name}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16 * pix,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'BeVietnamPro',
                  ),
                ),
                SizedBox(
                  height: 8 * pix,
                ),
                Text(
                  'Đã chuyển sang chế độ tập trung hẹn hò',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14 * pix,
                    fontFamily: 'BeVietnamPro',
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              bottom: 16 * pix,
              left: 16 * pix,
              right: 16 * pix,
              child: Container(
                height: 56 * pix,
                width: 361 * pix,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 56 * pix,
                        width: 176 * pix,
                        padding: EdgeInsets.only(top: 16 * pix),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Text(
                          'Nhắn tin',
                          style: TextStyle(
                            fontSize: 16 * pix,
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'BeVietnamPro',
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        height: 56 * pix,
                        width: 176 * pix,
                        padding: EdgeInsets.only(top: 16 * pix),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(0.5),
                              offset: Offset(0, 3),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Text(
                          'Chia sẻ',
                          style: TextStyle(
                            fontSize: 16 * pix,
                            color: const Color.fromARGB(255, 255, 255, 255),
                            fontFamily: 'BeVietnamPro',
                            fontWeight: FontWeight.w300,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
