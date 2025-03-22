import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiklove_fe/models/Account.dart';
import 'package:tiklove_fe/models/Profile.dart';
import 'package:tiklove_fe/models/message.dart';
import 'package:tiklove_fe/pages/message/chat_page.dart';
import 'package:tiklove_fe/provider/AuthProvider.dart';
import 'package:tiklove_fe/provider/ProfileProvider.dart';
import 'package:tiklove_fe/res/images/app_images.dart';
import 'package:tiklove_fe/utils.dart' as utils;

class MessCard extends StatefulWidget {
  const MessCard({super.key, required this.message});
  final Message message;

  @override
  State<MessCard> createState() => _MessCardState();
}

class _MessCardState extends State<MessCard> {
  Account? candidateAccount; // Biến lưu thông tin Account của candidate
  Profile? clientProfile;
  final String baseurl = utils.imgUrl;

  @override
  void initState() {
    super.initState();
    _fetchCandidateAccount();
  }

  void _fetchCandidateAccount() async {
    // Lấy Profile hiện tại để so sánh với sender và receiver
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final profile = profileProvider.profile;
    if (profile == null) return;

    // Xác định candidateId: nếu profile của mình trùng với receiver thì candidate là sender, ngược lại là receiver.
    final candidateId =
        widget.message.receiver['accountId'] == profile.accountId
            ? widget.message.sender['accountId']
            : widget.message.receiver['accountId'];

    try {
      final fetchedAccount = await authProvider.getAccount(candidateId);
      final fetchedProfile =
          await profileProvider.getProfileById(candidateId, context);

      if (mounted) {
        setState(() {
          candidateAccount = fetchedAccount;
          clientProfile = fetchedProfile;
        });
      }
    } catch (e) {
      // Xử lý lỗi nếu cần
      print('Error fetching candidate account: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pix = size.width / 393;

    return Consumer<ProfileProvider>(
      builder: (context, profileProvider, child) {
        final profile = profileProvider.profile;
        if (profile == null || profileProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return InkWell(
          onTap: () {
            if (candidateAccount != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatPage(
                    candidate: candidateAccount!,
                  ),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Loading...'),
                ),
              );
            }
          },
          child: Container(
            height: 88 * pix,
            width: size.width,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Row(
              children: [
                Container(
                  height: 64 * pix,
                  width: 64 * pix,
                  margin: EdgeInsets.only(left: 16 * pix),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: (clientProfile?.images.isEmpty ?? true)
                          ? (clientProfile?.gender == 'Nam' ||
                                  clientProfile?.gender == 'Khác')
                              ? const AssetImage(AppImages.avatarBoy)
                              : const AssetImage(AppImages.avatarGirl)
                          : NetworkImage(
                              '$baseurl/${clientProfile!.images[0]}',
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
                            shape: BoxShape.circle,
                            color: candidateAccount != null
                                ? (candidateAccount!.isOn
                                    ? Colors.green
                                    : const Color.fromARGB(255, 249, 0, 0))
                                : Colors.transparent,
                          ),
                          child: candidateAccount == null
                              ? Center(
                                  child: SizedBox(
                                    width: 10 * pix,
                                    height: 10 * pix,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  ),
                                )
                              : null,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 88 * pix,
                  width: size.width - 80 * pix,
                  padding: EdgeInsets.only(
                      left: 16 * pix, right: 16 * pix, top: 8 * pix),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                clientProfile?.name ?? 'Unknown',
                                style: TextStyle(
                                  fontSize: 16 * pix,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'BeVietnamPro',
                                ),
                              ),
                              SizedBox(width: 5 * pix),
                              clientProfile?.verified ?? false
                                  ? Image.asset(AppImages.iconVerify,
                                      height: 16 * pix, width: 16 * pix)
                                  : SizedBox(),
                            ],
                          ),
                          Spacer(),
                          Text(
                            widget.message.createdAt
                                .toString()
                                .substring(5, 16),
                            style: TextStyle(
                              fontSize: 12 * pix,
                              color: const Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10 * pix),
                      Text(
                        widget.message.content.isEmpty
                            ? widget.message.imageUrl != null
                                ? "A image"
                                : "A message"
                            : widget.message.content,
                        style: TextStyle(
                          fontSize: 14 * pix,
                          color: Colors.grey,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
