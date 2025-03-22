import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tiklove_fe/pages/home/detail.dart';
import 'package:tiklove_fe/pages/profile/edit_profile.dart';
import 'package:tiklove_fe/pages/safe_center/safe_center_page.dart';
import 'package:tiklove_fe/pages/service/buy_premium_page.dart';
import 'package:tiklove_fe/pages/service/buy_speed_page.dart';
import 'package:tiklove_fe/pages/service/buy_superlike_page.dart';
import 'package:tiklove_fe/pages/setting/setting_page.dart';
import 'package:tiklove_fe/provider/AuthProvider.dart';
import 'package:tiklove_fe/provider/ProfileProvider.dart';
import 'package:tiklove_fe/res/images/app_images.dart';
import 'package:tiklove_fe/theme/app_colors.dart';
import 'package:tiklove_fe/utils.dart' as utils;

class ProfileCard extends StatefulWidget {
  const ProfileCard({super.key});

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  final String baseurl = utils.imgUrl;

  @override
  void initState() {
    super.initState();
  }

  int calculateAge(String birthDate) {
    DateTime birth = DateFormat('dd/MM/yyyy').parse(birthDate);
    DateTime today = DateTime.now();
    int age = today.year - birth.year;

    if (today.month < birth.month ||
        (today.month == birth.month && today.day < birth.day)) {
      age--;
    }
    return age;
  }

  @override
  Widget build(BuildContext context) {
    final account = Provider.of<AuthProvider>(context, listen: false).account;
    final size = MediaQuery.of(context).size;
    final pix = size.width / 393;
    return Container(
      height: 700 * pix,
      width: 377 * pix,
      child: Consumer<ProfileProvider>(
        builder: (context, profileProvider, child) {
          final profile = profileProvider.profile;
          if (profile == null) {
            return Center(child: CircularProgressIndicator());
          }
          return Column(
            children: [
              Container(
                height: 424 * pix,
                width: double.maxFinite,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                      child: profile.images.length == 0
                          ? (profile.gender == 'Nam' ||
                                  profile.gender == 'Khác')
                              ? Image.asset(
                                  AppImages.avatarBoy,
                                  fit: BoxFit.cover,
                                  width: double.maxFinite,
                                  height: 424 * pix,
                                )
                              : Image.asset(
                                  AppImages.avatarGirl,
                                  fit: BoxFit.cover,
                                  width: double.maxFinite,
                                  height: 424 * pix,
                                )
                          : PageView.builder(
                              itemCount: profile.images.length,
                              itemBuilder: (context, index) {
                                return Image.network(
                                  '$baseurl/${profile.images[index]}',
                                  fit: BoxFit.cover,
                                  width: double.maxFinite,
                                  height: 424 * pix,
                                );
                              },
                            ),
                    ),
                    Positioned(
                      top: 16 * pix,
                      left: 16 * pix,
                      right: 16 * pix,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return SafetyCenterScreen();
                              }));
                            },
                            child: Container(
                              height: 48 * pix,
                              width: 48 * pix,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.grey.withOpacity(0.5),
                              ),
                              child: Center(
                                child: Image.asset(
                                  AppImages.iconSecurityUserOutline,
                                  height: 28 * pix,
                                  width: 28 * pix,
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return const SettingPage(
                                  issetaccount: true,
                                );
                              }));
                            },
                            child: Container(
                              height: 48 * pix,
                              width: 48 * pix,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.grey.withOpacity(0.5),
                              ),
                              child: Center(
                                child: Image.asset(
                                  AppImages.iconSettingsOutline,
                                  height: 28 * pix,
                                  width: 28 * pix,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 150 * pix,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.9),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10 * pix,
                      left: 16 * pix,
                      right: 16 * pix,
                      child: Container(
                        height: 68 * pix,
                        width: 345 * pix,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(profile.name,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18 * pix,
                                            fontFamily: 'BeVietnamPro',
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(width: 5 * pix),
                                    Text(
                                        calculateAge(profile.birthday)
                                            .toString(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18 * pix,
                                            fontFamily: 'BeVietnamPro',
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(width: 5 * pix),
                                    Image.asset(
                                      AppImages.iconVerify,
                                      height: 20 * pix,
                                      width: 20 * pix,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return EditProfile();
                                        }));
                                      },
                                      child: Container(
                                        height: 36 * pix,
                                        width: 36 * pix,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: Colors.grey.withOpacity(0.5),
                                        ),
                                        child: Center(
                                          child: Image.asset(
                                            AppImages.iconEditOutline,
                                            height: 20 * pix,
                                            width: 20 * pix,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10 * pix),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return DetailPage(
                                              candidate:
                                                  profileProvider.profile!,
                                              isMyProfile: true);
                                        }));
                                      },
                                      child: Container(
                                        height: 36 * pix,
                                        width: 36 * pix,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: Colors.grey.withOpacity(0.5),
                                        ),
                                        child: Center(
                                          child: Image.asset(
                                            AppImages.iconEye,
                                            height: 20 * pix,
                                            width: 20 * pix,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Container(
                              height: 22 * pix,
                              width: double.maxFinite,
                              child: Row(
                                children: [
                                  Container(
                                    height: 22 * pix,
                                    width: 161 * pix,
                                    padding: EdgeInsets.only(
                                        top: 2 * pix, left: 5 * pix),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.grey.withOpacity(0.5),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.person,
                                          color: Colors.white,
                                          size: 15 * pix,
                                        ),
                                        SizedBox(width: 5 * pix),
                                        Text(
                                          'Hoàn thành ${profile.profileCompletion}% hồ sơ',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 11 * pix,
                                            fontFamily: 'BeVietnamPro',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 276 * pix,
                width: 377 * pix,
                padding: EdgeInsets.all(16 * pix),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.9),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                child: Container(
                  height: double.maxFinite,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color:
                        const Color.fromARGB(255, 73, 73, 73).withOpacity(0.8),
                    border: Border.all(
                      color: Colors.grey,
                      width: 0.5 * pix,
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 72 * pix,
                        width: 345 * pix,
                        child: Row(
                          children: [
                            Container(
                              height: 72 * pix,
                              width: 171.5 * pix,
                              padding:
                                  EdgeInsets.only(left: 10 * pix, top: 5 * pix),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                ),
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 0.5 * pix,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Image.asset(
                                    AppImages.star,
                                    height: 34 * pix,
                                    width: 34 * pix,
                                  ),
                                  SizedBox(width: 5 * pix),
                                  Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(top: 12 * pix),
                                        child: Text(
                                          'Lượt siêu thích',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12 * pix,
                                              fontFamily: 'BeVietnamPro'),
                                        ),
                                      ),
                                      SizedBox(height: 5 * pix),
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return BuySuperlikePage();
                                          }));
                                        },
                                        child: Container(
                                            height: 20 * pix,
                                            width: 59 * pix,
                                            padding: EdgeInsets.only(
                                              left: 8 * pix,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: Colors.blue[100]
                                                  ?.withOpacity(0.3),
                                              border: Border.all(
                                                color: const Color.fromARGB(
                                                    255, 0, 149, 255),
                                                width: 1 * pix,
                                              ),
                                            ),
                                            child: Text(
                                              '${account!.numberSuperLike} lượt +',
                                              style: TextStyle(
                                                  color: const Color.fromARGB(
                                                    255,
                                                    255,
                                                    255,
                                                    255,
                                                  ),
                                                  fontSize: 11 * pix,
                                                  fontFamily: 'BeVietnamPro'),
                                            )),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: 72 * pix,
                              width: 1 * pix,
                              decoration: const BoxDecoration(
                                color: Colors.grey,
                              ),
                            ),
                            Container(
                              height: 72 * pix,
                              width: 171.5 * pix,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(16),
                                ),
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 0.5 * pix,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Image.asset(
                                    AppImages.iconAccelerate,
                                    height: 34 * pix,
                                    width: 34 * pix,
                                  ),
                                  SizedBox(width: 5 * pix),
                                  Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(top: 12 * pix),
                                        child: Text(
                                          'Lượt tăng tốc',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12 * pix,
                                              fontFamily: 'BeVietnamPro'),
                                        ),
                                      ),
                                      SizedBox(height: 5 * pix),
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return BuySpeedPage();
                                          }));
                                        },
                                        child: Container(
                                            height: 20 * pix,
                                            width: 59 * pix,
                                            padding: EdgeInsets.only(
                                              left: 8 * pix,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: Colors.orange[100]
                                                  ?.withOpacity(0.3),
                                              border: Border.all(
                                                color: const Color.fromARGB(
                                                    255, 255, 111, 0),
                                                width: 1 * pix,
                                              ),
                                            ),
                                            child: Text(
                                              '${account.numberSpeed} lượt +',
                                              style: TextStyle(
                                                  color: const Color.fromARGB(
                                                      255, 255, 255, 255),
                                                  fontSize: 11 * pix,
                                                  fontFamily: 'BeVietnamPro'),
                                            )),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          height: 169 * pix,
                          width: 345 * pix,
                          padding: EdgeInsets.all(12 * pix),
                          child: Column(
                            children: [
                              Image.asset(AppImages.iconCrownPremium,
                                  height: 48 * pix, width: 48 * pix),
                              SizedBox(height: 10 * pix),
                              Text('Gói Premium',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14 * pix,
                                      fontFamily: 'BeVietnamPro'),
                                  textAlign: TextAlign.center),
                              SizedBox(height: 5 * pix),
                              Text(
                                  'Nâng cấp mọi hoạt động của bạn trên Teklove',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10 * pix,
                                      fontFamily: 'BeVietnamPro'),
                                  textAlign: TextAlign.center),
                              SizedBox(height: 10 * pix),
                              InkWell(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return BuyPremiumPage();
                                  }));
                                },
                                child: Container(
                                  height: 34 * pix,
                                  width: 136 * pix,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: AppColors.accent,
                                    border: Border.all(
                                      color: const Color.fromARGB(255, 0, 0, 0),
                                      width: 0.2 * pix,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            AppColors.accent.withOpacity(0.5),
                                        spreadRadius: 0.5,
                                        blurRadius: 7,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Đăng ký Premium',
                                      style: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 0, 0, 0),
                                          fontSize: 12 * pix,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'BeVietnamPro'),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
