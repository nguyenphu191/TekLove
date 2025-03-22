import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiklove_fe/pages/like/like_page.dart';
import 'package:tiklove_fe/pages/message/mess_card.dart';
import 'package:tiklove_fe/pages/message/new_match_card.dart';
import 'package:tiklove_fe/provider/MessageProvider.dart';
import 'package:tiklove_fe/provider/ProfileProvider.dart';
import 'package:tiklove_fe/res/images/app_images.dart';
import 'package:tiklove_fe/theme/app_colors.dart';
import 'package:tiklove_fe/widgets/bottom_bar.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  PageController pageController = PageController(viewportFraction: 0.4);
  List<Map<String, dynamic>> matchs = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final profileProvider =
          Provider.of<ProfileProvider>(context, listen: false);
      final messageProvider =
          Provider.of<MessageProvider>(context, listen: false);
      messageProvider.fetchAllMessages(profileProvider.profile!.accountId);
    });
    _fetchMatchs();
  }

  void _fetchMatchs() async {
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    final profile = profileProvider.profile;
    try {
      final matchs =
          await profileProvider.getMatch(profile!.accountId, context);
      if (matchs != null) {
        setState(() {
          this.matchs = matchs;
        });
      }
    } catch (e) {
      print('Error fetching matchs: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pix = size.width / 393;
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    final profile = profileProvider.profile;
    return Scaffold(
        body: Stack(
      children: [
        Column(
          children: [
            Container(
              height: 80,
              width: size.width,
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    AppImages.logoTeklovePink,
                    height: 38 * pix,
                    width: 170 * pix,
                  ),
                  Image.asset(
                    AppImages.iconSecurityUser,
                    height: 38 * pix,
                    width: 38 * pix,
                  ),
                ],
              ),
            ),
            Container(
              height: profile!.isLove ? 70 * pix : 248 * pix,
              width: size.width,
              child: Column(
                children: [
                  Container(
                    height: 46 * pix,
                    width: size.width - 32,
                    margin: EdgeInsets.only(left: 16, right: 16),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 230, 230, 230)
                          .withOpacity(0.8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: size.width - 32 - 46 * pix,
                          height: double.maxFinite,
                          child: const TextField(
                            decoration: InputDecoration(
                              hintText: 'Search',
                              hintStyle: TextStyle(
                                color: Color.fromARGB(255, 139, 139, 139),
                                fontSize: 14,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: 16),
                            ),
                          ),
                        ),
                        const Icon(Icons.search),
                      ],
                    ),
                  ),
                  profile.isLove
                      ? Container(
                          height: 0,
                          width: 0,
                        )
                      : Expanded(
                          child: Column(
                          children: [
                            Container(
                              width: double.maxFinite,
                              padding: EdgeInsets.only(
                                  left: 16, top: 16, bottom: 10),
                              child: Text(
                                'Tương hợp mới',
                                style: TextStyle(
                                    fontFamily: 'BeVietnamPro',
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Container(
                              height: 154 * pix,
                              width: size.width,
                              decoration: BoxDecoration(
                                color: Colors.white,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    height: 138 * pix,
                                    width: 99 * pix,
                                    margin: EdgeInsets.only(left: 16, right: 5),
                                    padding: EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: AppColors.accent,
                                        width: 2,
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          AppImages.iconCrownPremium,
                                          height: 36 * pix,
                                          width: 36 * pix,
                                        ),
                                        SizedBox(
                                          height: 10 * pix,
                                        ),
                                        Text(
                                          '${profile!.whosuperlikeyou.length + profile.wholikeyou.length} lượt thích',
                                          style: TextStyle(
                                              fontFamily: 'BeVietnamPro',
                                              fontSize: 10 * pix,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 10 * pix,
                                        ),
                                        Center(
                                            child: InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              LikePage()));
                                                },
                                                child: Container(
                                                    height: 34 * pix,
                                                    width: 59 * pix,
                                                    padding: EdgeInsets.only(
                                                        top: 8 * pix),
                                                    decoration: BoxDecoration(
                                                      color: AppColors.accent,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: AppColors
                                                              .accent
                                                              .withOpacity(0.5),
                                                          spreadRadius: 1,
                                                          blurRadius: 10,
                                                          offset: Offset(0, 1),
                                                        ),
                                                      ],
                                                    ),
                                                    child: Text(
                                                      'Xem',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'BeVietnamPro',
                                                        fontSize: 12 * pix,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    )))),
                                      ],
                                    ),
                                  ),
                                  Container(
                                      height: 138 * pix,
                                      width: size.width - 99 * pix - 42,
                                      child: ListView.separated(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: matchs.length,
                                        separatorBuilder: (context, index) {
                                          return SizedBox(width: 0);
                                        },
                                        itemBuilder: (context, index) {
                                          return NewMatchCard(
                                              match: matchs[index]);
                                        },
                                      ))
                                ],
                              ),
                            )
                          ],
                        )),
                ],
              ),
            ),
            Expanded(
                child: Column(
              children: [
                Container(
                  height: 60 * pix,
                  width: size.width,
                  padding: const EdgeInsets.only(left: 16, top: 16, bottom: 10),
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFF2F6),
                  ),
                  child: const Text(
                    'Tin nhắn',
                    style: TextStyle(
                        fontFamily: 'BeVietnamPro',
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                ),
                Expanded(
                  child: Container(
                    height: size.height - 388 * pix,
                    width: size.width,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFF2F6),
                    ),
                    child: Consumer<MessageProvider>(
                      builder: (context, messageProvider, child) {
                        final allMessages = messageProvider.getAllMessages();
                        if (messageProvider.isLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (allMessages.isEmpty) {
                          return const Center(
                            child: Text('No messages'),
                          );
                        }
                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 393 / 88,
                          ),
                          itemCount: allMessages.length,
                          itemBuilder: (context, index) {
                            return MessCard(
                              message: allMessages[index],
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ))
          ],
        ),
        const Positioned(
          bottom: 16,
          left: 0,
          right: 0,
          child: BottomBar(
            type: 4,
          ),
        ),
      ],
    ));
  }
}
