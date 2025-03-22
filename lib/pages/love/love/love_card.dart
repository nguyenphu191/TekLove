import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:tiklove_fe/pages/love/love/love_setting_page.dart';
import 'package:tiklove_fe/pages/love/love/love_widget/heart_date.dart';
import 'package:tiklove_fe/pages/love/love/post_page.dart';
import 'package:tiklove_fe/pages/love/love/reward_page.dart';
import 'package:tiklove_fe/pages/message/chat_page.dart';
import 'package:tiklove_fe/res/images/app_images.dart';
import 'package:tiklove_fe/theme/app_colors.dart';

class LoveCard extends StatefulWidget {
  const LoveCard({super.key});

  @override
  State<LoveCard> createState() => _LoveCardState();
}

class _LoveCardState extends State<LoveCard> {
  int currentImage = 0;

  void previousImage() {
    if (currentImage > 0) {
      setState(() {
        currentImage--;
      });
    }
  }

  void nextImage() {
    if (currentImage < images.length - 1) {
      setState(() {
        currentImage++;
      });
    }
  }

  PageController pageController = PageController(viewportFraction: 1);
  Map<String, dynamic> love = {
    'user1': 'Krixi',
    'user2': 'John',
    'time': '15/06/2020',
  };
  List<String> images = [
    "https://static.wikia.nocookie.net/disney/images/3/36/Profile_-_Scarlet_Witch.png/revision/latest/scale-to-width-down/1000?cb=20220629124711",
    "https://popcollectibles.store/cdn/shop/files/image_01b0bfcf-b384-4678-be09-7489cd99a759_1024x1024.jpg",
    "https://i.pinimg.com/736x/0f/f9/cd/0ff9cd060aa05e23bb786577e501adbc.jpg",
    "https://static.wikia.nocookie.net/ultimate-marvel-cinematic-universe/images/5/50/Thor_%28Jane_Foster%29.jpg/revision/latest?cb=20190427024326"
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pix = size.width / 393;
    return Container(
        height: size.height * 0.73,
        width: size.width,
        margin: EdgeInsets.only(top: 10 * pix, left: 10 * pix, right: 10 * pix),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color(0xFF2E3236),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(24),
              ),
              child: Container(
                height: size.height * 0.63 - 1 * pix,
                width: size.width,
                child: Stack(
                  children: [
                    images.length > 0
                        ? Image.network(
                            images[currentImage],
                            height: double.infinity,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            (loadingProgress
                                                    .expectedTotalBytes ??
                                                1)
                                        : null,
                                  ),
                                );
                              }
                            },
                            errorBuilder: (BuildContext context, Object error,
                                StackTrace? stackTrace) {
                              return Container(
                                width: double.infinity,
                                height: double.infinity,
                                color: Colors.grey,
                                child: const Center(
                                  child: Icon(Icons.error, color: Colors.white),
                                ),
                              );
                            },
                          )
                        : Image.asset(
                            AppImages.userUnknown,
                            width: double.infinity,
                            fit: BoxFit.fitWidth,
                          ),
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0x00212529),
                            Color(0xFF2E3236),
                          ],
                          stops: [0.5754, 1.0],
                        )),
                      ),
                    ),
                    Positioned(
                      top: size.height * 0.25,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 159 * pix,
                        width: size.width,
                        padding:
                            EdgeInsets.only(left: 50 * pix, right: 50 * pix),
                        child: HeartDate(daysTogether: '365'),
                      ),
                    ),
                    Positioned(
                      top: size.height * 0.28 + 150 * pix,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 100 * pix,
                        width: size.width,
                        child: Container(
                          height: 100 * pix,
                          width: size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 100 * pix,
                                width: 150 * pix,
                                child: Column(
                                  children: [
                                    Container(
                                        height: 75 * pix,
                                        width: 75 * pix,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 2,
                                          ),
                                          image: DecorationImage(
                                            image: NetworkImage(images[0]),
                                            fit: BoxFit.cover,
                                          ),
                                        )),
                                    SizedBox(
                                      height: 3 * pix,
                                    ),
                                    Text(
                                      love['user1'],
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12 * pix,
                                        fontFamily: 'BeVietnamPro',
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 46 * pix,
                                width: 46 * pix,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Image.asset(
                                  AppImages.iconHeartCircle,
                                  width: 46 * pix,
                                  height: 46 * pix,
                                ),
                              ),
                              Container(
                                height: 100 * pix,
                                width: 150 * pix,
                                child: Column(
                                  children: [
                                    Container(
                                        height: 75 * pix,
                                        width: 75 * pix,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 2,
                                          ),
                                          image: DecorationImage(
                                            image: NetworkImage(images[1]),
                                            fit: BoxFit.cover,
                                          ),
                                        )),
                                    SizedBox(
                                      height: 3 * pix,
                                    ),
                                    Text(
                                      love['user2'],
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12 * pix,
                                        fontFamily: 'BeVietnamPro',
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        width: size.width,
                        margin: EdgeInsets.only(
                            bottom: 5 * pix, left: 50 * pix, right: 50 * pix),
                        child: images.length > 1
                            ? Row(
                                children: List.generate(
                                    images.length,
                                    (index) => Expanded(
                                          child: Container(
                                            height: 8 * pix,
                                            margin: EdgeInsets.only(
                                                right:
                                                    index == images.length - 1
                                                        ? 0
                                                        : 2),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                border: Border.all(
                                                    width: 1,
                                                    color: currentImage == index
                                                        ? AppColors.primary
                                                        : const Color(
                                                                0xffFFFFFF)
                                                            .withOpacity(0.3)),
                                                color: currentImage == index
                                                    ? AppColors.primary
                                                    : const Color(0xffFFFFFF)
                                                        .withOpacity(0.2)),
                                          ),
                                        )),
                              )
                            : const SizedBox.shrink(),
                      ),
                    ),
                    Positioned(
                      top: 10 * pix,
                      left: 0,
                      right: 0,
                      child: Container(
                          height: 36 * pix,
                          width: size.width,
                          padding:
                              EdgeInsets.only(left: 20 * pix, right: 20 * pix),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 36 * pix,
                                width: 36 * pix,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18 * pix),
                                  color: Colors.grey[600]!.withOpacity(0.5),
                                ),
                                child: Center(
                                  child: Image.asset(
                                    AppImages.icongalleryouotline,
                                    height: 20 * pix,
                                    width: 20 * pix,
                                  ),
                                ),
                              ),
                              Container(
                                height: 28 * pix,
                                width: 156 * pix,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.grey[600]!.withOpacity(0.5),
                                ),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        AppImages.rectangle_333,
                                        height: 24 * pix,
                                        width: 24 * pix,
                                      ),
                                      SizedBox(
                                        width: 10 * pix,
                                      ),
                                      Text(
                                        love['time'],
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14 * pix,
                                          fontFamily: 'BeVietnamPro',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: 36 * pix,
                                width: 36 * pix,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18 * pix),
                                  color: Colors.grey[600]!.withOpacity(0.5),
                                ),
                                child: Center(
                                  child: Image.asset(
                                    AppImages.iconloveroom,
                                    height: 20 * pix,
                                    width: 20 * pix,
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),
                    Positioned.fill(
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: previousImage,
                              child: Container(
                                  color:
                                      const Color.fromARGB(0, 255, 255, 255)),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: nextImage,
                              child: Container(color: Colors.transparent),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 1 * pix,
              color: const Color(0xffFFFFFF).withOpacity(0.1),
            ),
            Container(
              height: size.height * 0.1,
              width: size.width,
              padding: EdgeInsets.only(left: 20 * pix, right: 20 * pix),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buttonSwipe(
                      horizontalRatio: pix,
                      icon: AppImages.iconsetting,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoveSettingsPage(),
                            ));
                      },
                      isSmaller: true),
                  buttonSwipe(
                      horizontalRatio: pix,
                      icon: AppImages.iconlovemessage,
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => ChatPage(
                        //         candidateId: '1',
                        //       ),
                        //     ));
                      },
                      isSmaller: false),
                  buttonSwipe(
                      horizontalRatio: pix,
                      icon: AppImages.icongift,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RewardPage(),
                            ));
                      },
                      isSmaller: true),
                  buttonSwipe(
                      horizontalRatio: pix,
                      icon: AppImages.icongallery,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PostPage(),
                            ));
                      },
                      isSmaller: false),
                  buttonSwipe(
                      horizontalRatio: pix,
                      icon: AppImages.iconloveshare,
                      onTap: () {},
                      isSmaller: true),
                ],
              ),
            ),
          ],
        ));
  }

  Widget buttonSwipe({
    required double horizontalRatio,
    required String icon,
    Function()? onTap,
    required bool isSmaller,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        constraints: BoxConstraints(
            maxWidth: (isSmaller ? 48 : 64) * horizontalRatio,
            maxHeight: (isSmaller ? 48 : 64) * horizontalRatio),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xffFFFFFF).withOpacity(0.1),
        ),
        alignment: Alignment.center,
        child: Image.asset(
          icon,
          width: (isSmaller ? 24 : 32) * horizontalRatio,
          height: (isSmaller ? 24 : 32) * horizontalRatio,
        ),
      ),
    );
  }
}
