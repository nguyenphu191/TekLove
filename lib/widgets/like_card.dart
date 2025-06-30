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
  const LikeCard({
    super.key,
    required this.candidate,
    this.isSuper = false,
    this.isVip = false,
    this.isLiked = false,
  });

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
        final candidateProfile = await profileProvider.getProfileById(
          this.candidate['accountId'],
          context,
        );

        if (candidateProfile != null) {
          if (isVip) {
            if (profileProvider.profile != null &&
                checkCanMatch(profileProvider.profile!, candidateProfile)) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailPage(
                    candidate: candidateProfile,
                    isMyProfile: false,
                    canMatch: true,
                  ),
                ),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailPage(
                    candidate: candidateProfile,
                    isMyProfile: false,
                    canMatch: false,
                  ),
                ),
              );
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Đăng ký premium để xem thông tin chi tiết'),
              ),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Không thể tải thông tin người dùng'),
            ),
          );
        }
      },
      child: Container(
        height: 275 * pix,
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
            if (!isVip)
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                    child: Container(
                      color: Colors.grey.withOpacity(0.9),
                    ),
                  ),
                ),
              ),
            Positioned(
              top: 10,
              left: 10,
              right: 10,
              child: _buildInterests(pix),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 100 * pix,
                width: 177 * pix,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
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
              child: _buildProfileInfo(pix),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Image.asset(AppImages.lightFlashEffectWhiteLensUp),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInterests(double pix) {
    final interests = candidate['interests'] as List<dynamic>;
    final displayedInterests =
        interests.length > 5 ? interests.sublist(0, 4) : interests;
    final remainingCount = interests.length > 5 ? interests.length - 4 : 0;

    return Wrap(
      spacing: 4 * pix,
      runSpacing: 4 * pix,
      children: [
        ...displayedInterests.map((interest) => Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1 * pix,
                  color: const Color(0xffFFFFFF).withOpacity(0.2),
                ),
                color: const Color(0xffFFFFFF).withOpacity(0.1),
                borderRadius: BorderRadius.circular(16 * pix),
              ),
              padding: EdgeInsets.all(2 * pix),
              child: Text(
                interest.toString(),
                style: AppFonts.be400(10 * pix, AppColors.background),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            )),
        if (remainingCount > 0)
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 1 * pix,
                color: const Color(0xffFFFFFF).withOpacity(0.2),
              ),
              color: const Color.fromARGB(255, 186, 186, 186).withOpacity(0.3),
              borderRadius: BorderRadius.circular(16 * pix),
            ),
            padding: EdgeInsets.all(2 * pix),
            child: Text(
              '+$remainingCount',
              style: AppFonts.be400(10 * pix, AppColors.background),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
      ],
    );
  }

  Widget _buildProfileInfo(double pix) {
    return Container(
      height: 58 * pix,
      width: 177 * pix,
      alignment: Alignment.topLeft,
      padding: EdgeInsets.only(left: 10 * pix, right: 10 * pix),
      child: Column(
        children: [
          Row(
            children: [
              Flexible(
                child: Text(
                  candidate['name'],
                  style: TextStyle(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    fontSize: 12 * pix,
                    fontFamily: 'BeVietnamPro',
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: 5 * pix),
              Text(
                calculateAge(candidate['birthday']).toString(),
                style: TextStyle(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  fontSize: 12 * pix,
                  fontFamily: 'BeVietnamPro',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 5 * pix),
              Image.asset(
                AppImages.iconVerify,
                height: 18 * pix,
                width: 18 * pix,
              ),
            ],
          ),
          SizedBox(height: 4 * pix),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Container(
                  height: 30 * pix,
                  width: 100 * pix,
                  padding: EdgeInsets.only(left: 5 * pix),
                  child: Row(
                    children: [
                      Image.asset(
                        isSuper ? AppImages.star : AppImages.loveGreen,
                        height: 12 * pix,
                        width: 12 * pix,
                      ),
                      SizedBox(width: 5 * pix),
                      Flexible(
                        child: Text(
                          'aaaaaaaaa',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            fontSize: 10 * pix,
                            fontFamily: 'BeVietnamPro',
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 30 * pix,
                width: 30 * pix,
                padding: EdgeInsets.symmetric(horizontal: 5 * pix),
                decoration: BoxDecoration(
                  color:
                      const Color.fromARGB(255, 138, 138, 138).withOpacity(0.8),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Image.asset(
                  AppImages.loveGreen,
                  height: 24 * pix,
                  width: 24 * pix,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  bool checkCanMatch(Profile myProfile, Profile candidate) {
    return (candidate.whoyoulike
                .any((map) => map['accountId'] == myProfile.accountId) &&
            myProfile.whoyoulike
                .any((map) => map['accountId'] == candidate.accountId)) ||
        (candidate.whoyousuperlike
                .any((map) => map['accountId'] == myProfile.accountId) &&
            myProfile.whoyoulike
                .any((map) => map['accountId'] == candidate.accountId)) ||
        (candidate.whoyoulike
                .any((map) => map['accountId'] == myProfile.accountId) &&
            myProfile.whoyousuperlike
                .any((map) => map['accountId'] == candidate.accountId)) ||
        (candidate.whoyousuperlike
                .any((map) => map['accountId'] == myProfile.accountId) &&
            myProfile.whoyousuperlike
                .any((map) => map['accountId'] == candidate.accountId));
  }

  int calculateAge(String birthDate) {
    try {
      DateTime birth = DateFormat('dd/MM/yyyy').parse(birthDate);
      DateTime today = DateTime.now();
      int age = today.year - birth.year;

      if (today.month < birth.month ||
          (today.month == birth.month && today.day < birth.day)) {
        age--;
      }
      return age;
    } catch (e) {
      return 0;
    }
  }
}
