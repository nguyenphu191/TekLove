import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiklove_fe/models/Profile.dart';
import 'package:tiklove_fe/pages/love/request_love/success_love.dart';
import 'package:tiklove_fe/pages/love/sendlove/topbar.dart';
import 'package:tiklove_fe/provider/LoveProvider.dart';
import 'package:tiklove_fe/provider/ProfileProvider.dart';
import 'package:tiklove_fe/res/images/app_images.dart';
import 'package:tiklove_fe/theme/app_colors.dart';
import 'package:tiklove_fe/utils.dart' as utils;

class SendLovePage extends StatefulWidget {
  const SendLovePage({super.key, required this.candidate});
  final Profile candidate;

  @override
  State<SendLovePage> createState() => _SendLovePageState();
}

class _SendLovePageState extends State<SendLovePage> {
  final String baseurl = utils.imgUrl;
  @override
  void initState() {
    super.initState();
  }

  void _send(BuildContext context, String myId, String candidateId) async {
    final loveProvider = Provider.of<LoveProvider>(context, listen: false);
    bool res = await loveProvider.send(myId, candidateId, context);
    if (res) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gửi yêu cầu thành công!'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gửi yêu cầu thất bại!'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _cancel(BuildContext context, String myId, String candidateId) async {
    final loveProvider = Provider.of<LoveProvider>(context, listen: false);
    bool res = await loveProvider.cancel(myId, candidateId, context);
    if (res) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Hủy yêu cầu thành công!'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Hủy yêu cầu thất bại!'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _accept(BuildContext context, String myId, String candidateId) async {
    final loveProvider = Provider.of<LoveProvider>(context, listen: false);
    bool res = await loveProvider.accept(myId, candidateId, context);
    if (res) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Chấp nhận yêu cầu thành công!'),
          duration: Duration(seconds: 2),
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SuccessLove(
            candidate: widget.candidate,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Chấp nhận yêu cầu thất bại!'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    final myprofile = profileProvider.profile;
    final size = MediaQuery.of(context).size;
    final pix = size.width / 393;
    return Consumer<LoveProvider>(builder: (context, loveProvider, child) {
      final love = loveProvider.love;
      final sendLove = loveProvider.sendLove;
      final recieverLove = loveProvider.recieverLove;
      bool issend = false;
      bool myreceive = false;
      if (love != null &&
          recieverLove!.any((love) =>
              love.sender['accountId'] == widget.candidate.accountId)) {
        myreceive = true;
      } else {
        if (love != null &&
            sendLove!.any((love) =>
                love.receiver['accountId'] == widget.candidate.accountId)) {
          issend = true;
        }
      }

      if (loveProvider.isLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      return Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                TopSendLove(candidate: widget.candidate),
                Container(
                  height: 128 * pix,
                  width: size.width,
                  padding: EdgeInsets.only(
                      left: (size.width - 361 * pix) / 2,
                      top: 16 * pix,
                      right: (size.width - 361 * pix) / 2,
                      bottom: 16 * pix),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 96 * pix,
                        width: 96 * pix,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(color: Colors.pink, width: 2),
                          image: DecorationImage(
                            image: NetworkImage(
                                '$baseurl/${widget.candidate.images[0]}'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        width: 169 * pix,
                        height: 40 * pix,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(AppImages.iconsendlove),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        height: 96 * pix,
                        width: 96 * pix,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(color: Colors.pink, width: 2),
                          image: DecorationImage(
                            image: NetworkImage(
                                '$baseurl/${myprofile!.images[0]}'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 72 * pix,
                  width: size.width,
                  padding: EdgeInsets.only(
                      left: 16 * pix, right: 16 * pix, top: 16 * pix),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: (love != null && love!.status == "success")
                      ? Text(
                          'Chúc mừng! Bạn và ${widget.candidate.name} đã trở thành một cặp đôi!',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        )
                      : !myreceive
                          ? issend
                              ? Text(
                                  'Bạn đã gửi yêu cầu đến ${widget.candidate.name}, hãy chờ hồi đáp nhé!',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary,
                                  ),
                                )
                              : Text(
                                  'Ngỏ ý hẹn hò với ${widget.candidate.name} và chờ hồi đáp thôi nào! Chúc bạn may mắn!',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary,
                                  ),
                                )
                          : Text(
                              '${widget.candidate.name} đã gửi yêu cầu hẹn hò đến bạn, hãy phản hồi sớm nhé!',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                ),
                Container(
                  height: 208 * pix,
                  width: size.width,
                  padding: EdgeInsets.only(
                      left: 16 * pix, right: 16 * pix, top: 16 * pix),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Container(
                    padding: EdgeInsets.only(
                        left: 10 * pix, right: 10 * pix, top: 10 * pix),
                    decoration: BoxDecoration(
                      color: Colors.pink[50],
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.primary, width: 1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              AppImages.iconCheckCircle,
                              height: 24 * pix,
                              width: 24 * pix,
                            ),
                            SizedBox(
                              width: 8 * pix,
                            ),
                            Text(
                              'Chuyển đổi sang chế độ tập trung hẹn hò',
                              style: TextStyle(
                                fontSize: 14 * pix,
                                fontFamily: 'BeVietnamPro',
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Image.asset(
                              AppImages.iconCheckCircle,
                              height: 24 * pix,
                              width: 24 * pix,
                            ),
                            SizedBox(
                              width: 8 * pix,
                            ),
                            Text(
                              'Cải tiến giao diện nhắn tin',
                              style: TextStyle(
                                fontSize: 14 * pix,
                                fontFamily: 'BeVietnamPro',
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Image.asset(
                              AppImages.iconCheckCircle,
                              height: 24 * pix,
                              width: 24 * pix,
                            ),
                            SizedBox(
                              width: 8 * pix,
                            ),
                            Text(
                              'Bộ đếm thời gian hẹn hò',
                              style: TextStyle(
                                fontSize: 14 * pix,
                                fontFamily: 'BeVietnamPro',
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Image.asset(
                              AppImages.iconCheckCircle,
                              height: 24 * pix,
                              width: 24 * pix,
                            ),
                            SizedBox(
                              width: 8 * pix,
                            ),
                            Text(
                              'Phần quà dành cho cặp đôi',
                              style: TextStyle(
                                fontSize: 14 * pix,
                                fontFamily: 'BeVietnamPro',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 150 * pix,
                  width: size.width,
                  padding: EdgeInsets.only(
                      left: 16 * pix, right: 16 * pix, top: 32 * pix),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Text(
                    !myreceive
                        ? 'Sau khi hẹn hò, hai người không thể truy cập chế độ tìm kiếm người tương hợp. Mọi thông tin của 2 bạn sẽ được ẩn khỏi những người khác.Để quay về chế độ tìm kiếm, một trong hai người cần hủy bỏ chế độ hẹn hò.'
                        : '${widget.candidate.name} đã gửi yêu cầu hẹn hò đến bạn, hãy phản hồi sớm nhé!',
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'BeVietnamPro',
                    ),
                  ),
                ),
                Divider(
                  height: 1,
                  color: Colors.grey,
                ),
              ],
            ),
            Positioned(
              bottom: 16,
              left: 68,
              right: 68,
              child: (love != null && love!.status == 'success')
                  ? InkWell(
                      onTap: () {
                        _cancel(context, myprofile.accountId,
                            widget.candidate.accountId);
                      },
                      child: Container(
                        height: 56 * pix,
                        width: 280 * pix,
                        padding: EdgeInsets.only(
                            left: 48 * pix, top: 16 * pix, right: 16 * pix),
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(255, 109, 109, 109)
                                  .withOpacity(0.5),
                              offset: Offset(0, 3),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 24 * pix,
                              width: 24 * pix,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Icon(
                                Icons.heart_broken,
                                size: 18 * pix,
                                color: AppColors.primary,
                              ),
                            ),
                            SizedBox(width: 16 * pix),
                            Text(
                              'Hủy hẹn hò',
                              style: TextStyle(
                                fontSize: 16 * pix,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 255, 255, 255),
                                fontFamily: 'BeVietnamPro',
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : myreceive
                      ? Container(
                          height: 56 * pix,
                          width: 361 * pix,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  _cancel(context, myprofile.accountId,
                                      widget.candidate.accountId);
                                },
                                child: Container(
                                  height: 56 * pix,
                                  width: 156 * pix,
                                  padding: EdgeInsets.only(top: 16 * pix),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Text(
                                    'Từ chối',
                                    style: TextStyle(
                                      fontSize: 16 * pix,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w300,
                                      fontFamily: 'BeVietnamPro',
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  _accept(context, myprofile.accountId,
                                      widget.candidate.accountId);
                                },
                                child: Container(
                                  height: 56 * pix,
                                  width: 156 * pix,
                                  padding: EdgeInsets.only(top: 16 * pix),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    borderRadius: BorderRadius.circular(50),
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            AppColors.primary.withOpacity(0.5),
                                        offset: Offset(0, 3),
                                        blurRadius: 10,
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    'Chấp nhận',
                                    style: TextStyle(
                                      fontSize: 16 * pix,
                                      color: const Color.fromARGB(
                                          255, 255, 255, 255),
                                      fontFamily: 'BeVietnamPro',
                                      fontWeight: FontWeight.w300,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : !issend
                          ? InkWell(
                              onTap: () {
                                _send(context, myprofile.accountId,
                                    widget.candidate.accountId);
                              },
                              child: Container(
                                height: 56 * pix,
                                width: 361 * pix,
                                padding: EdgeInsets.only(
                                    left: 48 * pix,
                                    top: 16 * pix,
                                    right: 16 * pix),
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(50),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.primary.withOpacity(0.5),
                                      offset: Offset(0, 3),
                                      blurRadius: 10,
                                    ),
                                  ],
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 24 * pix,
                                      width: 24 * pix,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Icon(
                                        Icons.favorite,
                                        size: 18 * pix,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                    SizedBox(width: 16 * pix),
                                    Text(
                                      'Gửi yêu cầu hẹn hò',
                                      style: TextStyle(
                                        fontSize: 16 * pix,
                                        fontWeight: FontWeight.bold,
                                        color: const Color.fromARGB(
                                            255, 255, 255, 255),
                                        fontFamily: 'BeVietnamPro',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Container(
                              height: 56 * pix,
                              width: 361 * pix,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      _cancel(context, myprofile.accountId,
                                          widget.candidate.accountId);
                                    },
                                    child: Container(
                                      height: 56 * pix,
                                      width: 156 * pix,
                                      padding: EdgeInsets.only(top: 16 * pix),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Text(
                                        'Hủy',
                                        style: TextStyle(
                                          fontSize: 16 * pix,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w300,
                                          fontFamily: 'BeVietnamPro',
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: Container(
                                      height: 56 * pix,
                                      width: 156 * pix,
                                      padding: EdgeInsets.only(top: 16 * pix),
                                      decoration: BoxDecoration(
                                        color: AppColors.primary,
                                        borderRadius: BorderRadius.circular(50),
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppColors.primary
                                                .withOpacity(0.5),
                                            offset: Offset(0, 3),
                                            blurRadius: 10,
                                          ),
                                        ],
                                      ),
                                      child: Text(
                                        'Tiếp tục chờ',
                                        style: TextStyle(
                                          fontSize: 16 * pix,
                                          color: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontFamily: 'BeVietnamPro',
                                          fontWeight: FontWeight.w300,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
            ),
          ],
        ),
      );
    });
  }
}
