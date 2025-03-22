import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiklove_fe/provider/AuthProvider.dart';
import 'package:tiklove_fe/provider/ProfileProvider.dart';
import 'package:tiklove_fe/res/images/app_images.dart';
import 'package:tiklove_fe/theme/app_colors.dart';
import 'package:tiklove_fe/widgets/bottom_bar.dart';
import 'package:tiklove_fe/widgets/like_card.dart';

class LikePage extends StatefulWidget {
  const LikePage({super.key});

  @override
  State<LikePage> createState() => _LikePageState();
}

class _LikePageState extends State<LikePage> {
  /// Dùng biến này để biết đang chọn “12 lượt thích” (0) hay “Bạn đã thích” (1)
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pix = size.width / 393;
    final authProvider = Provider.of<AuthProvider>(context);
    return Consumer<ProfileProvider>(
        builder: (context, profileProvider, child) {
      final profile = profileProvider.profile;

      final List<Map<String, dynamic>> wholike = [
        ...profile?.whosuperlikeyou,
        ...profile?.wholikeyou
      ];
      final List<Map<String, dynamic>> youlike = [
        ...profile?.whoyousuperlike,
        ...profile?.whoyoulike
      ];
      if (profile == null) {
        return Center(child: CircularProgressIndicator());
      }
      return Scaffold(
        body: Stack(
          children: [
            profile.isLove
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
                : Column(
                    children: [
                      // Thanh trên cùng
                      Container(
                        height: 80 * pix,
                        width: size.width,
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 16 * pix),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              AppImages.logoTeklovePink,
                              height: 38 * pix,
                              width: 170 * pix,
                            ),
                            Image.asset(
                              AppImages.iconFilter,
                              height: 32 * pix,
                              width: 32 * pix,
                            ),
                          ],
                        ),
                      ),

                      // Thanh chuyển đổi
                      Container(
                        height: 38 * pix,
                        width: size.width - 32,
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.grey[200], // Màu nền xám
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Row(
                          children: [
                            // Nút bên trái: “12 lượt thích”
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = 0;
                                  });
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  decoration: BoxDecoration(
                                    color: selectedIndex == 0
                                        ? AppColors
                                            .primary // Hồng nếu được chọn
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${profile.wholikeyou.length + profile.whosuperlikeyou.length} lượt thích',
                                      style: TextStyle(
                                        color: selectedIndex == 0
                                            ? Colors.white
                                            : const Color.fromARGB(
                                                255, 121, 121, 121),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // Nút bên phải: “Bạn đã thích”
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = 1;
                                  });
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  decoration: BoxDecoration(
                                    color: selectedIndex == 1
                                        ? AppColors.primary
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Bạn đã thích',
                                      style: TextStyle(
                                        color: selectedIndex == 1
                                            ? Colors.white
                                            : const Color.fromARGB(
                                                255, 121, 121, 121),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Nội dung bên dưới
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                height: 104 * pix,
                                width: size.width,
                                padding: const EdgeInsets.only(
                                    top: 16, left: 16, right: 16),
                                child: Column(
                                  children: [
                                    Text(
                                      'Bạn muốn tìm người tương hợp chung sở thích?',
                                      style: TextStyle(
                                        color: const Color(0xff000000),
                                        fontSize: 12,
                                        fontFamily: 'BeVietnamPro',
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 5),
                                    Align(
                                      alignment: Alignment.center,
                                      child: InkWell(
                                        onTap: () {
                                          print('Top tuyển chọn dành cho bạn');
                                        },
                                        child: Container(
                                          height: 46 * pix,
                                          width: 251 * pix,
                                          padding:
                                              const EdgeInsets.only(top: 12),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            border: Border.all(
                                              color: AppColors.primary,
                                              width: 1,
                                            ),
                                          ),
                                          child: Text(
                                            'Top tuyển chọn dành cho bạn',
                                            style: TextStyle(
                                              color: AppColors.primary,
                                              fontSize: 14,
                                              fontFamily: 'BeVietnamPro',
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              selectedIndex == 0
                                  ? Container(
                                      width: size.width,
                                      height: size.height - 242 * pix,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      decoration: const BoxDecoration(
                                        color: Color.fromARGB(0, 129, 129, 129),
                                      ),
                                      child: GridView.builder(
                                        padding: const EdgeInsets.all(10),
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 10,
                                          mainAxisSpacing: 10,
                                          childAspectRatio: 0.8,
                                        ),
                                        itemCount: wholike.length,
                                        itemBuilder: (context, index) {
                                          final candidate = wholike[index];
                                          return index <
                                                  profile.whosuperlikeyou.length
                                              ? authProvider.account!.premium
                                                  ? LikeCard(
                                                      candidate: candidate,
                                                      isSuper: true,
                                                      isVip: true,
                                                      isLiked: true,
                                                    )
                                                  : LikeCard(
                                                      candidate: candidate,
                                                      isSuper: true,
                                                      isLiked: true,
                                                    )
                                              : authProvider.account!.premium
                                                  ? LikeCard(
                                                      candidate: candidate,
                                                      isVip: true,
                                                      isLiked: true,
                                                    )
                                                  : index -
                                                              profile
                                                                  .whosuperlikeyou
                                                                  .length <
                                                          5
                                                      ? LikeCard(
                                                          candidate: candidate,
                                                          isVip: true,
                                                          isLiked: true,
                                                        )
                                                      : LikeCard(
                                                          candidate: candidate,
                                                          isLiked: true,
                                                        );
                                        },
                                      ),
                                    )
                                  : Container(
                                      width: size.width,
                                      height: size.height - 242 * pix,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      decoration: const BoxDecoration(
                                        color: Color.fromARGB(0, 129, 129, 129),
                                      ),
                                      child: GridView.builder(
                                        padding: const EdgeInsets.all(10),
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 10,
                                          mainAxisSpacing: 10,
                                          childAspectRatio: 0.8,
                                        ),
                                        itemCount: youlike.length,
                                        itemBuilder: (context, index) {
                                          final candidate = youlike[index];
                                          return index <
                                                  profile.whoyousuperlike.length
                                              ? LikeCard(
                                                  candidate: candidate,
                                                  isSuper: true,
                                                  isVip: true,
                                                )
                                              : LikeCard(
                                                  candidate: candidate,
                                                  isSuper: false,
                                                  isVip: true,
                                                );
                                        },
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
            // Thanh BottomBar
            Positioned(
              bottom: 16,
              left: 0,
              right: 0,
              child: BottomBar(
                type: 3,
              ),
            ),
          ],
        ),
      );
    });
  }
}
