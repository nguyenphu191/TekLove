import 'package:flutter/material.dart';

import '../res/fonts/app_fonts.dart';
import '../res/images/app_images.dart';
import '../theme/app_colors.dart';

class DiscoveryCard extends StatelessWidget {
  final double width;
  final double? height;
  final Gradient? gradient;
  final BoxBorder? border;
  final EdgeInsets? padding;
  final String? image;
  final String? title;
  final String? quantity;
  final Function()? onTap;

  const DiscoveryCard(
      {super.key,
      required this.width,
      this.height,
      this.gradient,
      this.border,
      this.image,
      this.quantity,
      this.title,
      this.padding,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double pix = size.width / 393;
    return InkWell(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: width,
            height: 238 * pix,
            padding: padding ?? const EdgeInsets.all(16),
            decoration: BoxDecoration(
                gradient: gradient,
                border: border ??
                    Border.all(
                      color: const Color(0xffFFFFFF)
                          .withOpacity(0.4), // Border color #FFFFFF66
                      width: 1,
                    ),
                borderRadius: BorderRadius.circular(16)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                image != null
                    ? Center(
                        child: Image.asset(
                        image!,
                        width: 120 * pix,
                        height: 120 * pix,
                        fit: BoxFit.cover,
                      ))
                    : const SizedBox.shrink(),
                const Spacer(),
                title != null
                    ? Text(title!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppFonts.be700(16, AppColors.background))
                    : const SizedBox.shrink(),
                const SizedBox(
                  height: 8,
                ),
                quantity != null
                    ? Container(
                        padding: const EdgeInsets.fromLTRB(6, 2, 8, 2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                                width: 1,
                                color: AppColors.background.withOpacity(0.2)),
                            color: AppColors.background.withOpacity(0.1)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              AppImages.iconDiscoveryCardQuantityMember,
                              width: 12,
                              height: 12,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(quantity!,
                                style: AppFonts.be400(12, AppColors.background))
                          ],
                        ),
                      )
                    : const SizedBox.shrink()
              ],
            ),
          ),
          Positioned(
              top: -1,
              left: 0,
              right: 0,
              child: Image.asset(AppImages.lightFlashEffectWhiteLens))
        ],
      ),
    );
  }
}
