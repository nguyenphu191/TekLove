import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiklove_fe/pages/profile/profile_widget/box_infor.dart';
import 'package:tiklove_fe/provider/ProfileProvider.dart';
import 'package:tiklove_fe/res/images/app_images.dart';
import 'package:tiklove_fe/theme/app_colors.dart';
import 'package:tiklove_fe/widgets/more_info_box.dart/comunication_box.dart';
import 'package:tiklove_fe/widgets/more_info_box.dart/education_box.dart';
import 'package:tiklove_fe/widgets/more_info_box.dart/family_box.dart';
import 'package:tiklove_fe/widgets/more_info_box.dart/love_language_box.dart';
import 'package:tiklove_fe/widgets/more_info_box.dart/personality_box.dart';
import 'package:tiklove_fe/widgets/more_info_box.dart/vaccin_box.dart';
import 'package:tiklove_fe/widgets/more_info_box.dart/zodiac_box.dart';

class EditMoreInfor extends StatefulWidget {
  const EditMoreInfor({super.key});

  @override
  State<EditMoreInfor> createState() => _EditMoreInforState();
}

class _EditMoreInforState extends State<EditMoreInfor> {
  Future<void> _update(String key, String value) async {
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    final profile = profileProvider.profile;
    Map<dynamic, dynamic> mp =
        profile!.MoreInfor ?? new Map<dynamic, dynamic>();
    if (mp.containsKey(key)) {
      mp.update(key, (value) => value);
    } else {
      mp.putIfAbsent(key, () => value);
    }
    print('mp: $mp');
    try {
      final res = await profileProvider
          .updateProfile(profile.accountId, {"moreInfor": mp});

      if (res) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Cập nhật thành công'),
          duration: Duration(seconds: 2),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Cập nhật thất bại'),
          duration: Duration(seconds: 2),
        ));
      }
    } catch (error) {
      print(error);
    }
  }

  void showSelection(BuildContext context, String key, String currentValue) {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) {
        final size = MediaQuery.of(context).size;
        final pix = size.width / 393;
        String _value = '';
        return Align(
          alignment: Alignment.bottomCenter, // Giữ dialog ở giữa màn hình
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: size.width, // Full chiều rộng
              height: 558 * pix,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16)), // Bo góc trên
              ),
              padding: EdgeInsets.all(16 * pix),
              child: Column(
                children: [
                  key == 'zodiac'
                      ? ZodiacBox(
                          zodiac: currentValue,
                          callback: (value) {
                            _value = value;
                          },
                        )
                      : key == 'education'
                          ? EducationBox(
                              education: currentValue,
                              callback: (value) {
                                _value = value;
                              },
                            )
                          : key == 'comunication'
                              ? ComunicationBox(
                                  comunication: currentValue,
                                  callback: (value) {
                                    _value = value;
                                  },
                                )
                              : key == 'family'
                                  ? FamilyBox(
                                      family: currentValue,
                                      callback: (value) {
                                        _value = value;
                                      },
                                    )
                                  : key == 'vaccin'
                                      ? VaccinBox(
                                          vaccin: currentValue,
                                          callback: (value) {
                                            _value = value;
                                          },
                                        )
                                      : key == 'personality'
                                          ? PersonalityBox(
                                              personality: currentValue,
                                              callback: (value) {
                                                _value = value;
                                              },
                                            )
                                          : key == 'loveLanguage'
                                              ? LoveLanguageBox(
                                                  loveLanguage: currentValue,
                                                  callback: (value) {
                                                    _value = value;
                                                  },
                                                )
                                              : SizedBox(
                                                  height: 50 * pix,
                                                ),
                  Container(
                    height: 1,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16 * pix),
                  Container(
                    height: 56 * pix,
                    width: size.width - 32 * pix,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 56 * pix,
                            width: 160 * pix,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(50),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color.fromARGB(255, 238, 238, 238),
                                  offset: Offset(0, 2),
                                  spreadRadius: 1.5,
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: Text(
                              "Hủy",
                              style: TextStyle(
                                  fontSize: 16 * pix,
                                  fontFamily: 'BeVietnamPro',
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            alignment: Alignment.center,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            if (_value != '') {
                              _update(key, _value);
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text('Vui lòng chọn cung hoàng đạo'),
                                duration: Duration(seconds: 2),
                              ));
                            }
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 56 * pix,
                            width: 160 * pix,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(50),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primary.withOpacity(0.5),
                                  offset: Offset(0, 2),
                                  spreadRadius: 1.5,
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: Text(
                              "Xong",
                              style: TextStyle(
                                  fontSize: 16 * pix,
                                  fontFamily: 'BeVietnamPro',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                            alignment: Alignment.center,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pix = size.width / 393;
    return Consumer<ProfileProvider>(
        builder: (context, profileProvider, child) {
      final profile = profileProvider.profile;
      if (profile == null) {
        return Center(child: CircularProgressIndicator());
      }

      return Column(
        children: [
          Container(
            height: 50 * pix,
            width: size.width,
            color: Colors.grey[200],
            padding: EdgeInsets.only(left: 16 * pix, top: 14 * pix),
            child: Text(
              'Thông tin thêm',
              style: TextStyle(
                fontSize: 16 * pix,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: 'BeVietnamPro',
              ),
              textAlign: TextAlign.left,
            ),
          ),
          BoxInfor(
              icon: AppImages.iconEditStar,
              title: "Cung hoàng đạo",
              content: (profile.MoreInfor['zodiac'] ?? ''),
              callback: () => showSelection(
                  context, 'zodiac', (profile.MoreInfor['zodiac'] ?? ''))),
          BoxInfor(
              icon: AppImages.iconEditTeacher,
              title: "Trình độ học vấn",
              content: (profile.MoreInfor['education'] ?? ''),
              callback: () {
                showSelection(context, 'education',
                    (profile.MoreInfor['education'] ?? ''));
              }),
          BoxInfor(
              icon: AppImages.iconEditPeople,
              title: "Gia đình trong tương lai",
              content: (profile.MoreInfor['family'] ?? ''),
              callback: () {
                showSelection(
                    context, 'family', (profile.MoreInfor['family'] ?? ''));
              }),
          BoxInfor(
              icon: AppImages.iconEditFaceMask,
              title: "Vacxin COVID",
              content: (profile.MoreInfor['vaccin'] ?? ''),
              callback: () {
                showSelection(
                    context, 'vaccin', (profile.MoreInfor['vaccin'] ?? ''));
              }),
          BoxInfor(
              icon: AppImages.iconEditPuzzlePiece,
              title: "Kiểu tính cách",
              content: (profile.MoreInfor['personality'] ?? ''),
              callback: () {
                showSelection(context, 'personality',
                    (profile.MoreInfor['personality'] ?? ''));
              }),
          BoxInfor(
              icon: AppImages.iconEditMessages3,
              title: "Phong cách giao tiếp",
              content: (profile.MoreInfor['comunication'] ?? ''),
              callback: () {
                showSelection(context, 'comunication',
                    (profile.MoreInfor['comunication'] ?? ''));
              }),
          BoxInfor(
              icon: AppImages.iconEditHeartCircle,
              title: "Ngôn ngữ tình yêu",
              content: (profile.MoreInfor['loveLanguage'] ?? ''),
              callback: () {
                showSelection(context, 'loveLanguage',
                    (profile.MoreInfor['loveLanguage'] ?? ''));
              }),
          Container(
            height: 1 * pix,
            width: size.width,
            color: Colors.grey,
          ),
        ],
      );
    });
  }
}
