import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiklove_fe/res/images/app_images.dart';
import 'package:tiklove_fe/theme/app_colors.dart';

class PostPage extends StatefulWidget {
  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  List<File> _selectedImages = [];
  final TextEditingController _captionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  bool _isPosting = false;
  final now = DateTime.now();

  // Hàm chọn ảnh từ thư viện
  Future<void> _pickImages() async {
    final List<XFile>? images = await _picker.pickMultiImage();
    if (images != null) {
      setState(() {
        _selectedImages = images.map((img) => File(img.path)).toList();
      });
    }
  }

  // Hàm tải ảnh lên Firebase Storage
  Future<List<String>> _uploadImages() async {
    List<String> downloadUrls = [];
    for (var image in _selectedImages) {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference ref =
          FirebaseStorage.instance.ref().child('posts/$fileName.jpg');
      await ref.putFile(image);
      String downloadUrl = await ref.getDownloadURL();
      downloadUrls.add(downloadUrl);
    }
    return downloadUrls;
  }

  // Hàm đăng bài viết
  Future<void> _post() async {
    if (_selectedImages.isEmpty && _captionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Hãy chọn ít nhất một ảnh hoặc nhập caption!")),
      );
      return;
    }

    setState(() {
      _isPosting = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Đăng bài thành công!")),
    );

    setState(() {
      _selectedImages.clear();
      _captionController.clear();
      _isPosting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pix = size.width / 393;
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              // Caption nhập văn bản
              Container(
                height: 162 * pix,
                width: size.width,
                color: Colors.white,
                padding: EdgeInsets.all(16 * pix),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 28 * pix,
                          width: 160 * pix,
                          padding:
                              EdgeInsets.only(top: 4 * pix, left: 10 * pix),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.grey[200],
                          ),
                          child: Text(
                            'Hôm nay, ${now.day}/${now.month}/${now.year}',
                            style: TextStyle(
                              fontSize: 14 * pix,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'BeVietnamPro',
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 36 * pix,
                            width: 36 * pix,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.grey[300],
                            ),
                            child: Icon(
                              Icons.close,
                              size: 25 * pix,
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          height: 40 * pix,
                          width: 40 * pix,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            image: DecorationImage(
                              image: AssetImage(AppImages.avatarBoy),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 10 * pix),
                        Text(
                          "Nguyễn Văn A",
                          style: TextStyle(
                              fontSize: 16 * pix, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    TextField(
                      controller: _captionController,
                      decoration: InputDecoration(
                        hintText: "Bạn đang nghĩ gì?",
                        border: InputBorder.none,
                      ),
                      maxLines: null,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),

              // Hiển thị ảnh đã chọn
              _selectedImages.isNotEmpty
                  ? SizedBox(
                      height: 150,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _selectedImages.length,
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                width: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: FileImage(_selectedImages[index]),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 5,
                                right: 5,
                                child: CircleAvatar(
                                  backgroundColor: Colors.black54,
                                  child: IconButton(
                                    icon: Icon(Icons.close,
                                        color: Colors.white, size: 18),
                                    onPressed: () {
                                      setState(() {
                                        _selectedImages.removeAt(index);
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    )
                  : Container(),

              SizedBox(height: 10),

              // Nút chọn ảnh
              ElevatedButton.icon(
                onPressed: _pickImages,
                icon: Icon(Icons.photo_library),
                label: Text("Chọn ảnh"),
              ),

              if (_isPosting) CircularProgressIndicator()
            ],
          ),
          Positioned(
              bottom: 16 * pix,
              right: (size.width - 150 * pix) / 2,
              left: (size.width - 150 * pix) / 2,
              child: InkWell(
                onTap: () {
                  _isPosting ? null : _post();
                },
                child: Container(
                  height: 56 * pix,
                  width: 150 * pix,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: AppColors.primary,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.5),
                        offset: Offset(0, 5),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      "Đăng",
                      style: TextStyle(
                        fontSize: 18 * pix,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
