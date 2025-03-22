import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:tiklove_fe/provider/AuthProvider.dart';
import 'package:tiklove_fe/start/login.dart';
import 'package:tiklove_fe/start/start1_name.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _noRegistered = true;
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  void handleRegister(BuildContext context) async {
    await Provider.of<AuthProvider>(context, listen: false)
        .register(_phoneController.text, _passwordController.text, context);
  }

  bool checkPhone(String phone) {
    if (phone.length != 10) {
      return false;
    } else if (phone[0] != '0') {
      return false;
    } else if (phone[1] != '3' &&
        phone[1] != '5' &&
        phone[1] != '7' &&
        phone[1] != '8' &&
        phone[1] != '9') {
      return false;
    }

    return true;
  }

  bool checkPassword(String password) {
    if (password.length < 6) {
      return false;
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 60,
    textStyle: TextStyle(
      fontSize: 25,
      color: Colors.black,
      fontWeight: FontWeight.w600,
    ),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(color: Colors.grey),
      ),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
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
            top: 82,
            left: 79,
            child: Container(
              height: 53,
              width: 235,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/Teklove/teklove1.png'),
                ),
              ),
            ),
          ),
          Positioned(
            top: 175,
            left: 8,
            right: 8,
            bottom: 15,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: SingleChildScrollView(
                child: _noRegistered == true
                    ? Column(
                        children: [
                          Container(
                            height: 210,
                            width: double.maxFinite,
                            margin: EdgeInsets.all(18),
                            child: Column(
                              children: [
                                Container(
                                  height: 32,
                                  width: double.maxFinite,
                                  child: Text(
                                    'Đăng ký bằng SĐT',
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'BeVietnamPro',
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  height: 46,
                                  width: double.maxFinite,
                                  padding: EdgeInsets.all(10),
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
                                          controller: _phoneController,
                                          keyboardType: TextInputType.phone,
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
                                  height: 46,
                                  width: double.maxFinite,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: TextField(
                                    obscureText: true,
                                    controller: _passwordController,
                                    decoration: InputDecoration(
                                      hintText: 'Nhập mật khẩu',
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                Text(
                                  'Chúng tôi sẽ nhắn tin cho bạn một mã code để xác thực đó đúng là bạn.',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color:
                                        const Color.fromARGB(255, 90, 90, 90),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 200,
                          ),
                          Container(
                            height: 195,
                            width: double.maxFinite,
                            margin: EdgeInsets.all(18),
                            child: Center(
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      if (!checkPhone(_phoneController.text)) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Số điện thoại không hợp lệ',
                                            ),
                                          ),
                                        );
                                        return;
                                      }
                                      if (!checkPassword(
                                          _passwordController.text)) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Mật khẩu phải có ít nhất 6 ký tự',
                                            ),
                                          ),
                                        );
                                        return;
                                      }
                                      handleRegister(context);
                                    },
                                    borderRadius: BorderRadius.circular(30),
                                    child: Container(
                                      height: 56,
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
                                          'Đăng ký',
                                          style: TextStyle(
                                            color: Colors.white, // Màu chữ
                                            fontSize: 18,
                                            fontFamily: 'BeVietnamPro',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  Container(
                                    height: 20,
                                    width: double.maxFinite,
                                    padding:
                                        EdgeInsets.only(left: 50, right: 10),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Bạn đã có tài khoản? ',
                                          style: TextStyle(
                                            fontSize: 14,
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
                                                    LoginPage(),
                                              ),
                                            );
                                          },
                                          child: Text(
                                            'Đăng nhập',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 12), // Khoảng cách
                                  Expanded(
                                    child: Container(
                                      height: 72,
                                      child: RichText(
                                        textAlign: TextAlign.left,
                                        text: TextSpan(
                                          style: TextStyle(
                                            fontSize: 14,
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
                      )
                    : Column(children: [
                        Container(
                          height: 180,
                          width: double.maxFinite,
                          margin: EdgeInsets.all(18),
                          child: Column(
                            children: [
                              Container(
                                height: 32,
                                width: double.maxFinite,
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          _noRegistered = true;
                                        });
                                      },
                                      child: Icon(
                                        Icons.arrow_back,
                                        size: 29,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      'Nhập mã của bạn',
                                      style: TextStyle(
                                        fontSize: 24,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'BeVietnamPro',
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                height: 60,
                                width: double.maxFinite,
                                child: Pinput(
                                  length: 6,
                                  defaultPinTheme: defaultPinTheme,
                                  focusedPinTheme: defaultPinTheme.copyWith(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.red),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  submittedPinTheme: defaultPinTheme.copyWith(
                                    decoration:
                                        defaultPinTheme.decoration!.copyWith(
                                      color: Colors.grey.shade200,
                                    ),
                                  ),
                                  onCompleted: (pin) => print("OTP: $pin"),
                                ),
                              ),
                              SizedBox(height: 18),
                              Container(
                                width: double.maxFinite,
                                child: Text(
                                  "0968139551",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              SizedBox(height: 5),
                              Container(
                                width: double.maxFinite,
                                child: Row(
                                  children: [
                                    Text(
                                      "Bạn không nhận được mã xác thực? ",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 14),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        // Xử lý khi nhấn vào "Gửi lại"
                                      },
                                      child: Text(
                                        'Gửi lại',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: const Color.fromARGB(
                                              255, 255, 0, 0),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 340,
                        ),
                        Container(
                          height: 60,
                          width: double.maxFinite,
                          margin: EdgeInsets.all(18),
                          child: Center(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Start1Page(),
                                  ),
                                );
                              },
                              borderRadius: BorderRadius.circular(30),
                              child: Container(
                                height: 56,
                                width: double.maxFinite,
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
                                      fontSize: 18,
                                      fontFamily: 'BeVietnamPro',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
