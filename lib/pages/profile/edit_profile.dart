import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tiklove_fe/pages/profile/profile_widget/edit_ask_me.dart';
import 'package:tiklove_fe/pages/profile/profile_widget/edit_audio.dart';
import 'package:tiklove_fe/pages/profile/profile_widget/edit_basic_info.dart';
import 'package:tiklove_fe/pages/profile/profile_widget/edit_intro.dart';
import 'package:tiklove_fe/pages/profile/profile_widget/edit_lifestyle.dart';
import 'package:tiklove_fe/pages/profile/profile_widget/edit_more_infor.dart';
import 'package:tiklove_fe/pages/profile/profile_widget/edit_slogen.dart';
import 'package:tiklove_fe/provider/AuthProvider.dart';
import 'package:tiklove_fe/provider/ProfileProvider.dart';
import 'package:tiklove_fe/theme/app_colors.dart';
import 'package:tiklove_fe/widgets/add_box.dart';
import 'package:tiklove_fe/widgets/image_box.dart';
import 'package:tiklove_fe/utils.dart' as utils;

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool imgSmart = false;
  final String baseurl = utils.imgUrl;
  List<XFile> _images = [];
  final ImagePicker _picker = ImagePicker();

  // Chọn ảnh từ thiết bị
  Future<void> _pickImages() async {
    final pickedFiles = await _picker.pickMultiImage();
    setState(() {
      _images.addAll(pickedFiles);
    });
  }

  // Upload ảnh lên backend
  Future<void> _uploadImages() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    try {
      final res = await profileProvider.uploadImages(
          context, authProvider.account!.id, _images);
      if (res) {
        setState(() {
          _images.clear();
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to upload images'),
        ));
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pix = size.width / 393;
    return Scaffold(
      body:
          Consumer<ProfileProvider>(builder: (context, profileProvider, child) {
        final profile = profileProvider.profile;
        if (profile == null) {
          return Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 80 * pix,
                width: size.width,
                color: Colors.white,
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Text(
                      'Chỉnh sửa hồ sơ',
                      style: TextStyle(
                        fontSize: 20 * pix,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: 'BeVietnamPro',
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 50 * pix,
                width: size.width,
                color: Colors.grey[200],
                padding: EdgeInsets.only(left: 16 * pix, top: 14 * pix),
                child: Text(
                  'Ảnh, Video & Audio',
                  style: TextStyle(
                    fontSize: 16 * pix,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'BeVietnamPro',
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                height: 708 * pix,
                width: size.width,
                color: Colors.white,
                padding: EdgeInsets.all(16 * pix),
                child: Column(
                  children: [
                    Container(
                      height: 20 * pix,
                      width: size.width,
                      child: Text(
                        'Ảnh/Video',
                        style: TextStyle(
                          fontSize: 14 * pix,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'BeVietnamPro',
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(
                      height: 8 * pix,
                    ),
                    Container(
                      height: 120 * pix,
                      width: size.width,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: profile.images.length,
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              Container(
                                height: 120 * pix,
                                width: 120 * pix,
                                margin: EdgeInsets.only(right: 8 * pix),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10 * pix),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        '$baseurl/${profile.images[index]}'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 5 * pix,
                                right: 10 * pix,
                                child: Container(
                                  width: 26 * pix,
                                  height: 26 * pix,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color:
                                        Colors.white, // Màu nền của hình tròn
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 4,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: IconButton(
                                    padding: EdgeInsets
                                        .zero, // Loại bỏ padding mặc định
                                    iconSize:
                                        18, // Giảm kích thước icon để vừa với vòng tròn
                                    icon:
                                        Icon(Icons.close, color: Colors.black),
                                    onPressed: () async {
                                      await profileProvider.deleteImage(
                                          context,
                                          profile.accountId,
                                          profile.images[index]);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 8 * pix,
                    ),
                    Container(
                      height: 380 * pix,
                      width: double.maxFinite,
                      padding: EdgeInsets.only(
                          left: 28 * pix,
                          right: 28 * pix,
                          top: 8 * pix,
                          bottom: 8 * pix),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                          childAspectRatio: 0.85,
                        ),
                        itemCount: 9,
                        itemBuilder: (context, index) {
                          if (index < _images.length) {
                            return ImageBox(
                              img: _images[index].path,
                              onDelete: () {
                                setState(() {
                                  _images.removeAt(index);
                                });
                              },
                            );
                          } else {
                            return AddBox(onTap: _pickImages);
                          }
                        },
                      ),
                    ),
                    InkWell(
                      onTap: _uploadImages,
                      child: Container(
                        height: 36 * pix,
                        width: 89 * pix,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset:
                                  Offset(0, 1), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            "Thêm",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14 * pix,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'BeVietnamPro'),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 65 * pix,
                      width: size.width - 32 * pix,
                      child: Row(
                        children: [
                          Container(
                            height: 65 * pix,
                            width: 30 * pix,
                            alignment: Alignment.topCenter,
                            child: Transform.scale(
                              scale:
                                  0.6, // Giảm kích thước, giá trị < 1 làm nhỏ hơn, giá trị > 1 làm lớn hơn
                              child: Switch(
                                value: imgSmart,
                                onChanged: (value) {
                                  setState(() {
                                    imgSmart = value;
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(width: 5 * pix),
                          Container(
                            height: 65 * pix,
                            width: size.width - 72 * pix,
                            padding: EdgeInsets.only(top: 10 * pix),
                            child: Column(
                              children: [
                                Container(
                                  height: 20 * pix,
                                  width: size.width - 72 * pix,
                                  child: Text(
                                    'Ảnh thông minh',
                                    style: TextStyle(
                                        fontSize: 13 * pix,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'BeVietnamPro'),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: 34 * pix,
                                    width: size.width - 72 * pix,
                                    child: Text(
                                      'Xem xét ảnh hồ sơ của bạn và chọn ra ảnh đẹp nhất để hiển thị trước.',
                                      style: TextStyle(
                                          fontSize: 12 * pix,
                                          fontFamily: 'BeVietnamPro'),
                                      textAlign: TextAlign.left,
                                      maxLines: 2,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 1 * pix,
                width: size.width,
                color: Colors.grey,
              ),
              EditAudio(),
              EditIntro(),
              EditSlogen(),
              EditBasicInfo(),
              EditMoreInfor(),
              EditLifestyle(),
              EditAskMe(),
            ],
          ),
        );
      }),
    );
  }
}
