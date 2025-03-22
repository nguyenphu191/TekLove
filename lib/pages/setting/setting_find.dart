import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiklove_fe/pages/profile/profile_widget/box_infor.dart';
import 'package:tiklove_fe/provider/ProfileProvider.dart';
import 'package:tiklove_fe/res/images/app_images.dart';
import 'package:tiklove_fe/theme/app_colors.dart';
import 'package:tiklove_fe/widgets/find_for_box.dart';
import 'package:tiklove_fe/widgets/gender_box.dart';
import 'package:tiklove_fe/widgets/interesting_box.dart';
import 'package:tiklove_fe/widgets/lifestyle_box.dart/drink_box.dart';
import 'package:tiklove_fe/widgets/lifestyle_box.dart/eat_box.dart';
import 'package:tiklove_fe/widgets/lifestyle_box.dart/gym_box.dart';
import 'package:tiklove_fe/widgets/lifestyle_box.dart/internet_box.dart';
import 'package:tiklove_fe/widgets/lifestyle_box.dart/pet_box.dart';
import 'package:tiklove_fe/widgets/lifestyle_box.dart/sleep_box.dart';
import 'package:tiklove_fe/widgets/lifestyle_box.dart/smoke_box.dart';
import 'package:tiklove_fe/widgets/more_info_box.dart/comunication_box.dart';
import 'package:tiklove_fe/widgets/more_info_box.dart/education_box.dart';
import 'package:tiklove_fe/widgets/more_info_box.dart/family_box.dart';
import 'package:tiklove_fe/widgets/more_info_box.dart/love_language_box.dart';
import 'package:tiklove_fe/widgets/more_info_box.dart/personality_box.dart';
import 'package:tiklove_fe/widgets/more_info_box.dart/vaccin_box.dart';
import 'package:tiklove_fe/widgets/more_info_box.dart/zodiac_box.dart';
import 'package:tiklove_fe/widgets/sexual_box.dart';

class SettingFind extends StatefulWidget {
  const SettingFind({super.key});

  @override
  State<SettingFind> createState() => _SettingFindState();
}

class _SettingFindState extends State<SettingFind> {
  String _selectedGender = 'Nam';
  String _selectedSexualOrientation = 'Dị tính';
  String _selectedJobTitle = '';
  String _selectedCompany = '';
  String _selectedSchool = '';
  String _selectedLocation = 'Hà Nội, Việt Nam';
  String _selectedHobbies = 'Bắn bi a, đi du lịch, đánh bóng chuyền, đá bóng';
  String _selectedLookingFor = 'Người yêu';
  String _selectedHeight = '1m65';
  String _selectedLanguage = 'Vietnamese, English';
  List<String> _interests = [];
  String _sexual = '';
  bool _showSexInProfile = false;
  String _gender = '';
  bool _showGenderInProfile = false;
  String _findFor = '';
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

  void showEditDialog(
      String title, String currentValue, Function(String) onSave) {
    TextEditingController controller =
        TextEditingController(text: currentValue);
    showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) {
        final size = MediaQuery.of(context).size;
        final pix = size.width / 393;
        return Align(
          alignment: Alignment.bottomCenter, // Giữ dialog ở giữa màn hình
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: size.width, // Full chiều rộng
              height: 342 * pix,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16)), // Bo góc trên
              ),
              padding: EdgeInsets.all(16 * pix),
              child: Column(
                children: [
                  Container(
                    height: 38 * pix,
                    width: size.width - 32 * pix,
                    child: Text(
                      title,
                      style: TextStyle(
                          fontSize: 16 * pix,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'BeVietnamPro'),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    height: 1,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16 * pix),
                  Container(
                    height: 56 * pix,
                    width: size.width - 32 * pix,
                    padding: EdgeInsets.only(left: 16 * pix, top: 5 * pix),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        hintText: 'Nhập ${title}',
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          fontSize: 16 * pix,
                          fontFamily: 'BeVietnamPro',
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 138 * pix),
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

  void showGenderSelection(BuildContext context) {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) {
        final size = MediaQuery.of(context).size;
        final pix = size.width / 393;
        return Align(
          alignment: Alignment.bottomCenter, // Giữ dialog ở giữa màn hình
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: size.width, // Full chiều rộng
              height: 342 * pix,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16)), // Bo góc trên
              ),
              padding: EdgeInsets.all(16 * pix),
              child: Column(
                children: [
                  GenderBox(
                    currentGender: 'Nam',
                    currentShowGenderInProfile: false,
                    onGenderSelected: (value) {
                      setState(() {
                        _selectedGender = value;
                      });
                    },
                    showGenderInProfile: (value) =>
                        _showGenderInProfile = value,
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

  void showSexualSelection(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "",
      transitionDuration: Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        final size = MediaQuery.of(context).size;
        final pix = size.width / 393;
        return Align(
          alignment: Alignment.bottomCenter, // Giữ dialog ở giữa màn hình
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: size.width, // Full chiều rộng
              height: 520 * pix,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16)), // Bo góc trên
              ),
              padding: EdgeInsets.all(16 * pix),
              child: Column(
                children: [
                  // SexualBox( onSexualSelected: (value) {
                  //   setState(() {
                  //     _sexual = value;
                  //   });
                  // }, showSexInProfile: (value) {
                  //   _showSexInProfile = value;
                  // }),
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

  void showInterestSelection(BuildContext context) {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) {
        final size = MediaQuery.of(context).size;
        final pix = size.width / 393;
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
                  InterestingBox(
                    currentInterests: _interests,
                    onSelected: (selected) {
                      setState(() {
                        _interests = selected;
                      });
                    },
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

  void showFindForSelection(BuildContext context) {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) {
        final size = MediaQuery.of(context).size;
        final pix = size.width / 393;
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
                  FindForBox(
                    onSelectedFindFor: (value) {
                      setState(() {
                        _findFor = value;
                      });
                    },
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
                                              : Container(),
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

  Future<void> _update2(String key, String value) async {
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

  void showSelection2(BuildContext context, String key, String currentValue) {
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
                              _update2(key, _value);
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
              'Cài đặt tìm kiếm',
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
            icon: AppImages.iconDetailGender,
            title: "Giới tính",
            content: _selectedGender,
            callback: () => showGenderSelection(context),
          ),
          BoxInfor(
            icon: AppImages.anythingIsPossible,
            title: "Khuynh hướng tình dục",
            content: _selectedSexualOrientation,
            callback: () => showSexualSelection(context),
          ),
          BoxInfor(
            icon: AppImages.iconEditUserTag,
            title: "Chức danh",
            content: _selectedJobTitle,
            callback: () =>
                showEditDialog("Chức danh", _selectedJobTitle, (value) {
              setState(() => _selectedJobTitle = value);
            }),
          ),
          BoxInfor(
            icon: AppImages.iconEditBuilding_4,
            title: "Công ty",
            content: _selectedCompany,
            callback: () =>
                showEditDialog("Công ty", _selectedCompany, (value) {
              setState(() => _selectedCompany = value);
            }),
          ),
          BoxInfor(
            icon: AppImages.iconEditBuliding,
            title: "Trường học",
            content: _selectedSchool,
            callback: () =>
                showEditDialog("Trường học", _selectedSchool, (value) {
              setState(() => _selectedSchool = value);
            }),
          ),
          BoxInfor(
            icon: AppImages.iconEditHouse,
            title: "Đang sống tại",
            content: _selectedLocation,
            callback: () =>
                showEditDialog("Nơi sống", _selectedLocation, (value) {
              setState(() => _selectedLocation = value);
            }),
          ),
          BoxInfor(
            icon: AppImages.iconEditEmojiHappy,
            title: "Sở thích",
            content: _selectedHobbies,
            callback: () => showInterestSelection(context),
          ),
          BoxInfor(
            icon: AppImages.iconEditSearchNormal,
            title: "Đang tìm kiếm",
            content: _selectedLookingFor,
            callback: () => showFindForSelection(context),
          ),
          BoxInfor(
            icon: AppImages.iconEditRuler,
            title: "Chiều cao",
            content: _selectedHeight,
            callback: () =>
                showEditDialog("Chiều cao", _selectedHeight, (value) {
              setState(() => _selectedHeight = value);
            }),
          ),
          BoxInfor(
            icon: AppImages.iconEditLanguageCircle,
            title: "Ngôn ngữ",
            content: _selectedLanguage,
            callback: () =>
                showEditDialog("Ngôn ngữ", _selectedLanguage, (value) {
              setState(() => _selectedLanguage = value);
            }),
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
          BoxInfor(
              icon: AppImages.iconEditPet,
              title: "Thú cưng",
              content: (profile.habits['pet'] ?? ''),
              callback: () {
                showSelection2(context, 'pet', (profile.habits['pet'] ?? ''));
              }),
          BoxInfor(
              icon: AppImages.iconEditWineGlass,
              title: "Uống rượu bia",
              content: (profile.habits['drink'] ?? ''),
              callback: () {
                showSelection2(
                    context, 'drink', (profile.habits['drink'] ?? ''));
              }),
          BoxInfor(
              icon: AppImages.iconEditSmoking,
              title: "Hút thuốc",
              content: (profile.habits['smoke'] ?? ''),
              callback: () {
                showSelection2(
                    context, 'smoke', (profile.habits['smoke'] ?? ''));
              }),
          BoxInfor(
              icon: AppImages.iconEditWeight,
              title: "Tập luyện",
              content: (profile.habits['gym'] ?? ''),
              callback: () {
                showSelection2(context, 'gym', (profile.habits['gym'] ?? ''));
              }),
          BoxInfor(
              icon: AppImages.iconEditMilk,
              title: "Chế độ ăn uống",
              content: (profile.habits['eat'] ?? ''),
              callback: () {
                showSelection2(context, 'eat', (profile.habits['eat'] ?? ''));
              }),
          BoxInfor(
              icon: AppImages.iconEditGlobal,
              title: "Truyền thông xã hội",
              content: (profile.habits['internet'] ?? ''),
              callback: () {
                showSelection2(
                    context, 'internet', (profile.habits['internet'] ?? ''));
              }),
          BoxInfor(
              icon: AppImages.iconEditMoon,
              title: "Thói quen ngủ",
              content: (profile.habits['sleep'] ?? ''),
              callback: () {
                showSelection2(
                    context, 'sleep', (profile.habits['sleep'] ?? ''));
              }),
        ],
      );
    });
  }
}
