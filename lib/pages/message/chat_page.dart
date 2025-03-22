import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiklove_fe/models/Account.dart';
import 'package:tiklove_fe/models/Profile.dart';
import 'package:tiklove_fe/pages/love/sendlove/send_love_page.dart';
import 'package:tiklove_fe/provider/LoveProvider.dart';
import 'package:tiklove_fe/provider/MessageProvider.dart';
import 'package:tiklove_fe/provider/ProfileProvider.dart';
import 'package:tiklove_fe/res/images/app_images.dart';
import 'package:tiklove_fe/theme/app_colors.dart';
import 'package:tiklove_fe/utils.dart' as utils;

import 'package:tiklove_fe/widgets/bottom_chat_bar.dart';
import 'package:tiklove_fe/widgets/top_chat_bar.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.candidate});
  final Account candidate;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final String baseurl = utils.imgUrl;
  final ScrollController _scrollController = ScrollController();
  Profile? _profile;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final profileProvider =
          Provider.of<ProfileProvider>(context, listen: false);
      final messageProvider =
          Provider.of<MessageProvider>(context, listen: false);
      messageProvider.fetchMessages(
          profileProvider.profile!.accountId, widget.candidate.id);
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
      final myprofile = profileProvider.profile;
      final loveProvider = Provider.of<LoveProvider>(context, listen: false);
      loveProvider.getLoveInfor(myprofile!.accountId, widget.candidate.id);
      _fetchProfile();
    });
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
    final profileProvider = Provider.of<ProfileProvider>(context);
    final profile = profileProvider.profile;
    final loveProvider = Provider.of<LoveProvider>(context);
    final love = loveProvider.love;
    return Consumer<MessageProvider>(
        builder: (context, messageProvider, child) {
      final messages = messageProvider.getMessages();
      if (messageProvider.isLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      // Sau khi build xong, tự động cuộn xuống cuối danh sách
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
      return Scaffold(
          body: Stack(
        children: [
          Positioned(
            bottom: 72,
            left: 0,
            right: 0,
            child: SingleChildScrollView(
              child: Container(
                height: size.height - 162 * pix,
                width: size.width,
                decoration: (love != null && love.status == "success")
                    ? const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(AppImages.lovebackground),
                          fit: BoxFit.cover,
                        ),
                      )
                    : const BoxDecoration(
                        color: Color(0xFFFFF2F6),
                      ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return messages.isEmpty
                        ? Center(
                            child: Text(
                              'No messages yet!',
                              style: TextStyle(
                                  fontSize: 16 * pix, color: Colors.black),
                            ),
                          )
                        : ListView.builder(
                            controller: _scrollController,
                            reverse: false,
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            itemCount: messages.length,
                            itemBuilder: (context, index) {
                              final message = messages[index];
                              bool isSender = message.sender['accountId'] ==
                                  profile?.accountId;

                              // Xác định màu nền và màu chữ
                              Color backgroundColor;
                              Color textColor;

                              if (love != null && love.status == "success") {
                                backgroundColor = AppColors.primary;
                                textColor = Colors.white;
                              } else {
                                backgroundColor = Colors.blue[500]!;
                                textColor =
                                    const Color.fromARGB(255, 255, 255, 255);
                              }

                              return Align(
                                alignment: isSender
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  padding: EdgeInsets.all(10 * pix),
                                  decoration: BoxDecoration(
                                    color: backgroundColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: message.imageUrl.isEmpty
                                      ? Text(
                                          message.content,
                                          style: TextStyle(
                                              color: textColor,
                                              fontSize: 16 * pix),
                                        )
                                      : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              message.content,
                                              style: TextStyle(
                                                  color: textColor,
                                                  fontSize: 16 * pix),
                                            ),
                                            SizedBox(height: 10 * pix),
                                            Wrap(
                                              spacing: 8.0,
                                              runSpacing: 8.0,
                                              children:
                                                  message.imageUrl.map((url) {
                                                return Container(
                                                  height: 160 * pix,
                                                  width: 160 * pix,
                                                  child: Image.network(
                                                    '$baseurl/$url',
                                                    fit: BoxFit.cover,
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          ],
                                        ),
                                ),
                              );
                            },
                          );
                  },
                ),
              ),
            ),
          ),
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: (love != null && love.status == 'success')
                  ? TopChatBar(
                      candidate: widget.candidate,
                      isLove: true,
                    )
                  : TopChatBar(
                      candidate: widget.candidate,
                      isLove: false,
                    )),
          Positioned(
            top: 90 * pix,
            left: 26 * pix,
            right: 26 * pix,
            child: (love != null && love.status == 'pending')
                ? Container(
                    height: 100 * pix,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(16 * pix),
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 40 * pix,
                          width: size.width - 52 * pix,
                          padding: EdgeInsets.all(10 * pix),
                          child: love.sender['accountId'] == profile?.accountId
                              ? Text(
                                  "Bạn đã gửi yêu cầu hẹn hò",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14 * pix,
                                      color: Colors.white),
                                  textAlign: TextAlign.center,
                                )
                              : Text(
                                  "Đối phương đang yêu cầu hẹn hò",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14 * pix,
                                      color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                        ),
                        Container(
                          height: 1 * pix,
                          margin:
                              EdgeInsets.only(left: 16 * pix, right: 16 * pix),
                          color: Colors.white,
                        ),
                        Container(
                          height: 50 * pix,
                          width: size.width - 52 * pix,
                          padding:
                              EdgeInsets.only(left: 16 * pix, right: 16 * pix),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(AppImages.waitac,
                                  height: 36 * pix, width: 180 * pix),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SendLovePage(
                                              candidate: _profile!)));
                                },
                                child: Container(
                                  height: 36 * pix,
                                  width: 88 * pix,
                                  margin: EdgeInsets.only(top: 5 * pix),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Xem xét",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14 * pix,
                                          color: AppColors.primary),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(height: 0, width: 0),
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: BottomChatBar(
                candidate: widget.candidate,
              )),
        ],
      ));
    });
  }
}
