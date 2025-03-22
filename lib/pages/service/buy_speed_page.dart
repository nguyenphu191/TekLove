import 'package:flutter/material.dart';
import 'package:tiklove_fe/pages/service/buy_premium_page.dart';
import 'package:tiklove_fe/res/images/app_images.dart';
import 'package:tiklove_fe/widgets/option_widget.dart';

class BuySpeedPage extends StatefulWidget {
  const BuySpeedPage({super.key});

  @override
  State<BuySpeedPage> createState() => _BuySpeedPageState();
}

class _BuySpeedPageState extends State<BuySpeedPage> {
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
                    'Mua lượt Tăng tốc',
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
                    height: 122 * pix,
                    margin: EdgeInsets.only(bottom: 20 * pix, top: 20 * pix),
                    width: size.width - 32 * pix,
                    child: Image.asset(
                      AppImages.buyspeed,
                      height: 100 * pix,
                      width: 361 * pix,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    height: 56 * pix,
                    width: size.width - 32 * pix,
                    child: Text(
                      'Đẩy hồ sơ của bạn lên top đầu khu vực trong 30 phút.',
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
                            icon: AppImages.iconAccelerate,
                            quantity: 7,
                            price: 5000,
                            unit: 'lượt',
                            isSelected: selectedOption == 1,
                            color: Color(0xffFF6229),
                            onTap: () {
                              setState(() {
                                selectedOption = 1;
                                price = 5000;
                                sl = 7;
                              });
                            },
                            oldPrice: 5000,
                            type: 'speed',
                          ),
                          OptionWidget(
                            icon: AppImages.iconAccelerate,
                            quantity: 14,
                            price: 4000,
                            unit: 'lượt',
                            isSelected: selectedOption == 2,
                            color: Color(0xffFF6229),
                            onTap: () {
                              setState(() {
                                selectedOption = 2;
                                price = 4000;
                                sl = 14;
                              });
                            },
                            oldPrice: 5000,
                            type: 'speed',
                          ),
                          OptionWidget(
                            icon: AppImages.iconAccelerate,
                            quantity: 21,
                            price: 3000,
                            unit: 'lượt',
                            isSelected: selectedOption == 3,
                            color: Color(0xffFF6229),
                            onTap: () {
                              setState(() {
                                selectedOption = 3;
                                price = 3000;
                                sl = 21;
                              });
                            },
                            oldPrice: 5000,
                            type: 'speed',
                          ),
                        ],
                      )),
                  SizedBox(height: 32 * pix),
                  Center(
                    child: Text(
                      'Hoặc',
                      style: TextStyle(
                        fontSize: 14 * pix,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                        fontFamily: 'BeVietnamPro',
                      ),
                    ),
                  ),
                  SizedBox(height: 32 * pix),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BuyPremiumPage()));
                    },
                    child: Container(
                      height: 68 * pix,
                      width: size.width - 32 * pix,
                      padding: EdgeInsets.all(14 * pix),
                      decoration: BoxDecoration(
                        color: Color(0xffFFC107).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Color(0xffFFC107),
                          width: 0.5 * pix,
                        ),
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            AppImages.iconCrownPremium,
                            fit: BoxFit.contain,
                            height: 32 * pix,
                            width: 32 * pix,
                          ),
                          SizedBox(
                            width: 10 * pix,
                          ),
                          Column(
                            children: [
                              Container(
                                width: 200 * pix,
                                child: Text('Gói Premium',
                                    style: TextStyle(
                                      fontSize: 14 * pix,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.left),
                              ),
                              SizedBox(
                                height: 2 * pix,
                              ),
                              Container(
                                width: 200 * pix,
                                child: Text(
                                  '5 lượt Siêu thích miễn phí mỗi tuần',
                                  style: TextStyle(
                                    fontSize: 10 * pix,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey,
                                    fontFamily: 'BeVietnamPro',
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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
                color: Color(0xffFF6229),
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xffFF6229).withOpacity(0.3),
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
}
