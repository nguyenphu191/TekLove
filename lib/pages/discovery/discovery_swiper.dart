import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:provider/provider.dart';
import 'package:tiklove_fe/provider/AuthProvider.dart';
import 'package:tiklove_fe/provider/ProfileProvider.dart';
import 'package:tiklove_fe/widgets/card_swipe.dart';

class DiscoverySwiperPage extends StatefulWidget {
  const DiscoverySwiperPage({super.key, required this.type});
  final String type;

  @override
  State<DiscoverySwiperPage> createState() => _DiscoverySwiperPageState();
}

class _DiscoverySwiperPageState extends State<DiscoverySwiperPage>
    with WidgetsBindingObserver {
  bool isSpeed = false;
  final CardSwiperController controller = CardSwiperController();
  late String title;
  late ProfileProvider profileProvider;
  late AuthProvider authProvider;

  @override
  void initState() {
    super.initState();
    title = widget.type;
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      profileProvider = Provider.of<ProfileProvider>(context, listen: false);
      authProvider = Provider.of<AuthProvider>(context, listen: false);
      _fetchProfiles();
    });
  }

  void _fetchProfiles() {
    profileProvider.getProfilesDiscovery(
        authProvider.account!.id, widget.type, context);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _fetchProfiles();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pix = size.width / 393;
    return Scaffold(
      body:
          Consumer<ProfileProvider>(builder: (context, profileProvider, child) {
        final profile = profileProvider.profile;
        final otherProfiles = profileProvider.profiles;
        if (profile == null) {
          return Center(child: CircularProgressIndicator());
        }
        if (profileProvider.isLoading) {
          return Center(child: CircularProgressIndicator());
        }

        if (otherProfiles.isEmpty) {
          return Center(
              child: Container(
            height: size.height * 0.5,
            width: size.width,
            child: Column(
              children: [
                Text('Không tìm thấy đối tượng phù hợp'),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Quay lại'),
                ),
              ],
            ),
          ));
        }

        return SafeArea(
          child: Stack(
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
                      height: 60,
                      width: size.width,
                      margin: const EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.close, size: 30),
                          ),
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      key: ValueKey(otherProfiles
                          .length), // Khởi tạo lại CardSwiper khi danh sách thay đổi
                      height: size.height * 0.7,
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
                        numberOfCardsDisplayed:
                            otherProfiles.length > 2 ? 2 : otherProfiles.length,
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
                          } else if (direction == CardSwiperDirection.left) {
                            await profileProvider.skipProfile(
                                profile.accountId,
                                otherProfiles[previousIndex].accountId,
                                context);
                          } else if (direction == CardSwiperDirection.top) {
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
                          bool isSuperLike = verticalOffsetPercentage < 0 &&
                              verticalOffsetPercentage.abs() >
                                  horizontalOffsetPercentage.abs();

                          return Stack(
                            children: [
                              SwipeCard(
                                candidate: otherProfiles[index],
                                // Gọi swipe trực tiếp mà không kiểm tra chỉ số
                                onLike: () {
                                  controller.swipe(CardSwiperDirection.right);
                                },
                                onNope: () {
                                  controller.swipe(CardSwiperDirection.left);
                                },
                                onSuperLike: () {
                                  controller.swipe(CardSwiperDirection.top);
                                },
                                like: isLike,
                                nope: isNope,
                                superLike: isSuperLike,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
