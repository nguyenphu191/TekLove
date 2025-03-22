import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiklove_fe/provider/ProfileProvider.dart';

class EditIntro extends StatefulWidget {
  const EditIntro({super.key});

  @override
  State<EditIntro> createState() => _EditIntroState();
}

class _EditIntroState extends State<EditIntro> {
  late TextEditingController _introController;

  @override
  void initState() {
    super.initState();
    _introController = TextEditingController();
  }

  Future<void> _updateIntro() async {
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    final profile = profileProvider.profile;
    try {
      final res = await profileProvider.updateProfile(
          profile!.accountId, {"introduction": _introController.text});

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
      String preIntro = profile.introduction ?? "";
      return Column(
        children: [
          Container(
            height: 50 * pix,
            width: size.width,
            color: Colors.grey[200],
            padding: EdgeInsets.only(left: 16 * pix, top: 14 * pix),
            child: Text(
              'Thông tin cơ bản',
              style: TextStyle(
                fontSize: 16 * pix,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: 'BeVietnamPro',
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            height: 220 * pix,
            width: size.width,
            color: Colors.white,
            padding: EdgeInsets.all(16 * pix),
            child: Column(
              children: [
                Container(
                  height: 18 * pix,
                  width: size.width - 32 * pix,
                  child: Text(
                    'Giới thiệu bản thân',
                    style: TextStyle(
                        fontSize: 14 * pix,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'BeVietnamPro'),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(height: 5 * pix),
                Container(
                  height: 126 * pix,
                  width: size.width - 32 * pix,
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey)),
                  child: TextField(
                    maxLines: 5,
                    controller: _introController,
                    decoration: InputDecoration(
                      hintText: preIntro,
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(8 * pix),
                    ),
                  ),
                ),
                SizedBox(height: 5 * pix),
                InkWell(
                  onTap: () {
                    if (_introController.text.isNotEmpty) {
                      _updateIntro();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Vui lòng nhập thông tin'),
                        duration: Duration(seconds: 2),
                      ));
                    }
                  },
                  child: Container(
                    height: 30 * pix,
                    width: size.width,
                    alignment: Alignment.topRight,
                    padding: EdgeInsets.only(right: 16 * pix),
                    child: Icon(
                      Icons.save,
                      color: Colors.blue,
                      size: 30 * pix,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 1 * pix,
            width: size.width,
            color: Colors.grey,
          ),
        ],
      );
    });
  }
}
