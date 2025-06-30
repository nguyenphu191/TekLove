import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiklove_fe/provider/AuthProvider.dart';
import 'package:tiklove_fe/start/login.dart';
import 'package:tiklove_fe/theme/app_colors.dart';

class SettingAcount extends StatefulWidget {
  const SettingAcount({super.key});

  @override
  State<SettingAcount> createState() => _SettingAcountState();
}

class _SettingAcountState extends State<SettingAcount> {
  String selectedOption1 = 'light_mode';
  String selectedOption2 = 'vietnamese';
  String selectedOption3 = 'wifi&3g';
  bool isEventEnabled = false;
  bool isTopPickEnabled = false;
  bool isDirectMsgEnabled = false;
  bool isGoldenHourEnabled = false;
  bool isActiveStatusEnabled = false;
  bool isRecentActivityEnabled = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pix = size.width / 393;
    return Column(
      children: [
        Container(
          height: 50 * pix,
          width: size.width,
          color: Colors.grey[200],
          padding: EdgeInsets.only(left: 16 * pix, top: 14 * pix),
          child: Text(
            'Cài đặt tài khoản',
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
          height: 1 * pix,
          width: size.width,
          color: Colors.grey,
        ),
        _buildTitle('Giao diện'),
        Container(
          height: 170 * pix,
          width: size.width,
          color: Colors.white,
          padding: EdgeInsets.all(10 * pix),
          child: Column(
            children: <Widget>[
              RadioListTile(
                value: 'settings',
                groupValue: selectedOption1,
                onChanged: (value) {
                  setState(() {
                    selectedOption1 = value as String;
                  });
                },
                title: Text(
                  'Cài đặt hệ thống',
                  style: TextStyle(fontSize: 14 * pix),
                ),
                dense: true,
                activeColor: AppColors.primary,
              ),
              RadioListTile(
                value: 'light_mode',
                groupValue: selectedOption1,
                onChanged: (value) {
                  setState(() {
                    selectedOption1 = value as String;
                  });
                },
                title: Text(
                  'Chế độ sáng',
                  style: TextStyle(fontSize: 14 * pix),
                ),
                dense: true,
                activeColor: AppColors.primary,
              ),
              RadioListTile(
                value: 'dark_mode',
                groupValue: selectedOption1,
                onChanged: (value) {
                  setState(() {
                    selectedOption1 = value as String;
                  });
                },
                title: Text(
                  'Chế độ tối',
                  style: TextStyle(fontSize: 14 * pix),
                ),
                dense: true,
                activeColor: AppColors.primary,
              ),
            ],
          ),
        ),
        _buildTitle('Ngôn ngữ'),
        Container(
          height: 120 * pix,
          width: size.width,
          color: Colors.white,
          padding: EdgeInsets.all(10 * pix),
          child: Column(
            children: <Widget>[
              RadioListTile(
                value: 'vietnamese',
                groupValue: selectedOption2,
                onChanged: (value) {
                  setState(() {
                    selectedOption2 = value as String;
                  });
                },
                title: Text(
                  'Tiếng Việt',
                  style: TextStyle(fontSize: 14 * pix),
                ),
                dense: true,
                activeColor: AppColors.primary,
              ),
              RadioListTile(
                value: 'english',
                groupValue: selectedOption2,
                onChanged: (value) {
                  setState(() {
                    selectedOption2 = value as String;
                  });
                },
                title: Text(
                  'English',
                  style: TextStyle(fontSize: 14 * pix),
                ),
                dense: true,
                activeColor: AppColors.primary,
              ),
            ],
          ),
        ),
        _buildTitle('Dữ liệu (Autoplay video)'),
        Container(
          height: 170 * pix,
          width: size.width,
          color: Colors.white,
          padding: EdgeInsets.all(10 * pix),
          child: Column(
            children: <Widget>[
              RadioListTile(
                value: 'wifi&3g',
                groupValue: selectedOption3,
                onChanged: (value) {
                  setState(() {
                    selectedOption3 = value as String;
                  });
                },
                title: Text(
                  'Wifi và dữ liệu di động',
                  style: TextStyle(fontSize: 14 * pix),
                ),
                dense: true,
                activeColor: AppColors.primary,
              ),
              RadioListTile(
                value: 'wifi',
                groupValue: selectedOption3,
                onChanged: (value) {
                  setState(() {
                    selectedOption3 = value as String;
                  });
                },
                title: Text(
                  'Chỉ Wifi',
                  style: TextStyle(fontSize: 14 * pix),
                ),
                dense: true,
                activeColor: AppColors.primary,
              ),
              RadioListTile(
                value: '3g',
                groupValue: selectedOption3,
                onChanged: (value) {
                  setState(() {
                    selectedOption3 = value as String;
                  });
                },
                title: Text(
                  'Chỉ dữ liệu di động',
                  style: TextStyle(fontSize: 14 * pix),
                ),
                dense: true,
                activeColor: AppColors.primary,
              ),
            ],
          ),
        ),
        _buildTitle("Cài đặt tính năng"),
        _buildToggleItem(
            "Tham gia sự kiện hỏi và đáp",
            "Tắt tùy chọn này sẽ bỏ nội dung liên quan đến Sự kiện Hỏi & Đáp...",
            isEventEnabled, (value) {
          setState(() {
            isEventEnabled = value;
          });
        }),
        _buildToggleItem(
            "Hiển thị tôi trong phần Top tuyển chọn",
            "Bật mục này sẽ cho phép thành viên khác...",
            isTopPickEnabled, (value) {
          setState(() {
            isTopPickEnabled = value;
          });
        }),
        _buildToggleItem(
            "Nhận tin nhắn trực tiếp",
            "Tắt mục này sẽ ngăn không để bất kỳ thành viên nào...",
            isDirectMsgEnabled, (value) {
          setState(() {
            isDirectMsgEnabled = value;
          });
        }),
        _buildToggleItem(
            "Tham gia Khung giờ vàng",
            "Tắt tính năng này sẽ ẩn không cho thành viên khác thấy bạn...",
            isGoldenHourEnabled, (value) {
          setState(() {
            isGoldenHourEnabled = value;
          });
        }),
        _buildToggleItem(
            "Hiển thị trạng thái hoạt động",
            "Trạng thái đang hoạt động hiển thị trên hồ sơ của bạn...",
            isActiveStatusEnabled, (value) {
          setState(() {
            isActiveStatusEnabled = value;
          });
        }),
        _buildToggleItem(
            "Hiển thị trạng thái hoạt động gần đây",
            "Trạng thái hoạt động gần đây hiển thị trên hồ sơ của bạn...",
            isRecentActivityEnabled, (value) {
          setState(() {
            isRecentActivityEnabled = value;
          });
        }),
        _buildTitle("Cài đặt thông báo"),
        _buildListTile("Email"),
        _buildListTile("Thông báo đẩy"),
        _buildListTile("Đội ngũ Teklove"),
        _buildTitle("Tài khoản thanh toán"),
        _buildListTile("Quản lý tài khoản thanh toán"),
        _buildListTile("Quản lý tài khoản Google Play"),
        _buildListTile("Khôi phục giao dịch mua hàng"),
        _buildTitle("Cộng đồng"),
        _buildListTile("Trợ giúp và hỗ trợ"),
        _buildListTile("Quy tắc cộng đồng"),
        _buildListTile("Trung tâm an toàn"),
        _buildTitle("Quyền riêng tư"),
        _buildListTile("Chính sách Cookie"),
        _buildListTile("Chính sách Quyền riêng tư"),
        _buildListTile("Tùy chọn Quyền riêng tư"),
        Container(
          height: 88 * pix,
          width: size.width,
          color: Colors.white,
          padding: EdgeInsets.all(16 * pix),
          child: InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Đăng xuất'),
                      content: Text('Bạn có chắc chắn muốn đăng xuất không?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Hủy'),
                        ),
                        TextButton(
                          onPressed: () {
                            final authprovider = Provider.of<AuthProvider>(
                                context,
                                listen: false);
                            authprovider.logout();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ),
                            );
                          },
                          child: Text('Đồng ý'),
                        ),
                      ],
                    );
                  });
            },
            child: Container(
              height: 56 * pix,
              padding: EdgeInsets.only(top: 16 * pix),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.grey[200],
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(0, 1), // changes position of shadow
                  ),
                ],
              ),
              child: Text(
                'Đăng xuất',
                style: TextStyle(
                  fontSize: 16 * pix,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 0, 0, 0),
                  fontFamily: 'BeVietnamPro',
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildListTile(String title) {
    final size = MediaQuery.of(context).size;
    final pix = size.width / 393;
    return Container(
      color: Colors.white,
      child: ListTile(
        title: Text(title, style: TextStyle(fontSize: 14 * pix)),
        trailing:
            Icon(Icons.arrow_forward_ios, size: 16 * pix, color: Colors.grey),
        onTap: () {},
      ),
    );
  }

  Widget _buildTitle(String title) {
    final size = MediaQuery.of(context).size;
    final pix = size.width / 393;
    return Container(
      height: 50 * pix,
      width: size.width,
      color: Colors.grey[200],
      padding: EdgeInsets.only(left: 16 * pix, top: 14 * pix),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14 * pix,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontFamily: 'BeVietnamPro',
        ),
        textAlign: TextAlign.left,
      ),
    );
  }

  Widget _buildToggleItem(
      String title, String description, bool value, Function(bool) onChanged) {
    final size = MediaQuery.of(context).size;
    final pix = size.width / 393;
    return Container(
      color: Colors.white,
      child: SwitchListTile(
        title: Text(
          title,
          style: TextStyle(
            fontSize: 14 * pix,
            fontWeight: FontWeight.bold,
            color: value ? AppColors.primary : Colors.black, // Đổi màu khi bật
          ),
        ),
        subtitle: Text(description,
            style: TextStyle(fontSize: 14 * pix, color: Colors.grey)),
        value: value,
        onChanged: onChanged,
        activeColor: AppColors.primary, // Màu khi bật
      ),
    );
  }
}
