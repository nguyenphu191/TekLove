import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiklove_fe/pages/discovery/discovery_swiper.dart';
import 'package:tiklove_fe/provider/ProfileProvider.dart';

import 'package:tiklove_fe/res/images/app_images.dart';
import 'package:tiklove_fe/theme/app_colors.dart';
import 'package:tiklove_fe/widgets/bottom_bar.dart';
import 'package:tiklove_fe/widgets/discovery_card.dart';

import '../../../../res/fonts/app_fonts.dart';

class DiscoveryPage extends StatefulWidget {
  const DiscoveryPage({super.key});

  @override
  State<DiscoveryPage> createState() => _DiscoveryPageState();
}

class _DiscoveryPageState extends State<DiscoveryPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var width = size.width;
    final pix = size.width / 393;
    final profile = Provider.of<ProfileProvider>(context).profile;
    return Scaffold(
      backgroundColor: AppColors.backgroundDetail,
      body: SafeArea(
        child: Stack(
          children: [
            profile!.isLove
                ? Container(
                    height: size.height,
                    width: size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(AppImages.isLove),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: width - 16 * pix,
                          height: (width - 16) * ((216 + 93) / 377 * pix),
                          child: Stack(
                            children: [
                              Positioned(
                                top: 10,
                                left: 0,
                                right: 0,
                                child: Container(
                                  width: width - 16,
                                  height: (width - 16) * (216 / 377),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: const Color(0xff2E3236)),
                                  padding: EdgeInsets.all(16 * pix),
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                    width: width - 32 * pix,
                                    child: Text("Thẻ khám phá",
                                        style: AppFonts.be600(
                                            18 * pix, AppColors.background)),
                                  ),
                                ),
                              ),
                              Positioned(
                                  left: 0,
                                  right: 0,
                                  bottom: 0,
                                  child: Center(
                                      child: Stack(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DiscoverySwiperPage(
                                                          type: "Love")));
                                        },
                                        child: Container(
                                          width: width - 32,
                                          height: 258 * pix,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            gradient: const RadialGradient(
                                              center: Alignment(-0.5, -0.34),
                                              radius: 1.0,
                                              colors: [
                                                Color(0xFFFFD1DD),
                                                Color(0xFFFF295F),
                                              ],
                                              stops: [0.0, 1.0],
                                            ),
                                            border: Border.all(
                                              color: const Color(0xffFFFFFF)
                                                  .withOpacity(0.4),
                                              width: 1.0,
                                            ),
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Color(0x03FF295F),
                                                offset: Offset(0, 0.64),
                                                blurRadius: 1.4,
                                              ),
                                              BoxShadow(
                                                color: Color(0x09FF295F),
                                                offset: Offset(0, 1.93),
                                                blurRadius: 4.25,
                                              ),
                                            ],
                                          ),
                                          padding: EdgeInsets.all(24 * pix),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Image.asset(
                                                  AppImages.discoverylove,
                                                  width: 148 * pix,
                                                  height: 148 * pix,
                                                  fit: BoxFit.cover),
                                              Expanded(
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Tìm kiếm người yêu",
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize: 22 * pix,
                                                        fontFamily: AppFonts
                                                            .beVietNamPro,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: AppColors
                                                            .background),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                          top: -1,
                                          left: 0,
                                          child: Image.asset(
                                            AppImages.lightFlashEffectWhiteLens,
                                            width: (width - 32 * pix) / 2,
                                          ))
                                    ],
                                  )))
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 24 * pix,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Hẹn hò chung mục đích",
                                  style: AppFonts.be600(
                                      16 * pix, AppColors.textPrimary)),
                              SizedBox(
                                height: 16 * pix,
                              ),
                              Wrap(
                                spacing: 8 * pix,
                                runSpacing: 8 * pix,
                                children: [
                                  DiscoveryCard(
                                    width: (width - 40 * pix) / 2,
                                    gradient: const RadialGradient(
                                      radius: 0.8,
                                      center: Alignment(0.2081, 0.1443),
                                      colors: [
                                        Color.fromARGB(255, 255, 118, 170),
                                        Color.fromARGB(255, 255, 3, 104)
                                      ],
                                      stops: [0.0, 1.0],
                                    ),
                                    image: AppImages.discoverydating,
                                    title: "Hẹn hò lâu dài",
                                    quantity: "",
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DiscoverySwiperPage(
                                                      type: "Dating")));
                                    },
                                  ),
                                  DiscoveryCard(
                                      width: (width - 40 * pix) / 2,
                                      gradient: const RadialGradient(
                                        radius: 0.8,
                                        center: Alignment(0.2081, 0.1443),
                                        colors: [
                                          Color(0xFF6BA7FF),
                                          Color(0xFF0D6EFD),
                                        ],
                                        stops: [0.0, 1.0],
                                      ),
                                      image: AppImages.discoverynobinding,
                                      title: "Mối quan hệ không ràng buộc",
                                      quantity: "",
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DiscoverySwiperPage(
                                                        type: "NoBinding")));
                                      }),
                                  DiscoveryCard(
                                      width: (width - 40 * pix) / 2,
                                      gradient: const RadialGradient(
                                        radius: 0.8,
                                        center: Alignment(0.2081, 0.1443),
                                        colors: [
                                          Color(0xFFFFC08C), // #FFC08C at 0%
                                          Color(0xFFFD7E14), // #FD7E14 at 100%
                                        ],
                                        stops: [0.0, 1.0],
                                      ),
                                      image: AppImages.discoveryfriend,
                                      title: "Những người bạn mới",
                                      quantity: "",
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DiscoverySwiperPage(
                                                        type: "Friend")));
                                      }),
                                  DiscoveryCard(
                                    width: (width - 40 * pix) / 2,
                                    gradient: const RadialGradient(
                                      radius: 0.8,
                                      center: Alignment(0.2081, 0.1443),
                                      colors: [
                                        Color(0xFF3AFFC5), // #3AFFC5 at 0%
                                        Color(0xFF20C997), // #20C997 at 100%
                                      ],
                                      stops: [0.0, 1.0],
                                    ),
                                    image: AppImages.discoveryverified,
                                    title: "Đã xác minh",
                                    quantity: "",
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DiscoverySwiperPage(
                                                      type: "Verified")));
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 24 * pix,
                              ),
                              Text("Chia sẻ sở thích chung",
                                  style: AppFonts.be600(
                                      16 * pix, AppColors.textPrimary)),
                              SizedBox(
                                height: 16 * pix,
                              ),
                              Wrap(
                                spacing: 8 * pix * pix,
                                runSpacing: 8,
                                children: [
                                  DiscoveryCard(
                                    width: (width - 40 * pix) / 2,
                                    gradient: const RadialGradient(
                                      radius: 0.8,
                                      center: Alignment(0.2081, 0.1443),
                                      colors: [
                                        Color(0xFF9554FF),
                                        Color(0xFF6610F2)
                                      ],
                                      stops: [0.0, 1.0],
                                    ),
                                    image: AppImages.discoverycooking,
                                    title: "Cùng nấu ăn",
                                    quantity: "",
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DiscoverySwiperPage(
                                                      type: "Cooking")));
                                    },
                                  ),
                                  DiscoveryCard(
                                    width: (width - 40 * pix) / 2,
                                    gradient: const RadialGradient(
                                      center: Alignment(-0.4, -0.7),
                                      radius: 1.5,
                                      colors: [
                                        Color(0xFFFF7A9C),
                                        Color(0xFFD63384),
                                      ],
                                      stops: [0.0, 1.0],
                                    ),
                                    image: AppImages.discoverymusic,
                                    title: "Yêu âm nhạc",
                                    quantity: "",
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DiscoverySwiperPage(
                                                      type: "Music")));
                                    },
                                  ),
                                  DiscoveryCard(
                                    width: (width - 40 * pix) / 2,
                                    gradient: const RadialGradient(
                                      radius: 0.8,
                                      center: Alignment(0.2081, 0.1443),
                                      colors: [
                                        Color(0xFF3AFFC5), // #3AFFC5 at 0%
                                        Color(0xFF20C997), // #20C997 at 100%
                                      ],
                                      stops: [0.0, 1.0],
                                    ),
                                    image: AppImages.discoverysport,
                                    title: "Chơi thể thao",
                                    quantity: "",
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DiscoverySwiperPage(
                                                      type: "Sport")));
                                    },
                                  ),
                                  DiscoveryCard(
                                    width: (width - 40 * pix) / 2,
                                    gradient: const RadialGradient(
                                      radius: 0.8,
                                      center: Alignment(0.2081, 0.1443),
                                      colors: [
                                        Color(0xFFFFC08C), // #FFC08C at 0%
                                        Color(0xFFFD7E14), // #FD7E14 at 100%
                                      ],
                                      stops: [0.0, 1.0],
                                    ),
                                    image: AppImages.discoverymovie,
                                    title: "Xem phim cùng nhau",
                                    quantity: "",
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DiscoverySwiperPage(
                                                      type: "Movie")));
                                    },
                                  ),
                                  DiscoveryCard(
                                    width: (width - 40 * pix) / 2,
                                    gradient: const RadialGradient(
                                      center: Alignment(-0.6, -0.7),
                                      radius: 1.5,
                                      colors: [
                                        Color(0xFFFF8C8C),
                                        Color(0xFFDC3545),
                                      ],
                                      stops: [0.0, 1.0],
                                    ),
                                    image: AppImages.discoverygame,
                                    title: "Hội mê game",
                                    quantity: "",
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DiscoverySwiperPage(
                                                      type: "Game")));
                                    },
                                  ),
                                  DiscoveryCard(
                                    width: (width - 40) / 2,
                                    gradient: const RadialGradient(
                                      radius: 0.8,
                                      center: Alignment(0.2081, 0.1443),
                                      colors: [
                                        Color(0xFF6BA7FF),
                                        Color(0xFF0D6EFD),
                                      ],
                                      stops: [0.0, 1.0],
                                    ),
                                    image: AppImages.discoverytravel,
                                    title: "Du lịch cùng nhau",
                                    quantity: "",
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DiscoverySwiperPage(
                                                      type: "Travel")));
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 100,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
            Positioned(
              bottom: 16,
              left: 0,
              right: 0,
              child: BottomBar(
                type: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
