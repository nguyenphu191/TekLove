import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiklove_fe/pages/profile/profile_widget/box_infor.dart';
import 'package:tiklove_fe/provider/ProfileProvider.dart';
import 'package:tiklove_fe/res/images/app_images.dart';
import 'package:tiklove_fe/theme/app_colors.dart';
import 'package:tiklove_fe/widgets/lifestyle_box.dart/drink_box.dart';
import 'package:tiklove_fe/widgets/lifestyle_box.dart/eat_box.dart';
import 'package:tiklove_fe/widgets/lifestyle_box.dart/gym_box.dart';
import 'package:tiklove_fe/widgets/lifestyle_box.dart/internet_box.dart';
import 'package:tiklove_fe/widgets/lifestyle_box.dart/pet_box.dart';
import 'package:tiklove_fe/widgets/lifestyle_box.dart/sleep_box.dart';
import 'package:tiklove_fe/widgets/lifestyle_box.dart/smoke_box.dart';

class EditLifestyle extends StatefulWidget {
  const EditLifestyle({super.key});

  @override
  State<EditLifestyle> createState() => _EditLifestyleState();
}

class _EditLifestyleState extends State<EditLifestyle> {
  Future<void> _update(String key, String value) async {
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    final profile = profileProvider.profile;
    Map<dynamic, dynamic> mp = profile!.habits ?? new Map<dynamic, dynamic>();
    if (mp.containsKey(key)) {
      mp.update(key, (value) => value);
    } else {
      mp.putIfAbsent(key, () => value);
    }
    print('mp: $mp');
    try {
      final res = await profileProvider
          .updateProfile(profile.accountId, {"habits": mp});

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
                  key == 'pet'
                      ? PetBox(
                          pet: currentValue,
                          callback: (value) {
                            _value = value;
                          },
                        )
                      : key == 'drink'
                          ? DrinkBox(
                              drink: currentValue,
                              callback: (value) {
                                _value = value;
                              },
                            )
                          : key == 'smoke'
                              ? SmokeBox(
                                  smoke: currentValue,
                                  callback: (value) {
                                    _value = value;
                                  })
                              : key == 'gym'
                                  ? GymBox(
                                      gym: currentValue,
                                      callback: (value) {
                                        _value = value;
                                      })
                                  : key == 'eat'
                                      ? EatBox(
                                          eat: currentValue,
                                          callback: (value) {
                                            _value = value;
                                          })
                                      : key == 'internet'
                                          ? InternetBox(
                                              internet: currentValue,
                                              callback: (value) {
                                                _value = value;
                                              })
                                          : key == 'sleep'
                                              ? SleepBox(
                                                  sleep: currentValue,
                                                  callback: (value) {
                                                    _value = value;
                                                  })
                                              : Container(),
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
              'Phong cách sống',
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
              icon: AppImages.iconEditPet,
              title: "Thú cưng",
              content: profile.habits['pet'] ?? '',
              callback: () {
                showSelection(context, 'pet', profile.habits['pet'] ?? '');
              }),
          BoxInfor(
              icon: AppImages.iconEditWineGlass,
              title: "Uống rượu bia",
              content: profile.habits['drink'] ?? '',
              callback: () {
                showSelection(context, 'drink', profile.habits['drink'] ?? '');
              }),
          BoxInfor(
              icon: AppImages.iconEditSmoking,
              title: "Hút thuốc",
              content: profile.habits['smoke'] ?? '',
              callback: () {
                showSelection(context, 'smoke', profile.habits['smoke'] ?? '');
              }),
          BoxInfor(
              icon: AppImages.iconEditWeight,
              title: "Tập luyện",
              content: profile.habits['gym'] ?? '',
              callback: () {
                showSelection(context, 'gym', profile.habits['gym'] ?? '');
              }),
          BoxInfor(
              icon: AppImages.iconEditMilk,
              title: "Chế độ ăn uống",
              content: profile.habits['eat'] ?? '',
              callback: () {
                showSelection(context, 'eat', profile.habits['eat'] ?? '');
              }),
          BoxInfor(
              icon: AppImages.iconEditGlobal,
              title: "Truyền thông xã hội",
              content: profile.habits['internet'] ?? '',
              callback: () {
                showSelection(
                    context, 'internet', profile.habits['internet'] ?? '');
              }),
          BoxInfor(
              icon: AppImages.iconEditMoon,
              title: "Thói quen ngủ",
              content: profile.habits['sleep'] ?? '',
              callback: () {
                showSelection(context, 'sleep', profile.habits['sleep'] ?? '');
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
