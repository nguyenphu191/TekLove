import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tiklove_fe/models/Profile.dart';
import 'package:tiklove_fe/pages/home/detail.dart';
import 'package:tiklove_fe/provider/ProfileProvider.dart';
import 'package:tiklove_fe/res/fonts/app_fonts.dart';
import 'package:tiklove_fe/res/images/app_images.dart';
import 'package:tiklove_fe/theme/app_colors.dart';
import 'package:tiklove_fe/utils.dart' as utils;

class LikeCard extends StatelessWidget {
  const LikeCard(
      {super.key,
      required this.candidate,
      this.isSuper = false,
      this.isVip = false,
      this.isLiked = false});
  final Map<String, dynamic> candidate;
  final bool isSuper;
  final bool isVip;
  final bool isLiked;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pix = size.width / 393;
    final String baseurl = utils.imgUrl;
    final profileProvider = Provider.of<ProfileProvider>(context);
    return InkWell(
      onTap: () async {
        final candidate = await profileProvider.getProfileById(
            this.candidate['accountId'], context);
        candidate != null
            ? isVip
                ? profileProvider.profile != null &&
                        checkCanMatch(profileProvider.profile!, candidate)
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailPage(
                                  candidate: candidate,
                                  isMyProfile: false,
                                  canMatch: true,
                                )))
                    : Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailPage(
                                  candidate: candidate,
                                  isMyProfile: false,
                                  canMatch: false,
                                )))
                : ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Đăng ký premium để xem thông tin chi tiết'),
                  ))
            : ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Không thể tải thông tin người dùng'),
              ));
      },
      child: Container(
        height: 269 * pix,
        width: 177 * pix,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 234, 125, 125),
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: this.candidate['image'] != null
                ? Image.network(
                    '$baseurl/${this.candidate['image']}',
                  ).image
                : Image.asset(AppImages.userUnknown).image,
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            isVip == false
                ? Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: ImageFiltered(
                        imageFilter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                        child: Container(
                          color: Colors.grey.withOpacity(0.9),
                        ),
                      ),
                    ),
                  )
                : SizedBox.shrink(),
            Positioned(
              top: 10,
              left: 10,
              right: 10,
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children: this.candidate['interests'].length > 5
                        ? List.generate(
                            5,
                            (index) => Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                index == 4
                                    ? Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 1,
                                                  color: const Color(0xffFFFFFF)
                                                      .withOpacity(0.2)),
                                              color: const Color.fromARGB(
                                                      255, 186, 186, 186)
                                                  .withOpacity(0.3),
                                              borderRadius:
                                                  BorderRadius.circular(16)),
                                          padding: EdgeInsets.all(2 * pix),
                                          child: Text(
                                            this.candidate['interests'][index],
                                            style: AppFonts.be400(
                                                10, AppColors.background),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      )
                                    : Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1,
                                                color: const Color(0xffFFFFFF)
                                                    .withOpacity(0.2)),
                                            color: const Color(0xffFFFFFF)
                                                .withOpacity(0.1),
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                        padding: EdgeInsets.all(2 * pix),
                                        child: Text(
                                          this.candidate['interests'][index],
                                          style: AppFonts.be400(
                                              10, AppColors.background),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                index == 4
                                    ? SizedBox(
                                        width: 4 * pix,
                                      )
                                    : const SizedBox.shrink(),
                                index == 4
                                    ? Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1 * pix,
                                                color: const Color(0xffFFFFFF)
                                                    .withOpacity(0.2)),
                                            color: const Color(0xffFFFFFF)
                                                .withOpacity(0.1),
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                        padding: EdgeInsets.all(2 * pix),
                                        child: Text(
                                          "+${this.candidate['interests'].length - 5}",
                                          style: AppFonts.be400(
                                              10, AppColors.background),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                              ],
                            ),
                          )
                        : List.generate(
                            this.candidate['interests'].length,
                            (index) => Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1 * pix,
                                      color: const Color(0xffFFFFFF)
                                          .withOpacity(0.2)),
                                  color:
                                      const Color.fromARGB(255, 186, 186, 186)
                                          .withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(16)),
                              padding: EdgeInsets.all(2 * pix),
                              child: Text(
                                this.candidate['interests'][index],
                                style: AppFonts.be400(
                                    10 * pix, AppColors.background),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                  )),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 100 * pix,
                width: 177 * pix,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      const Color.fromARGB(255, 0, 0, 0).withOpacity(0.8),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 5,
              left: 0,
              right: 0,
              child: Container(
                height: 52 * pix,
                width: 177 * pix,
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          this.candidate['name'],
                          style: TextStyle(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            fontSize: 12,
                            fontFamily: 'BeVietnamPro',
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(width: 5),
                        Text(
                          calculateAge(this.candidate['birthday']).toString(),
                          style: TextStyle(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            fontSize: 12,
                            fontFamily: 'BeVietnamPro',
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Image.asset(AppImages.iconVerify,
                            height: 18 * pix, width: 18 * pix),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            height: 30 * pix,
                            width: 110 * pix,
                            padding: EdgeInsets.only(left: 5),
                            child: Row(
                              children: [
                                Image.asset(
                                  this.isSuper
                                      ? AppImages.star
                                      : AppImages.loveGreen,
                                  height: 12 * pix,
                                  width: 12 * pix,
                                ),
                                SizedBox(width: 5),
                                Expanded(
                                  child: Text(
                                    'aaaaaaaaa',
                                    style: TextStyle(
                                      color: const Color.fromARGB(
                                          255, 255, 255, 255),
                                      fontSize: 10,
                                      fontFamily: 'BeVietnamPro',
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ],
                            )),
                        Container(
                          height: 30 * pix,
                          width: 30 * pix,
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 138, 138, 138)
                                .withOpacity(0.8),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Image.asset(
                            AppImages.loveGreen,
                            height: 24,
                            width: 24,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Image.asset(AppImages.lightFlashEffectWhiteLensUp))
          ],
        ),
      ),
    );
  }

  bool checkCanMatch(Profile myProfile, Profile candidate) {
    if (candidate.whoyoulike
            .any((map) => map['accountId'] == myProfile.accountId) &&
        myProfile.whoyoulike
            .any((map) => map['accountId'] == candidate.accountId)) {
      return true;
    }
    if (candidate.whoyousuperlike
            .any((map) => map['accountId'] == myProfile.accountId) &&
        myProfile.whoyoulike
            .any((map) => map['accountId'] == candidate.accountId)) {
      return true;
    }
    if (candidate.whoyoulike
            .any((map) => map['accountId'] == myProfile.accountId) &&
        myProfile.whoyousuperlike
            .any((map) => map['accountId'] == candidate.accountId)) {
      return true;
    }
    if (candidate.whoyousuperlike
            .any((map) => map['accountId'] == myProfile.accountId) &&
        myProfile.whoyousuperlike
            .any((map) => map['accountId'] == candidate.accountId)) {
      return true;
    }
    return false;
  }

  int calculateAge(String birthDate) {
    DateTime birth = DateFormat('dd/MM/yyyy').parse(birthDate);
    DateTime today = DateTime.now();
    int age = today.year - birth.year;

    // Kiểm tra xem ngày sinh đã qua chưa trong năm hiện tại
    if (today.month < birth.month ||
        (today.month == birth.month && today.day < birth.day)) {
      age--;
    }
    return age;
  }
}
