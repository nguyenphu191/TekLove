import 'package:flutter/material.dart';
import 'package:tiklove_fe/models/Profile.dart';
import 'package:tiklove_fe/pages/love/request_love/couple_card.dart';
import 'package:tiklove_fe/res/images/app_images.dart';
import 'package:tiklove_fe/theme/app_colors.dart';

class SendMatch extends StatefulWidget {
  const SendMatch(
      {super.key, required this.myProfile, required this.candidate});
  final Profile myProfile;
  final Profile candidate;
  @override
  State<SendMatch> createState() => _SendMatchState();
}

class _SendMatchState extends State<SendMatch> {
  @override
  Widget build(BuildContext context) {
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
                image: AssetImage(AppImages.matchBackground),
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
                  image: AssetImage(AppImages.match),
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
                  type: 'match',
                  myProfile: widget.myProfile,
                  candidate: widget.candidate,
                ),
                SizedBox(
                  height: 24 * pix,
                ),
                Text(
                  'Bạn đã tương hợp với ${widget.candidate.name}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16 * pix,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'BeVietnamPro',
                  ),
                ),
                SizedBox(
                  height: 18 * pix,
                ),
              ],
            ),
          ),
          Positioned(
            top: 500 * pix,
            left: 16 * pix,
            right: 16 * pix,
            child: Column(
              children: [
                Container(
                  height: 56 * pix,
                  width: size.width - 32 * pix,
                  padding: EdgeInsets.only(left: 16 * pix, right: 16 * pix),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 56 * pix,
                        width: size.width - 100 * pix,
                        padding: EdgeInsets.only(top: 5 * pix),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Gửi lời chào đến nhau',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 16 * pix,
                              fontFamily: 'BeVietnamPro',
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(left: 16 * pix),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          height: pix * 36,
                          width: 36 * pix,
                          child: Image.asset(AppImages.iconSend,
                              width: 36 * pix, height: 36 * pix),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 16 * pix,
                ),
                Container(
                  height: 56 * pix,
                  width: size.width - 32 * pix,
                  padding: EdgeInsets.only(left: 16 * pix, right: 16 * pix),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        AppImages.newFriends,
                        width: 36 * pix,
                        height: 36 * pix,
                      ),
                      Image.asset(
                        AppImages.rectangle_333,
                        width: 36 * pix,
                        height: 36 * pix,
                      ),
                      Image.asset(
                        AppImages.rectangle_334,
                        width: 36 * pix,
                        height: 36 * pix,
                      ),
                      Image.asset(
                        AppImages.rectangle_335,
                        width: 36 * pix,
                        height: 36 * pix,
                      ),
                      Image.asset(
                        AppImages.rectangle_336,
                        width: 36 * pix,
                        height: 36 * pix,
                      ),
                      Image.asset(
                        AppImages.rectangle_337,
                        width: 36 * pix,
                        height: 36 * pix,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
