import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiklove_fe/models/Profile.dart';
import 'package:tiklove_fe/pages/love/request_love/couple_card.dart';
import 'package:tiklove_fe/pages/message/message_page.dart';
import 'package:tiklove_fe/provider/AuthProvider.dart';
import 'package:tiklove_fe/provider/MessageProvider.dart';
import 'package:tiklove_fe/res/images/app_images.dart';

class SendMatch extends StatefulWidget {
  const SendMatch(
      {super.key, required this.myProfile, required this.candidate});
  final Profile myProfile;
  final Profile candidate;
  @override
  State<SendMatch> createState() => _SendMatchState();
}

class _SendMatchState extends State<SendMatch> {
  late TextEditingController _messageController;

  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    try {
      if (_messageController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Vui lòng nhập tin nhắn')));
        return;
      }

      final messProvider = Provider.of<MessageProvider>(context, listen: false);
      final bool res = await messProvider.sendMessage(
          senderId: widget.myProfile.accountId,
          receiverId: widget.candidate.accountId,
          content: _messageController.text,
          images: []);

      if (!mounted) return;

      if (res) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Đã gửi tin nhắn thành công')));
        _messageController.clear();
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const MessagePage()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Gửi tin nhắn thất bại')));
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Lỗi: ${e.toString()}')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pix = size.width / 393;

    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            Container(
              height: size.height,
              width: size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImages.matchBackground),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SafeArea(
              child: Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 56 * pix,
                  width: size.width,
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.only(left: 16 * pix, top: 16 * pix),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.close,
                      size: 30 * pix,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 80 * pix,
              left: (size.width - 245 * pix) / 2,
              right: (size.width - 245 * pix) / 2,
              child: Container(
                width: 245 * pix,
                height: 170 * pix,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppImages.match),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 260 * pix,
              left: (size.width - 274 * pix) / 2,
              child: Column(
                children: [
                  CoupleCard(
                    type: 'match',
                    myProfile: widget.myProfile,
                    candidate: widget.candidate,
                  ),
                  SizedBox(height: 24 * pix),
                  Text(
                    'Bạn đã tương hợp với ${widget.candidate.name}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16 * pix,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'BeVietnamPro',
                    ),
                  ),
                  SizedBox(height: 18 * pix),
                ],
              ),
            ),
            Positioned(
              bottom: 50 * pix,
              left: 16 * pix,
              right: 16 * pix,
              child: Column(
                children: [
                  Container(
                    height: 56 * pix,
                    width: size.width - 32 * pix,
                    padding: EdgeInsets.only(left: 16 * pix, right: 16 * pix),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _messageController,
                            decoration: InputDecoration(
                              hintText: 'Gửi lời chào đến nhau',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 16 * pix,
                                fontFamily: 'BeVietnamPro',
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: 16 * pix),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            await _sendMessage();
                          },
                          child: Container(
                            height: pix * 36,
                            width: 36 * pix,
                            child: Image.asset(
                              AppImages.iconSend,
                              width: 36 * pix,
                              height: 36 * pix,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16 * pix),
                  Container(
                    height: 56 * pix,
                    width: size.width - 32 * pix,
                    padding: EdgeInsets.only(left: 16 * pix, right: 16 * pix),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildImageButton(AppImages.newFriends),
                        _buildImageButton(AppImages.rectangle_333),
                        _buildImageButton(AppImages.rectangle_334),
                        _buildImageButton(AppImages.rectangle_335),
                        _buildImageButton(AppImages.rectangle_336),
                        _buildImageButton(AppImages.rectangle_337),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageButton(String imagePath) {
    final pix = MediaQuery.of(context).size.width / 393;
    return GestureDetector(
      onTap: () {
        // Xử lý khi nhấn vào icon
      },
      child: Image.asset(
        imagePath,
        width: 36 * pix,
        height: 36 * pix,
      ),
    );
  }
}
