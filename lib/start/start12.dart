import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tiklove_fe/pages/home/home.dart';
import 'package:tiklove_fe/provider/AuthProvider.dart';
import 'package:tiklove_fe/provider/ProfileProvider.dart';
import 'package:tiklove_fe/widgets/add_box.dart';
import 'package:tiklove_fe/widgets/image_box.dart';

class Start12Page extends StatefulWidget {
  const Start12Page({
    super.key,
  });

  @override
  State<Start12Page> createState() => _Start12PageState();
}

class _Start12PageState extends State<Start12Page> {
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

  // Upload ảnh lên backend
  Future<void> _uploadImages() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    try {
      final res = await profileProvider.uploadImages(
          context, authProvider.account!.id, _images);
      if (res) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
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
      body: Stack(
        children: [
          // Gradient Background
          Container(
            height: size.height,
            width: size.width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white,
                  Color(0xFFFF7A9C),
                ],
              ),
            ),
          ),
          // Logo Positioned
          Positioned(
            top: 70 * pix,
            left: 79 * pix,
            child: Container(
              height: 53 * pix,
              width: 235 * pix,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/Teklove/teklove2.png'),
                ),
              ),
            ),
          ),
          // Main Content
          Positioned(
            top: 165 * pix,
            left: 8 * pix,
            right: 8 * pix,
            bottom: 15 * pix,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 480 * pix,
                      width: double.maxFinite,
                      margin: EdgeInsets.only(
                        top: 16 * pix,
                        left: 32 * pix,
                        right: 32 * pix,
                      ),
                      child: Column(
                        children: [
                          // Progress Indicator
                          Container(
                            height: 20 * pix,
                            width: double.maxFinite,
                            child: Text(
                              '12/12',
                              style: TextStyle(
                                fontSize: 15 * pix,
                                color: Colors.red,
                                fontFamily: 'BeVietnamPro',
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          SizedBox(height: 15 * pix),
                          // Title
                          Container(
                            height: 42 * pix,
                            width: double.maxFinite,
                            child: Text(
                              'Thêm ảnh của bạn',
                              style: TextStyle(
                                fontSize: 20 * pix,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'BeVietnamPro',
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          SizedBox(height: 10 * pix),
                          // Subtitle
                          Container(
                            width: double.maxFinite,
                            child: Text(
                              'Tải lên 2 ảnh để bắt đầu. Thêm càng nhiều hồ sơ của bạn càng nổi bật.',
                              style: TextStyle(
                                fontSize: 12 * pix,
                                fontFamily: 'BeVietnamPro',
                              ),
                            ),
                          ),
                          // Image Grid
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: 15 * pix,
                                  left: 15 * pix,
                                  right: 15 * pix),
                              width: double.maxFinite,
                              child: GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 5 * pix,
                                  mainAxisSpacing: 5 * pix,
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
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 60 * pix,
                      width: double.maxFinite,
                      margin: EdgeInsets.all(18 * pix),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              borderRadius: BorderRadius.circular(30),
                              child: Container(
                                height: 56 * pix,
                                width: 164 * pix,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 240, 235, 235),
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xFFF4F4F4),
                                      offset: Offset(0, 2),
                                      spreadRadius: 1.5,
                                      blurRadius: 16, // Độ mờ của bóng
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    'Trước',
                                    style: TextStyle(
                                      color: Colors.black, // Màu chữ
                                      fontSize: 17 * pix,
                                      fontFamily: 'BeVietnamPro',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                _uploadImages();
                              },
                              borderRadius: BorderRadius.circular(30),
                              child: Container(
                                height: 56 * pix,
                                width: 164 * pix,
                                decoration: BoxDecoration(
                                  color: Color(0xFFFF295F),
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromARGB(255, 250, 37, 90),
                                      offset: Offset(0, 2),
                                      spreadRadius: 1.5,
                                      blurRadius: 6, // Độ mờ của bóng
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    'Tiếp theo',
                                    style: TextStyle(
                                      color: Colors.white, // Màu chữ
                                      fontSize: 18 * pix,
                                      fontFamily: 'BeVietnamPro',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
