import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiklove_fe/provider/AuthProvider.dart';
import 'package:tiklove_fe/provider/LoadingProvider.dart';
import 'package:tiklove_fe/provider/ProfileProvider.dart';
import 'package:tiklove_fe/start/register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void handleLogin(BuildContext context) async {
    try {
      await Provider.of<AuthProvider>(context, listen: false)
          .login(_phoneController.text, _passwordController.text, context);
      final account = Provider.of<AuthProvider>(context, listen: false).account;

      if (account == null) {
        throw Exception('Invalid role or user data');
      } else {
        try {
          await Provider.of<ProfileProvider>(context, listen: false)
              .setProfile(account.id, context);
        } catch (error) {
          print('Error when get profile: $error');
        }
      }
    } catch (error) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Login Error'),
          content: Text(error.toString()),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final loading = Provider.of<LoadingProvider>(context).isLoading;
    final size = MediaQuery.of(context).size;
    final pix = size.width / 393;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFFF295F),
                  Color(0xFFFF9954),
                ],
              ),
            ),
          ),
          Positioned(
            top: 80 * pix,
            left: 79 * pix,
            child: Container(
              height: 53 * pix,
              width: 235 * pix,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/Teklove/teklove1.png'),
                ),
              ),
            ),
          ),
          loading
              ? Center(child: CircularProgressIndicator())
              : Positioned(
                  top: 175 * pix,
                  left: 8 * pix,
                  right: 8 * pix,
                  bottom: 15 * pix,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            height: 220 * pix,
                            width: double.maxFinite,
                            margin: EdgeInsets.all(18),
                            child: Column(
                              children: [
                                Container(
                                  height: 42 * pix,
                                  width: double.maxFinite,
                                  child: Text(
                                    'Đăng nhập bằng SĐT',
                                    style: TextStyle(
                                      fontSize: 24 * pix,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'BeVietnamPro',
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                SizedBox(
                                  height: 15 * pix,
                                ),
                                Container(
                                  height: 46 * pix,
                                  width: double.maxFinite,
                                  padding: EdgeInsets.all(10 * pix),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(width: 12),
                                      DropdownButton<String>(
                                        value: 'VN +84',
                                        underline: SizedBox(),
                                        icon: Icon(Icons.expand_more,
                                            color: Colors.grey),
                                        items: [
                                          DropdownMenuItem(
                                            value: 'VN +84',
                                            child: Text('VN +84'),
                                          ),
                                          DropdownMenuItem(
                                            value: 'US +1',
                                            child: Text('US +1'),
                                          ),
                                        ],
                                        onChanged: (value) {},
                                      ),
                                      VerticalDivider(
                                        color: Colors.grey,
                                        thickness: 1,
                                        indent: 12,
                                        endIndent: 12,
                                      ),
                                      Expanded(
                                        child: TextField(
                                          keyboardType: TextInputType.phone,
                                          controller: _phoneController,
                                          decoration: InputDecoration(
                                            hintText: 'Nhập SĐT của bạn',
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 15),
                                Container(
                                  height: 46 * pix,
                                  width: double.maxFinite,
                                  padding: EdgeInsets.all(10 * pix),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: TextField(
                                    obscureText: _obscurePassword,
                                    controller: _passwordController,
                                    decoration: InputDecoration(
                                      hintText: 'Nhập mật khẩu',
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none,
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          _obscurePassword
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          color: Colors.grey,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _obscurePassword =
                                                !_obscurePassword;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Chúc bạn sẽ tìm được một nửa của cuộc đời mình',
                                      style: TextStyle(
                                        fontSize: 12 * pix,
                                        color: const Color.fromARGB(
                                            255, 90, 90, 90),
                                      ),
                                    ),
                                    Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 120 * pix,
                          ),
                          Container(
                            height: 210 * pix,
                            width: double.maxFinite,
                            margin: EdgeInsets.all(16 * pix),
                            child: Center(
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      handleLogin(context);
                                    },
                                    borderRadius: BorderRadius.circular(30),
                                    child: Container(
                                      height: 56 * pix,
                                      width: double.maxFinite,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFFF295F),
                                        borderRadius: BorderRadius.circular(30),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color.fromARGB(
                                                255, 250, 37, 90),
                                            offset: Offset(0, 2),
                                            spreadRadius: 1.5,
                                            blurRadius: 6, // Độ mờ của bóng
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Đăng nhập',
                                          style: TextStyle(
                                            color: Colors.white, // Màu chữ
                                            fontSize: 18 * pix,
                                            fontFamily: 'BeVietnamPro',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 15 * pix),
                                  Container(
                                    height: 20 * pix,
                                    width: double.maxFinite,
                                    padding: EdgeInsets.only(
                                        left: 60 * pix, right: 10 * pix),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Bạn chưa có tài khoản? ',
                                          style: TextStyle(
                                            fontSize: 14 * pix,
                                            color: const Color.fromARGB(
                                                255, 90, 90, 90),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    RegisterPage(),
                                              ),
                                            );
                                          },
                                          child: Text(
                                            'Đăng ký',
                                            style: TextStyle(
                                              fontSize: 14 * pix,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 12 * pix), // Khoảng cách
                                  Expanded(
                                    child: Container(
                                      height: 72 * pix,
                                      child: RichText(
                                        textAlign: TextAlign.left,
                                        text: TextSpan(
                                          style: TextStyle(
                                            fontSize: 14 * pix,
                                            color:
                                                Color.fromARGB(255, 90, 90, 90),
                                            height: 1.5, // Khoảng cách dòng
                                          ),
                                          children: [
                                            TextSpan(
                                              text:
                                                  'Khi nhấn Đăng nhập, bạn đồng ý với ',
                                            ),
                                            TextSpan(
                                              text: 'Điều khoản',
                                              style: TextStyle(
                                                color: Colors.pinkAccent,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  // Xử lý khi nhấn vào "Điều khoản"
                                                  print("Điều khoản được nhấn");
                                                },
                                            ),
                                            TextSpan(
                                              text:
                                                  ' của chúng tôi. Tìm hiểu về cách chúng tôi xử lý dữ liệu của bạn trong ',
                                            ),
                                            TextSpan(
                                              text: 'Chính sách quyền riêng tư',
                                              style: TextStyle(
                                                color: Colors.pinkAccent,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  // Xử lý khi nhấn vào "Chính sách quyền riêng tư"
                                                  print(
                                                      "Chính sách quyền riêng tư được nhấn");
                                                },
                                            ),
                                            TextSpan(
                                              text: ' và ',
                                            ),
                                            TextSpan(
                                              text: 'Chính sách Cookie',
                                              style: TextStyle(
                                                color: Colors.pinkAccent,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  // Xử lý khi nhấn vào "Chính sách Cookie"
                                                  print(
                                                      "Chính sách Cookie được nhấn");
                                                },
                                            ),
                                            TextSpan(
                                              text: '.',
                                            ),
                                          ],
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
