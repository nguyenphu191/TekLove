import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiklove_fe/models/Account.dart';
import 'package:tiklove_fe/models/Profile.dart';
import 'package:tiklove_fe/pages/love/sendlove/send_love_page.dart';
import 'package:tiklove_fe/provider/ProfileProvider.dart';
import 'package:tiklove_fe/res/images/app_images.dart';
import 'package:tiklove_fe/theme/app_colors.dart';
import 'package:tiklove_fe/utils.dart' as utils;

class TopChatBar extends StatefulWidget {
  const TopChatBar({super.key, required this.candidate, required this.isLove});
  final Account candidate;
  final bool isLove;
  @override
  State<TopChatBar> createState() => _TopChatBarState();
}

class _TopChatBarState extends State<TopChatBar> {
  final String baseurl = utils.imgUrl;
  Profile? _profile;

  @override
  void initState() {
    super.initState();
    _fetchProfile();
  }

  void _fetchProfile() async {
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    try {
      final fetchedProfile =
          await profileProvider.getProfileById(widget.candidate.id, context);
      setState(() {
        _profile = fetchedProfile;
      });
    } catch (e) {
      print('Error fetching profile: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pix = size.width / 393;
    return Container(
      height: 80 * pix,
      width: size.width,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: _profile != null
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Container(
                      height: 64 * pix,
                      width: 64 * pix,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: (_profile?.images.isEmpty ?? true)
                              ? (_profile?.gender == 'Nam' ||
                                      _profile?.gender == 'Khác')
                                  ? const AssetImage(AppImages.avatarBoy)
                                  : const AssetImage(AppImages.avatarGirl)
                              : NetworkImage(
                                  '$baseurl/${_profile!.images[0]}',
                                ) as ImageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                              right: 1 * pix,
                              bottom: 1 * pix,
                              child: Container(
                                height: 16 * pix,
                                width: 16 * pix,
                                decoration: BoxDecoration(
                                  color: widget.candidate.isOn
                                      ? Colors.green
                                      : const Color.fromARGB(255, 249, 0, 0),
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 255, 255, 255)),
                                ),
                              ))
                        ],
                      ),
                    ),
                    Container(
                      height: 88 * pix,
                      width: size.width - 200 * pix,
                      padding: EdgeInsets.only(
                          left: 16 * pix, right: 10 * pix, top: 20 * pix),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 120 * pix,
                                child: Text(
                                  _profile!.name,
                                  style: TextStyle(
                                    fontSize: 16 * pix,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'BeVietnamPro',
                                    color: widget.isLove
                                        ? AppColors.primary
                                        : Colors.black,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(width: 5 * pix),
                              Image.asset(
                                  widget.isLove
                                      ? AppImages.iconHeartCircle
                                      : AppImages.iconVerify,
                                  height: 26 * pix,
                                  width: 26 * pix),
                            ],
                          ),
                          _profile!.verified
                              ? Container(
                                  width: double.maxFinite,
                                  child: Text(
                                    'Online',
                                    style: TextStyle(
                                      fontSize: 12 * pix,
                                      color: Colors.grey[800],
                                      fontFamily: 'BeVietnamPro',
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                )
                              : Container(
                                  width: double.maxFinite,
                                  child: Text(
                                    'Offline',
                                    style: TextStyle(
                                      fontSize: 12 * pix,
                                      color: Colors.grey[800],
                                      fontFamily: 'BeVietnamPro',
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          contentPadding: EdgeInsets.all(16 * pix),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                leading:
                                    const Icon(Icons.delete, color: Colors.red),
                                title: const Text("Xóa đoạn chat",
                                    style: TextStyle(color: Colors.red)),
                                onTap: () {
                                  // Xử lý xóa đoạn chat
                                  Navigator.pop(context);
                                },
                              ),
                              const Divider(),
                              ListTile(
                                leading: const Icon(Icons.report,
                                    color: Colors.orange),
                                title: const Text("Báo cáo người dùng",
                                    style: TextStyle(color: Colors.orange)),
                                onTap: () {
                                  // Xử lý báo cáo người dùng
                                  Navigator.pop(context);
                                },
                              ),
                              const Divider(),
                              ListTile(
                                leading:
                                    const Icon(Icons.block, color: Colors.grey),
                                title: const Text("Chặn",
                                    style: TextStyle(color: Colors.grey)),
                                onTap: () {
                                  // Xử lý chặn người dùng
                                  Navigator.pop(context);
                                },
                              ),
                              const Divider(),
                              ListTile(
                                leading: const Icon(Icons.favorite,
                                    color: Colors.pink),
                                title: widget.isLove
                                    ? const Text("Hủy hẹn hò",
                                        style: TextStyle(color: Colors.pink))
                                    : const Text("Gửi yêu cầu hẹn hò",
                                        style: TextStyle(color: Colors.pink)),
                                onTap: () {
                                  if (_profile != null) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SendLovePage(
                                                candidate: _profile!)));
                                  }
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
