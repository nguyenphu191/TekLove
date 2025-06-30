import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiklove_fe/provider/ProfileProvider.dart';
import 'package:tiklove_fe/res/images/app_images.dart';
import 'package:tiklove_fe/theme/app_colors.dart';

class EditSlogen extends StatefulWidget {
  const EditSlogen({super.key});

  @override
  State<EditSlogen> createState() => _EditSlogenState();
}

class _EditSlogenState extends State<EditSlogen> {
  Map<String, String> _slogen = {
    "Hãy bắt đầu hành trình": "Tìm kiếm trái tim, không phải chỉ một cuộc hẹn.",
    "Đừng ngại thử thách!": "Kết nối đam mê, khám phá tình yêu.",
    "Cùng nhau tạo nên điều đặc biệt":
        "Hẹn hò là nghệ thuật, hãy cùng sáng tạo.",
    "Nắm lấy cơ hội!": "Cuộc sống quá ngắn để không tiếp cận.",
    "Khởi đầu từ những điều nhỏ": "Chỉ cần một cú lướt để bắt đầu hành trình.",
    "Hãy tôi có bạn và bạn có tôi":
        "Tôi không chỉ tìm bạn, mà còn tìm người đồng hành.",
    "Tình yêu đang chờ đợi!": "Tìm một nửa hoàn hảo giữa phố phường đông đúc.",
    "Những điều tuyệt vời bắt đầu từ đây":
        "Tình yêu không có giới hạn, hãy thử nhé!",
    "Luôn lắng nghe bản thân": "Hãy để trái tim dẫn lối bạn.",
    "Hãy viết nên hành trình của chúng ta!":
        "Gặp nhau, không ngại ngần, mở ra một câu chuyện mới."
  };
  Future<void> _updateSlogen(String slogen) async {
    print(slogen);

    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    final profile = profileProvider.profile;
    print("Account ID: ${profile!.accountId}");
    try {
      final res = await profileProvider
          .updateProfile(profile.accountId, {"slogen": slogen});

      if (res) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Cập nhật thành công'),
          duration: Duration(seconds: 2),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Cập nhật thất bại'),
          duration: Duration(seconds: 2),
        ));
      }
    } catch (error) {
      print(error);
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
        return Center(child: CircularProgressIndicator());
      }

      return Container(
        height: 320 * pix,
        width: size.width,
        color: Colors.white,
        padding: EdgeInsets.all(16 * pix),
        child: Column(
          children: [
            Container(
              height: 20 * pix,
              width: size.width - 32 * pix,
              child: Text(
                'Câu gợi ý',
                style: TextStyle(
                    fontSize: 14 * pix,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'BeVietnamPro'),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(height: 5 * pix),
            Container(
              height: 200 * pix,
              width: size.width - 32 * pix,
              child: ListView.builder(
                itemCount: _slogen.length,
                itemBuilder: (context, index) {
                  return _Box1(
                      pix: pix,
                      width: size.width,
                      icon: AppImages.iconDetailQuotes,
                      title: _slogen.keys.elementAt(index),
                      content: _slogen.values.elementAt(index),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Bạn muốn chọn câu slogen này?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      _updateSlogen(
                                          _slogen.values.elementAt(index));
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Có'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Không'),
                                  ),
                                ],
                              );
                            });
                      });
                },
              ),
            ),
            SizedBox(height: 10 * pix),
            InkWell(
              onTap: () {
                TextEditingController sloganController =
                    TextEditingController();
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Thêm câu slogen'),
                        content: TextField(
                          controller: sloganController,
                          decoration: InputDecoration(
                            hintText: 'Nhập câu slogen',
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              if (sloganController.text.isNotEmpty) {
                                _updateSlogen(sloganController.text);
                                Navigator.of(context).pop();
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text('Vui lòng nhập câu slogen'),
                                  duration: Duration(seconds: 2),
                                ));
                              }
                            },
                            child: Text('Thêm'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Không'),
                          ),
                        ],
                      );
                    });
              },
              child: Container(
                height: 48 * pix,
                width: size.width - 32 * pix,
                padding: EdgeInsets.only(left: 40 * pix, right: 8 * pix),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.add,
                      color: const Color.fromARGB(255, 0, 0, 0),
                      size: 24 * pix,
                    ),
                    SizedBox(width: 8 * pix),
                    Text(
                      'Thêm một câu slogen theo ý bạn',
                      style: TextStyle(
                          fontSize: 14 * pix,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'BeVietnamPro'),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      );
    });
  }

  Widget _Box1({
    required double pix,
    required double width,
    required String icon,
    required String title,
    required String content,
    required Function() onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 58 * pix,
        width: width - 32 * pix,
        padding: EdgeInsets.all(6 * pix),
        margin: EdgeInsets.only(bottom: 5 * pix),
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 212, 222).withOpacity(0.8),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey)),
        child: Column(
          children: [
            Container(
              height: 20 * pix,
              width: width - 62 * pix,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        icon,
                        height: 18 * pix,
                        width: 18 * pix,
                        color: const Color.fromARGB(255, 255, 10, 72),
                      ),
                      SizedBox(width: 8 * pix),
                      Text(
                        title,
                        style: TextStyle(
                            fontSize: 12 * pix,
                            color: AppColors.primary,
                            fontFamily: 'BeVietnamPro'),
                      )
                    ],
                  ),
                  InkWell(
                      onTap: () {
                        setState(() {
                          _slogen.remove(title);
                        });
                      },
                      child: Icon(
                        Icons.close,
                        color: AppColors.primary,
                        size: 24 * pix,
                      ))
                ],
              ),
            ),
            Container(
              height: 20 * pix,
              width: width - 32 * pix,
              padding: EdgeInsets.only(left: 10 * pix),
              child: Text(
                content,
                style: TextStyle(
                    fontSize: 12 * pix,
                    fontFamily: 'BeVietnamPro',
                    overflow: TextOverflow.ellipsis),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
