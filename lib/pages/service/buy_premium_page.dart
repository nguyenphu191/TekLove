import 'package:flutter/material.dart';
import 'package:tiklove_fe/res/images/app_images.dart';
import 'package:tiklove_fe/widgets/option_widget.dart';

class BuyPremiumPage extends StatefulWidget {
  const BuyPremiumPage({super.key});

  @override
  State<BuyPremiumPage> createState() => _BuyPremiumPageState();
}

class _BuyPremiumPageState extends State<BuyPremiumPage> {
  int selectedOption = 0;
  double price = 0;
  int sl = 0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pix = size.width / 393;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 100 * pix,
              padding: EdgeInsets.symmetric(horizontal: 20 * pix),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(width: 20 * pix),
                  Text(
                    'Premium',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      fontSize: 24 * pix,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 100 * pix,
            left: 0,
            right: 0,
            bottom: 0,
            child: SingleChildScrollView(
                child: Padding(
              padding: EdgeInsets.all(16 * pix),
              child: Column(
                children: [
                  Container(
                    height: 56 * pix,
                    width: size.width - 32 * pix,
                    child: Text(
                      'Nâng cấp mọi hoạt động của bạn trên Teklove với Premium',
                      style: TextStyle(
                        fontSize: 20 * pix,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 20 * pix),
                  Container(
                      height: 154 * pix,
                      width: size.width - 32 * pix,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OptionWidget(
                            icon: AppImages.iconCrownPremium,
                            quantity: 7,
                            price: 56000,
                            unit: 'tuần',
                            isSelected: selectedOption == 1,
                            color: Color(0xffFFC107),
                            onTap: () {
                              setState(() {
                                selectedOption = 1;
                                price = 56000;
                                sl = (7 / 7).toInt();
                              });
                            },
                            oldPrice: 56000,
                            type: 'premium',
                          ),
                          OptionWidget(
                            icon: AppImages.iconCrownPremium,
                            quantity: 30,
                            price: 28000,
                            unit: 'tuần',
                            isSelected: selectedOption == 2,
                            color: Color(0xffFFC107),
                            onTap: () {
                              setState(() {
                                selectedOption = 2;
                                price = 28000;
                                sl = (30 / 7).toInt();
                              });
                            },
                            oldPrice: 56000,
                            type: 'premium',
                          ),
                          OptionWidget(
                            icon: AppImages.iconCrownPremium,
                            quantity: 120,
                            price: 13000,
                            unit: 'tuần',
                            isSelected: selectedOption == 3,
                            color: Color(0xffFFC107),
                            onTap: () {
                              setState(() {
                                selectedOption = 3;
                                price = 13000;
                                sl = (120 / 7).toInt();
                              });
                            },
                            oldPrice: 56000,
                            type: 'premium',
                          ),
                        ],
                      )),
                  Container(
                    height: 216 * pix,
                    width: size.width - 32 * pix,
                    margin: EdgeInsets.only(top: 36 * pix),
                    padding: EdgeInsets.all(16 * pix),
                    decoration: BoxDecoration(
                      color: Color(0xffFFC107).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Color(0xffFFC107),
                        width: 1 * pix,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildInfor('Thích không giới hạn'),
                        _buildInfor("Xem ai thích bạn"),
                        _buildInfor('Quay lại không giới hạn'),
                        _buildInfor('Ẩn quảng cáo'),
                        _buildInfor('Quản lý hồ sơ của bạn'),
                      ],
                    ),
                  ),
                ],
              ),
            )),
          ),
          Positioned(
            bottom: 16 * pix,
            left: 16 * pix,
            right: 16 * pix,
            child: Container(
              height: 56 * pix,
              width: size.width - 32 * pix,
              padding: EdgeInsets.all(14 * pix),
              decoration: BoxDecoration(
                color: Color(0xffFFC107),
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xffFFC107).withOpacity(0.3),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  'Tiếp tục - Tổng cộng: ${(price * sl).toInt()}đ',
                  style: TextStyle(
                    fontSize: 18 * pix,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfor(String title) {
    final size = MediaQuery.of(context).size;
    final pix = size.width / 393;
    return Row(
      children: [
        Image.asset(
          AppImages.iconCheckCircle,
          fit: BoxFit.contain,
          height: 24 * pix,
          width: 24 * pix,
        ),
        SizedBox(width: 5 * pix),
        Text(
          title,
          style: TextStyle(
            fontSize: 14 * pix,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
