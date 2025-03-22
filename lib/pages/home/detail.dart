import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiklove_fe/models/Profile.dart';
import 'package:tiklove_fe/pages/send_greeting/send_greeting.dart';
import 'package:tiklove_fe/pages/send_match/send_match.dart';
import 'package:tiklove_fe/provider/ProfileProvider.dart';
import 'package:tiklove_fe/res/fonts/app_fonts.dart';
import 'package:tiklove_fe/res/images/app_images.dart';
import 'package:tiklove_fe/theme/app_colors.dart';
import 'package:tiklove_fe/widgets/card_detail.dart';

class DetailPage extends StatefulWidget {
  const DetailPage(
      {super.key,
      required this.candidate,
      required this.isMyProfile,
      this.canMatch = false,
      this.canLove = false});
  final Profile candidate;
  final bool isMyProfile;
  final bool canMatch;
  final bool canLove;
  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pix = size.width / 393;
    return Consumer<ProfileProvider>(
        builder: (context, profileProvider, child) {
      final profile = profileProvider.profile;

      if (profile == null) {
        return const Center(child: CircularProgressIndicator());
      }
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            PopupMenuButton<String>(
              icon: const Icon(
                Icons.more_vert,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
              onSelected: (value) {
                print('Chọn: $value');
              },
              itemBuilder: (BuildContext context) {
                return {'Tùy chọn 1', 'Tùy chọn 2', 'Tùy chọn 3'}
                    .map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ],
        ),
        body: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    CardDetail(candidate: widget.candidate),
                    // Thông tin cá nhân
                    Container(
                      width: size.width,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFF2F6),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 64 * pix,
                              width: double.maxFinite,
                              margin: EdgeInsets.only(top: 16 * pix),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        widget.candidate.name,
                                        style: TextStyle(
                                            fontSize: 24 * pix,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontFamily: 'BeVietnamPro'),
                                      ),
                                      SizedBox(width: 8 * pix),
                                      Container(
                                        height: 24 * pix,
                                        width: 24 * pix,
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                AppImages.iconVerify),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Container(
                                    height: 36 * pix,
                                    width: 36 * pix,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Icon(
                                      Icons.share,
                                      color: Colors.black,
                                      size: 30 * pix,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 8 * pix),
                            Column(
                              children: [
                                _buildDetailRow(
                                  Icons.search,
                                  tranf(widget.candidate.findFor),
                                ),
                                _buildDetailRow(
                                    Icons.chat_outlined,
                                    (widget.candidate.slogen == 'noinfo' ||
                                            widget.candidate.slogen == null)
                                        ? "Đang cập nhật"
                                        : "${widget.candidate.slogen}"),
                                _buildDetailRow(Icons.location_on_outlined,
                                    "Cách xa ${widget.candidate.priorityDistance}km"),
                                _buildDetailRow(
                                    FontAwesomeIcons.ruler,
                                    (widget.candidate.height == 'noinfo' ||
                                            widget.candidate.height == null)
                                        ? "Đang cập nhật"
                                        : "${widget.candidate.height}"),
                                _buildDetailRow(Icons.person_outlined,
                                    widget.candidate.gender),
                                _buildDetailRow(
                                    Icons.school_outlined,
                                    (widget.candidate.university == 'noinfo' ||
                                            widget.candidate.university == null)
                                        ? "Đang cập nhật"
                                        : "${widget.candidate.university}"),
                                _buildDetailRow(
                                  Icons.home_outlined,
                                  (widget.candidate.livingAddress == 'noinfo' ||
                                          widget.candidate.livingAddress ==
                                              null)
                                      ? "Đang cập nhật"
                                      : "${widget.candidate.livingAddress}",
                                ),
                              ],
                            ),
                            SizedBox(height: 16 * pix),
                            Column(
                              children: [
                                backgroundItem(
                                    "Giới thiệu",
                                    Text(
                                      widget.candidate.introduction ??
                                          "Đang cập nhật",
                                      style: AppFonts.be400(
                                          14,
                                          const Color(0xff000000)
                                              .withOpacity(0.6)),
                                    )),
                                SizedBox(
                                  height: 8 * pix,
                                ),
                                backgroundItem(
                                    "Thông tin thêm",
                                    Wrap(
                                      spacing: 8,
                                      runSpacing: 8,
                                      children: widget
                                          .candidate.MoreInfor.entries
                                          .map<Widget>((entry) {
                                        // entry.key: tên thông tin (ví dụ: "Phim ảnh")
                                        // entry.value: mô tả thông tin (ví dụ: "Thông tin về phim ảnh")
                                        return itemMoreInformation(
                                            transIcon(entry.key),
                                            entry.value,
                                            ItemInformationType.primary);
                                      }).toList(),
                                    )),
                                SizedBox(
                                  height: 8 * pix,
                                ),
                                backgroundItem(
                                    "Phong cách sống",
                                    Wrap(
                                      spacing: 8,
                                      runSpacing: 8,
                                      children: [
                                        itemMoreInformation(
                                            AppImages.iconDetailSmoking,
                                            widget.candidate.habits["smoke"] ??
                                                "Đang cập nhật",
                                            null),
                                        itemMoreInformation(
                                            AppImages.iconDetailWeight,
                                            widget.candidate.habits["gym"] ??
                                                "Đang cập nhật",
                                            null),
                                        itemMoreInformation(
                                            AppImages.iconDetailWine,
                                            widget.candidate.habits["drink"] ??
                                                "Đang cập nhật",
                                            null),
                                        itemMoreInformation(
                                            AppImages.iconDetailDiet,
                                            widget.candidate.habits["eat"] ??
                                                "Đang cập nhật",
                                            null),
                                        itemMoreInformation(
                                            AppImages.iconsleep,
                                            widget.candidate.habits["sleep"] ??
                                                "Đang cập nhật",
                                            null),
                                        itemMoreInformation(
                                            AppImages.iconpet,
                                            widget.candidate.habits["pet"] ??
                                                "Đang cập nhật",
                                            null),
                                      ],
                                    )),
                                SizedBox(
                                  height: 8 * pix,
                                ),
                                backgroundItem(
                                    "Sở thích",
                                    Wrap(
                                      spacing: 8,
                                      runSpacing: 8,
                                      children: widget.candidate.interests
                                          .map<Widget>((info) =>
                                              itemMoreInformation(
                                                  null, info, null))
                                          .toList(),
                                    )),
                                SizedBox(
                                  height: 8 * pix,
                                ),
                                backgroundItem(
                                    "Chuyện đi chơi",
                                    Wrap(
                                      spacing: 8,
                                      runSpacing: 8,
                                      children: [
                                        Container(
                                          width: (MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  72) /
                                              2,
                                          height: ((MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      72) /
                                                  2) *
                                              (116 / 160.5),
                                          padding: const EdgeInsets.all(16),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                              width: 1,
                                              color: const Color(0xff000000)
                                                  .withOpacity(0.1),
                                            ),
                                            color: const Color(0xff000000)
                                                .withOpacity(0.05),
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                AppImages.youWillOftenSeeMe,
                                                width: 36,
                                                height: 36,
                                              ),
                                              const Spacer(),
                                              Text("Bạn sẽ hay thấy mình",
                                                  textAlign: TextAlign.center,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: AppFonts.be400(
                                                      12,
                                                      const Color(0xff000000)
                                                          .withOpacity(0.6))),
                                              const Spacer(),
                                              Text("ngao du bạn bè",
                                                  textAlign: TextAlign.center,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: AppFonts.be500(14,
                                                      AppColors.textPrimary)),
                                            ],
                                          ),
                                        )
                                      ],
                                    )),
                                const SizedBox(
                                  height: 8,
                                ),
                                backgroundItem(
                                    "Gửi lời chào gây ấn tượng",
                                    InkWell(
                                      onTap: () {},
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Text(
                                                "Gửi tin nhắn trước khi tương hợp để thu hút sự chú ý của người ấy",
                                                style: AppFonts.be400(
                                                    14,
                                                    const Color(0xff000000)
                                                        .withOpacity(0.6))),
                                          ),
                                          SizedBox(
                                            width: 8 * pix,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        SendGreeting(
                                                          candidate:
                                                              widget.candidate,
                                                        )),
                                              );
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(12),
                                              decoration: const BoxDecoration(
                                                  color: Color(0xfff4f4f4),
                                                  shape: BoxShape.circle),
                                              child: Image.asset(
                                                AppImages.iconDetailSend,
                                                width: 24,
                                                height: 24,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )),
                                SizedBox(
                                  height: 100 * pix,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 32 * pix),
                  ],
                ),
              ),
              widget.isMyProfile
                  ? SizedBox.shrink()
                  : Positioned(
                      bottom: 16 * pix,
                      left: size.width / 2 - 112.5 * pix,
                      right: size.width / 2 - 112.5 * pix,
                      child: widget.canMatch
                          ? SizedBox(
                              height: 80 * pix,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  _buildActionButton(
                                      pixel: 64,
                                      icon: AppImages.iconlovemessage,
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => SendMatch(
                                                  candidate: widget.candidate,
                                                  myProfile: profile)),
                                        );
                                      },
                                      onPress: false),
                                ],
                              ),
                            )
                          : Container(
                              width: 225 * pix,
                              height: 80 * pix,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 7,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  _buildActionButton(
                                      pixel: 64,
                                      icon: AppImages.xRed,
                                      onTap: () async {
                                        if (profile.whoyouskip.any((element) =>
                                            element ==
                                            widget.candidate.accountId)) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            content: Text(
                                                'Bạn đã bỏ qua người này rồi'),
                                            duration: Duration(seconds: 2),
                                          ));
                                          return;
                                        }
                                        await profileProvider.skipProfile(
                                            profile.accountId,
                                            widget.candidate.accountId,
                                            context);
                                      },
                                      onPress: false),
                                  _buildActionButton(
                                      pixel: 48,
                                      icon: AppImages.star,
                                      onTap: () async {
                                        if (profile.whoyousuperlike.any(
                                            (element) =>
                                                element ==
                                                widget.candidate.accountId)) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            content: Text(
                                                'Bạn đã superlike người này rồi'),
                                            duration: Duration(seconds: 2),
                                          ));
                                          return;
                                        }
                                        await profileProvider.superLikeProfile(
                                            profile.accountId,
                                            widget.candidate.accountId,
                                            context);
                                        if (checkCanMatch(
                                            profile, widget.candidate)) {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailPage(
                                                          candidate:
                                                              widget.candidate,
                                                          isMyProfile: widget
                                                              .isMyProfile,
                                                          canMatch: true)));
                                        } else {
                                          Navigator.pop(context);
                                        }
                                      },
                                      onPress: false),
                                  _buildActionButton(
                                      pixel: 64,
                                      icon: AppImages.loveGreen,
                                      onTap: () async {
                                        if (profile.whoyoulike.any((element) =>
                                            element ==
                                            widget.candidate.accountId)) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            content: Text(
                                                'Bạn đã superlike người này rồi'),
                                            duration: Duration(seconds: 2),
                                          ));
                                          return;
                                        }
                                        await profileProvider.likeProfile(
                                            profile.accountId,
                                            widget.candidate.accountId,
                                            context);
                                        if (checkCanMatch(
                                            profile, widget.candidate)) {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailPage(
                                                          candidate:
                                                              widget.candidate,
                                                          isMyProfile: widget
                                                              .isMyProfile,
                                                          canMatch: true)));
                                        } else {
                                          Navigator.pop(context);
                                        }
                                      },
                                      onPress: false),
                                ],
                              ),
                            ),
                    ),
            ],
          ),
        ),
      );
    });
  }

  String transIcon(String s) {
    if (s == 'zodic') {
      return AppImages.iconDetailHoroscope;
    } else if (s == 'education') {
      return AppImages.iconDetailEducationalLevel;
    } else if (s == 'family') {
      return AppImages.iconDetailLike;
    } else if (s == 'vaccin') {
      return AppImages.iconEditFaceMask;
    } else if (s == 'personality') {
      return AppImages.iconDetailGender;
    } else if (s == 'comunication') {
      return AppImages.iconDetailCommunicate;
    } else {
      return AppImages.iconDetailHoroscope;
    }
  }

  Widget _buildDetailRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey, size: 20),
          SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(fontSize: 14, color: Colors.black),
          ),
        ],
      ),
    );
  }

  // Widget _buildSectionTitle(String title) {
  //   final size = MediaQuery.of(context).size;
  //   final pix = size.width / 393;
  //   return Text(
  //     title,
  //     style: TextStyle(
  //       fontSize: 18 * pix,
  //       fontWeight: FontWeight.bold,
  //       color: Colors.black,
  //     ),
  //   );
  // }

  // Widget _buildChip(String label) {
  //   final size = MediaQuery.of(context).size;
  //   final pix = size.width / 393;
  //   return Chip(
  //     label: Text(label,
  //         style: TextStyle(
  //             color: Color(0xFFFF295F),
  //             fontFamily: 'BeVietnamPro',
  //             fontSize: 14*pix)),
  //     backgroundColor: Color(0xFFFF295F).withAlpha(50),
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
  //   );
  // }

  Widget _buildActionButton({
    required int pixel,
    required String icon,
    required VoidCallback onTap,
    required bool onPress,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
          width: pixel.toDouble(),
          height: pixel.toDouble(),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color:
                onPress ? Colors.white : const Color.fromARGB(255, 85, 85, 85),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(icon),
                fit: BoxFit.contain,
              ),
            ),
          )),
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

  @override
  void dispose() {
    super.dispose();
  }
}

Widget backgroundItem(String title, Widget child) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
    decoration: BoxDecoration(
      color: AppColors.background,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        // First shadow
        BoxShadow(
          color: const Color(0xffFF295F).withOpacity(0.09),
          offset: const Offset(0, 1.93), // X, Y offsets
          blurRadius: 4.25, // Blur radius
        ),
        // Second shadow
        BoxShadow(
          color: const Color(0xffFF295F).withOpacity(0.18),
          offset: const Offset(0, 5.11), // X, Y offsets
          blurRadius: 11.23, // Blur radius
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title, style: AppFonts.be600(13, AppColors.textPrimary)),
        const SizedBox(
          height: 8,
        ),
        child
      ],
    ),
  );
}

Widget itemDetail(String image, String content) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Image.asset(
        image,
        width: 16,
        height: 16,
      ),
      const SizedBox(
        width: 8,
      ),
      Expanded(
          child: Text(content,
              style:
                  AppFonts.be400(14, const Color(0xff000000).withOpacity(0.6))))
    ],
  );
}

Widget itemMoreInformation(
    String? image, String content, ItemInformationType? type) {
  return Container(
    padding: image != null
        ? const EdgeInsets.fromLTRB(8, 4, 10, 4)
        : const EdgeInsets.fromLTRB(12, 4, 12, 4),
    decoration: BoxDecoration(
        color: type == ItemInformationType.primary
            ? AppColors.primary.withOpacity(0.15)
            : const Color(0xff000000).withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
            width: 1,
            color: type == ItemInformationType.primary
                ? AppColors.primary.withOpacity(0.3)
                : const Color(0xff000000).withOpacity(0.1))),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        image != null
            ? Image.asset(
                image,
                width: 12,
                height: 12,
              )
            : const SizedBox.shrink(),
        image != null
            ? const SizedBox(
                width: 4,
              )
            : const SizedBox.shrink(),
        Flexible(
            child: Text(content,
                style: AppFonts.be400(
                    14,
                    type == ItemInformationType.primary
                        ? AppColors.primary
                        : AppColors.textPrimary)))
      ],
    ),
  );
}

enum ItemInformationType { primary, normal }
