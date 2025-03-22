import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:provider/provider.dart';
import 'package:tiklove_fe/pages/profile/profile_widget/box_infor.dart';
import 'package:tiklove_fe/provider/ProfileProvider.dart';
import 'package:tiklove_fe/res/images/app_images.dart';
import 'package:tiklove_fe/theme/app_colors.dart';
import 'package:tiklove_fe/widgets/find_for_box.dart';
import 'package:tiklove_fe/widgets/gender_box.dart';
import 'package:tiklove_fe/widgets/interesting_box.dart';
import 'package:tiklove_fe/widgets/language_box.dart';
import 'package:tiklove_fe/widgets/sexual_box.dart';

class EditBasicInfo extends StatefulWidget {
  const EditBasicInfo({super.key});

  @override
  State<EditBasicInfo> createState() => _EditBasicInfoState();
}

class _EditBasicInfoState extends State<EditBasicInfo> {
  Future<void> _update(Map<String, dynamic> mp) async {
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    final profile = profileProvider.profile;
    print("Account ID: ${profile!.accountId}");
    try {
      final res = await profileProvider.updateProfile(profile.accountId, mp);

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

  bool checkHeight(String height) {
    return RegExp(r'^[12]m\d{1,2}$').hasMatch(height);
  }

  void showEditDialog(String key, String title, String currentValue) {
    TextEditingController controller =
        TextEditingController(text: currentValue);
    showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) {
        final size = MediaQuery.of(context).size;
        final pix = size.width / 393;
        return KeyboardVisibilityBuilder(
          builder: (context, isKeyboardVisible) {
            return Align(
              alignment:
                  isKeyboardVisible ? Alignment.center : Alignment.bottomCenter,
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
                    mainAxisSize: MainAxisSize.min,
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
                            hintText: key == "height"
                                ? 'Nhập ${title} dạng  xmy, VD: 1m65'
                                : 'Nhập ${title}',
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
                                      color: const Color.fromARGB(
                                          255, 238, 238, 238),
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
                                if (controller.text.isNotEmpty) {
                                  if (key == "height") {
                                    if (checkHeight(controller.text)) {
                                      _update({key: controller.text});
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text('Cập nhật thành công'),
                                        duration: Duration(seconds: 2),
                                      ));
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(
                                            'Vui lòng nhập chiều cao đúng định dạng'),
                                        duration: Duration(seconds: 2),
                                      ));
                                    }
                                  } else {
                                    _update({key: controller.text});
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text('Cập nhật thành công'),
                                      duration: Duration(seconds: 2),
                                    ));
                                  }
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text('Vui lòng nhập thông tin'),
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
      },
    );
  }

  void showGenderSelection(BuildContext context, String currentGender,
      bool currentShowGenderInProfile) {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) {
        final size = MediaQuery.of(context).size;
        final pix = size.width / 393;
        String _selectedGender = '';
        bool _showGenderInProfile = currentShowGenderInProfile;
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
                    currentGender: currentGender,
                    currentShowGenderInProfile: currentShowGenderInProfile,
                    onGenderSelected: (value) {
                      setState(() {
                        _selectedGender = value;
                      });
                    },
                    showGenderInProfile: (value) {
                      setState(() {
                        _showGenderInProfile = value;
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
                            _update({"gender": _selectedGender});
                            setState(() {
                              _selectedGender = 'Nam';
                            });
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

  void showSexualSelection(BuildContext context, String currentselectedSexual,
      bool currentshowSexInProfile) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "",
      transitionDuration: Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        final size = MediaQuery.of(context).size;
        final pix = size.width / 393;
        String _sexual = '';
        bool _showSexInProfile = false;
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
                  SexualBox(
                    currentselectedSexual: currentselectedSexual,
                    currentshowSexInProfile: currentshowSexInProfile,
                    onSexualSelected: (value) {
                      setState(() {
                        _sexual = value;
                      });
                    },
                    showSexInProfile: (value) {
                      setState(() {
                        _showSexInProfile = value;
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
                            if (_sexual.isNotEmpty) {
                              _update({
                                "sexuality": _sexual,
                                "showSexInProfile": _showSexInProfile
                              });
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text('Cập nhật thành công'),
                                duration: Duration(seconds: 2),
                              ));

                              Navigator.pop(context);
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text('Vui lòng chọn thông tin'),
                                duration: Duration(seconds: 2),
                              ));
                            }
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

  void showInterestSelection(BuildContext context, List<String> currentValue) {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) {
        final size = MediaQuery.of(context).size;
        final pix = size.width / 393;
        List<String> _interests = [];
        return Align(
          alignment: Alignment.bottomCenter,
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: size.width,
              height: 558 * pix,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              padding: EdgeInsets.all(16 * pix),
              child: Column(
                children: [
                  InterestingBox(
                    currentInterests: currentValue,
                    onSelected: (value) {
                      setState(() {
                        _interests = value;
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
                            if (_interests.length > 0) {
                              _update({"interests": _interests});
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text('Cập nhật thành công'),
                                duration: Duration(seconds: 2),
                              ));
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content:
                                    Text('Vui lòng chọn ít nhất 1 sở thích'),
                                duration: Duration(seconds: 2),
                              ));
                            }
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

  void showLanguageSelection(BuildContext context, List<String> currentValue) {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) {
        final size = MediaQuery.of(context).size;
        final pix = size.width / 393;
        List<String> _languages = [];
        return Align(
          alignment: Alignment.bottomCenter,
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: size.width,
              height: 558 * pix,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              padding: EdgeInsets.all(16 * pix),
              child: Column(
                children: [
                  LanguageBox(
                    current: currentValue,
                    onSelected: (value) {
                      setState(() {
                        _languages = value;
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
                            if (_languages.length > 0) {
                              _update({"language": _languages});
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text('Cập nhật thành công'),
                                duration: Duration(seconds: 2),
                              ));
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content:
                                    Text('Vui lòng chọn ít nhất 1 ngôn ngữ'),
                                duration: Duration(seconds: 2),
                              ));
                            }
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

  void showFindForSelection(BuildContext context, String currentValue) {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) {
        final size = MediaQuery.of(context).size;
        final pix = size.width / 393;
        String _findfor = currentValue;
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
                        _findfor = value;
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
                            _update({"findfor": _findfor});
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Cập nhật thành công'),
                              duration: Duration(seconds: 2),
                            ));
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
          BoxInfor(
            icon: AppImages.iconDetailGender,
            title: "Giới tính",
            content: profile.gender,
            callback: () => showGenderSelection(
                context, profile.gender, profile.showGenderInProfile),
          ),
          BoxInfor(
            icon: AppImages.anythingIsPossible,
            title: "Khuynh hướng tình dục",
            content: profile.sexual,
            callback: () => showSexualSelection(
                context, profile.sexual, profile.showSexInProfile),
          ),
          BoxInfor(
            icon: AppImages.iconEditUserTag,
            title: "Chức danh",
            content: (profile.job != 'noinfo' &&
                    profile.job != null &&
                    profile.job != "")
                ? profile.job!
                : '',
            callback: () => showEditDialog(
              "job",
              "Nghề nghiệp",
              (profile.job != 'noinfo' &&
                      profile.job != null &&
                      profile.job != "")
                  ? profile.job!
                  : '',
            ),
          ),
          BoxInfor(
            icon: AppImages.iconEditBuilding_4,
            title: "Công ty",
            content: (profile.company != 'noinfo' &&
                    profile.company != null &&
                    profile.company != "")
                ? profile.company!
                : '',
            callback: () => showEditDialog(
                "company",
                "Công ty",
                (profile.company != 'noinfo' &&
                        profile.company != null &&
                        profile.company != "")
                    ? profile.company!
                    : ''),
          ),
          BoxInfor(
            icon: AppImages.iconEditBuliding,
            title: "Trường học",
            content: (profile.university != 'noinfo' &&
                    profile.university != null &&
                    profile.university != "")
                ? profile.university!
                : '',
            callback: () => showEditDialog(
                "university",
                "Trường học",
                (profile.university != 'noinfo' &&
                        profile.university != null &&
                        profile.university != "")
                    ? profile.university!
                    : ''),
          ),
          BoxInfor(
            icon: AppImages.iconEditHouse,
            title: "Đang sống tại",
            content: (profile.livingAddress != 'noinfo' &&
                    profile.livingAddress != null &&
                    profile.livingAddress != "")
                ? profile.livingAddress!
                : '',
            callback: () => showEditDialog(
              "livingAddress",
              "Nơi sống",
              (profile.livingAddress != 'noinfo' &&
                      profile.livingAddress != null &&
                      profile.livingAddress != "")
                  ? profile.livingAddress!
                  : '',
            ),
          ),
          BoxInfor(
            icon: AppImages.iconEditEmojiHappy,
            title: "Sở thích",
            content:
                profile.interests.isNotEmpty ? profile.interests.join(",") : "",
            callback: () => showInterestSelection(context, profile.interests),
          ),
          BoxInfor(
            icon: AppImages.iconEditSearchNormal,
            title: "Đang tìm kiếm",
            content: (profile.findFor != 'noinfo' &&
                    profile.findFor != null &&
                    profile.findFor != "")
                ? tranf(profile.findFor)
                : '',
            callback: () => showFindForSelection(
                context,
                (profile.findFor != 'noinfo' &&
                        profile.findFor != null &&
                        profile.findFor != "")
                    ? profile.findFor
                    : ''),
          ),
          BoxInfor(
            icon: AppImages.iconEditRuler,
            title: "Chiều cao",
            content: (profile.height != 'noinfo' &&
                    profile.height != null &&
                    profile.height != "")
                ? profile.height!
                : '',
            callback: () => showEditDialog(
              "height",
              "Chiều cao",
              (profile.height != 'noinfo' &&
                      profile.height != null &&
                      profile.height != "")
                  ? profile.height!
                  : '',
            ),
          ),
          BoxInfor(
            icon: AppImages.iconEditLanguageCircle,
            title: "Ngôn ngữ",
            content:
                profile.language!.isNotEmpty ? profile.language!.join(",") : "",
            callback: () => showLanguageSelection(context, profile.language!),
          ),
          Container(
            height: 1 * pix,
            width: size.width,
            color: Colors.grey,
          ),
        ],
      );
    });
  }

  String tranf(String s) {
    if (s == 'Love') {
      return "Đang tìm kiếm tình yêu <3";
    } else if (s == 'NoBinding') {
      return "Đang tìm kiếm mối quan hệ không ràng buộc";
    } else if (s == 'Dating') {
      return "Đang tìm kiếm người hẹn hò lâu dài";
    } else if (s == 'Every') {
      return "Đang tìm kiếm bất kì điều gì";
    } else if (s == 'Friends') {
      return "Đang tìm kiếm những người bạn mới";
    } else {
      return "Mình chưa chắc chắn";
    }
  }
}
