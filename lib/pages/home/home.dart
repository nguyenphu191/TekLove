import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:provider/provider.dart';
import 'package:tiklove_fe/pages/home/notification.dart';
import 'package:tiklove_fe/pages/love/love/love_card.dart';
import 'package:tiklove_fe/pages/love/love/love_widget/love_bottom_bar.dart';
import 'package:tiklove_fe/pages/setting/setting_page.dart';
import 'package:tiklove_fe/provider/AuthProvider.dart';
import 'package:tiklove_fe/provider/ProfileProvider.dart';
import 'package:tiklove_fe/theme/app_colors.dart';
import 'package:tiklove_fe/widgets/bottom_bar.dart';
import 'package:tiklove_fe/widgets/card_swipe.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  bool isLove = false;
  final CardSwiperController controller = CardSwiperController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final profileProvider =
          Provider.of<ProfileProvider>(context, listen: false);
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      profileProvider.getOtherProfiles(authProvider.account!.id, context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final myprofile = Provider.of<ProfileProvider>(context).profile;
    final size = MediaQuery.of(context).size;
    final pix = size.width / 393;
    return Scaffold(
      body: Stack(
        children: [
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
            child: Column(
              children: [
                Container(
                  height: 73 * pix,
                  width: size.width,
                  margin: EdgeInsets.only(top: 10 * pix),
                  padding: EdgeInsets.symmetric(horizontal: 10 * pix),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/Teklove/love.png',
                            height: 32,
                            width: 32,
                          ),
                          SizedBox(width: 10 * pix),
                          _buildTopBarButton(
                            label: "Tìm kiếm",
                            icon: Icons.search,
                            color:
                                isLove ? Colors.grey[300]! : AppColors.primary,
                            textColor:
                                isLove ? Colors.grey[600]! : Colors.white,
                            onTap: () {
                              setState(() {
                                isLove = !isLove;
                              });
                            },
                          ),
                          SizedBox(width: 10 * pix),
                          _buildTopBarButton(
                            label: "Hẹn hò",
                            icon: Icons.favorite_border_outlined,
                            color:
                                isLove ? AppColors.primary : Colors.grey[300]!,
                            textColor:
                                isLove ? Colors.white : Colors.grey[600]!,
                            onTap: () {
                              setState(() {
                                isLove = !isLove;
                              });
                            },
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          NotificationPage()));
                            },
                            icon: Icon(
                              Icons.notifications,
                              size: 32 * pix,
                              color: Colors.black54,
                            ),
                          ),
                          SizedBox(width: 10 * pix),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SettingPage(issetaccount: false)));
                            },
                            child: Container(
                              height: 32 * pix,
                              width: 32 * pix,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/Teklove/candle-2.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                myprofile!.isLove
                    ? LoveCard()
                    : Consumer<ProfileProvider>(
                        builder: (context, profileProvider, child) {
                          final profile = profileProvider.profile;
                          final otherProfiles = profileProvider.profiles;
                          if (profile == null) {
                            return Center(child: CircularProgressIndicator());
                          }
                          if (profileProvider.isLoading) {
                            return Center(child: CircularProgressIndicator());
                          }
                          if (otherProfiles.isEmpty) {
                            return Center(child: Text('No profiles'));
                          }
                          return Container(
                            key: ValueKey(otherProfiles
                                .length), // Khởi tạo lại CardSwiper khi danh sách thay đổi
                            height: size.height * 0.73,
                            width: size.width,
                            margin: EdgeInsets.only(
                                top: 10 * pix, left: 10 * pix, right: 10 * pix),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color.fromARGB(255, 40, 40, 40),
                            ),
                            child: CardSwiper(
                              padding: const EdgeInsets.all(0),
                              controller: controller,
                              numberOfCardsDisplayed: otherProfiles.length > 2
                                  ? 2
                                  : otherProfiles.length,
                              backCardOffset: const Offset(0, 0),
                              cardsCount: otherProfiles.length,
                              isLoop: false,
                              onSwipe: (int previousIndex, int? currentIndex,
                                  CardSwiperDirection direction) async {
                                // Chặn swipe xuống dưới
                                if (direction == CardSwiperDirection.bottom) {
                                  return false;
                                }

                                if (direction == CardSwiperDirection.right) {
                                  await profileProvider.likeProfile(
                                      profile.accountId,
                                      otherProfiles[previousIndex].accountId,
                                      context);
                                } else if (direction ==
                                    CardSwiperDirection.left) {
                                  await profileProvider.skipProfile(
                                      profile.accountId,
                                      otherProfiles[previousIndex].accountId,
                                      context);
                                } else if (direction ==
                                    CardSwiperDirection.top) {
                                  await profileProvider.superLikeProfile(
                                      profile.accountId,
                                      otherProfiles[previousIndex].accountId,
                                      context);
                                }
                                // Trả về true để cho phép swipe
                                return true;
                              },
                              onEnd: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.all(16 * pix),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'Hết profiles',
                                            style: TextStyle(
                                              fontSize: 20 * pix,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 8 * pix),
                                          Text('Bạn đã xem hết tất cả profiles',
                                              style: TextStyle(
                                                fontSize: 16 * pix,
                                              )),
                                          SizedBox(height: 16 * pix),
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              cardBuilder: (context,
                                  index,
                                  horizontalOffsetPercentage,
                                  verticalOffsetPercentage) {
                                // Xác định hướng swipe dựa trên tỷ lệ offset
                                bool isLike = horizontalOffsetPercentage > 0 &&
                                    horizontalOffsetPercentage.abs() >
                                        verticalOffsetPercentage.abs();
                                bool isNope = horizontalOffsetPercentage < 0 &&
                                    horizontalOffsetPercentage.abs() >
                                        verticalOffsetPercentage.abs();
                                bool isSuperLike =
                                    verticalOffsetPercentage < 0 &&
                                        verticalOffsetPercentage.abs() >
                                            horizontalOffsetPercentage.abs();

                                return Stack(
                                  children: [
                                    SwipeCard(
                                      candidate: otherProfiles[index],
                                      // Gọi swipe trực tiếp mà không kiểm tra chỉ số
                                      onLike: () {
                                        controller
                                            .swipe(CardSwiperDirection.right);
                                      },
                                      onNope: () {
                                        controller
                                            .swipe(CardSwiperDirection.left);
                                      },
                                      onSuperLike: () {
                                        controller
                                            .swipe(CardSwiperDirection.top);
                                      },
                                      like: isLike,
                                      nope: isNope,
                                      superLike: isSuperLike,
                                    ),
                                  ],
                                );
                              },
                            ),
                          );
                        },
                      ),
                SizedBox(height: 35 * pix),
              ],
            ),
          ),
          Positioned(
            bottom: 16 * pix,
            left: 0,
            right: 0,
            child: isLove
                ? LoveBottomBar(type: 1)
                : BottomBar(
                    type: 1,
                  ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget _buildTopBarButton({
    required String label,
    required IconData icon,
    required Color color,
    required Color textColor,
    required VoidCallback onTap,
  }) {
    final size = MediaQuery.of(context).size;
    final pix = size.width / 393;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12 * pix, vertical: 6 * pix),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(icon, size: 18 * pix, color: textColor),
            SizedBox(width: 4 * pix),
            Text(
              label,
              style: TextStyle(fontSize: 12 * pix, color: textColor),
            ),
          ],
        ),
      ),
    );
  }
}
