import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tiklove_fe/models/Account.dart';
import 'package:tiklove_fe/pages/love/sendlove/send_love_page.dart';
import 'package:tiklove_fe/provider/AuthProvider.dart';
import 'package:tiklove_fe/provider/MessageProvider.dart';
import 'package:tiklove_fe/res/images/app_images.dart';

class BottomChatBar extends StatefulWidget {
  const BottomChatBar({super.key, required this.candidate});
  final Account candidate;

  @override
  State<BottomChatBar> createState() => _BottomChatBarState();
}

class _BottomChatBarState extends State<BottomChatBar> {
  TextEditingController _messageController = TextEditingController();
  List<XFile> _images = [];
  final ImagePicker _picker = ImagePicker();

  // Chọn ảnh từ thiết bị
  Future<void> _pickImages() async {
    final pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles != null) {
      setState(() {
        _images.addAll(pickedFiles);
      });
    }
  }

  // Xóa ảnh đã chọn
  void _removeImage(int index) {
    setState(() {
      _images.removeAt(index);
    });
  }

  Future<void> _sendMessage() async {
    if (_messageController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Vui lòng nhập tin nhắn')));
    } else {
      final messProvider = Provider.of<MessageProvider>(context, listen: false);
      final acc = Provider.of<AuthProvider>(context, listen: false).account;
      final bool res = await messProvider.sendMessage(
          senderId: acc!.id,
          receiverId: widget.candidate.id,
          content: _messageController.text,
          images: _images);
      if (res) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Đã gửi tin nhắn thành công')));
        _messageController.clear();
        _images.clear();
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Gửi tin nhắn thất bại')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pix = size.width / 393;
    return Column(
      children: [
        // Hiển thị các ảnh đã chọn
        if (_images.isNotEmpty)
          Container(
            height: 100 * pix,
            padding: EdgeInsets.symmetric(horizontal: 10 * pix),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _images.length,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 10 * pix),
                      child: Image.file(
                        File(_images[index].path),
                        width: 80 * pix,
                        height: 80 * pix,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: InkWell(
                        onTap: () => _removeImage(index),
                        child: Container(
                          padding: EdgeInsets.all(4 * pix),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red,
                          ),
                          child: Icon(
                            Icons.close,
                            size: 16 * pix,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        Container(
          height: 72 * pix,
          width: size.width,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                children: [
                  InkWell(
                    onTap: () {
                      _pickImages();
                    },
                    child: Container(
                      height: 48 * pix,
                      width: 48 * pix,
                      margin: EdgeInsets.only(left: 10 * pix),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[200],
                      ),
                      child: Image.asset(AppImages.iconImg,
                          height: 24 * pix, width: 24 * pix),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      height: 16 * pix,
                      width: 16 * pix,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color.fromARGB(255, 35, 255, 43),
                      ),
                      child: Center(
                        child: Text(
                          _images.length.toString(),
                          style: TextStyle(
                            fontSize: 12 * pix,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  height: 48 * pix,
                  width: 48 * pix,
                  margin: EdgeInsets.only(left: 5 * pix),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[200],
                  ),
                  child: Image.asset(AppImages.iconMicrophone,
                      height: 24 * pix, width: 24 * pix),
                ),
              ),
              SizedBox(width: 8 * pix),
              Container(
                height: 48 * pix,
                width: 210 * pix,
                padding: EdgeInsets.only(left: 16 * pix),
                margin: EdgeInsets.only(right: 5 * pix),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(24 * pix),
                ),
                child: TextField(
                  controller: _messageController,
                  decoration: InputDecoration(
                    hintText: 'Viết gì đó...',
                    hintStyle: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 14 * pix,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  _sendMessage();
                },
                child: Container(
                    height: 48 * pix,
                    width: 48 * pix,
                    margin: EdgeInsets.only(right: 5 * pix),
                    padding: EdgeInsets.only(left: 5 * pix),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[200],
                    ),
                    child: Icon(
                      Icons.send,
                      color: Colors.blue[500],
                      size: pix * 30,
                    )),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
