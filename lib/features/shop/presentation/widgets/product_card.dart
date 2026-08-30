import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/icon_path.dart';
import '../../controllers/shop_controller.dart';
import '../../models/product_model.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product, this.expand = false});

  final ShopProduct product;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final c = Get.find<ShopController>();

    return GestureDetector(
      onTap: () => c.openProduct(product),
      child: Container(
        width: expand ? double.infinity : 181.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.black50),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 150.h,
              width: double.infinity,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(12.r),
                    ),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(product.image, fit: BoxFit.cover),
                        DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                AppColors.burgundy.withValues(alpha: 0.75),
                                Colors.black.withValues(alpha: 0.04),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 8.w,
                    top: 8.h,
                    child: Container(
                      width: 50.w,
                      height: 24.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0x1AC9A84C),
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                          color: AppColors.gold100,
                          width: 0.5,
                        ),
                      ),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          c.orgLetters,
                          style: GoogleFonts.hankenGrotesk(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            height: 1.0,
                            letterSpacing: -0.42,
                            color: AppColors.gold300,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 8.w,
                    top: 8.h,
                    child: GestureDetector(
                      onTap: () => c.toggleSaved(product.id),
                      behavior: HitTestBehavior.opaque,
                      child: SizedBox(
                        width: 24.w,
                        height: 24.w,
                        child: Obx(() {
                          final saved = c.savedIds.contains(product.id);
                          return SvgPicture.asset(
                            saved
                                ? IconPath.shopHeartFilled
                                : IconPath.shopHeart,
                            width: 24.w,
                            height: 24.w,
                            colorFilter: saved
                                ? const ColorFilter.mode(
                                    AppColors.maroonAccent,
                                    BlendMode.srcIn,
                                  )
                                : null,
                          );
                        }),
                      ),
                    ),
                  ),
                  if (!product.membersOnly)
                    Positioned(
                      left: 8.w,
                      bottom: 8.h,
                      child: SvgPicture.asset(
                        IconPath.shopColorDots,
                        width: 32.w,
                        height: 8.h,
                      ),
                    ),
                  if (product.membersOnly)
                    Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: AppColors.burgundy.withValues(alpha: 0.7),
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(12.r),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 32.w,
                              height: 32.w,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              alignment: Alignment.center,
                              child: SvgPicture.asset(
                                IconPath.shopLock,
                                width: 16.w,
                                height: 16.w,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              'Members Only',
                              style: GoogleFonts.hankenGrotesk(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                height: 1.2,
                                color: AppColors.gold,
                              ),
                            ),
                            Text(
                              product.unlockLabel,
                              style: GoogleFonts.hankenGrotesk(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                height: 1.4,
                                color: AppColors.black100,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(12.w, 8.h, 12.w, 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.hankenGrotesk(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                      color: AppColors.textBody,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  if (product.membersOnly) ...[
                    Text(
                      product.priceLabel,
                      style: GoogleFonts.hankenGrotesk(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        height: 1.2,
                        letterSpacing: -0.42,
                        color: AppColors.maroonAccent,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    GestureDetector(
                      onTap: () => c.openProduct(product),
                      child: Container(
                        height: 24.h,
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        decoration: BoxDecoration(
                          color: AppColors.gold,
                          borderRadius: BorderRadius.circular(43.r),
                        ),
                        alignment: Alignment.center,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            'Unlock With Elite',
                            maxLines: 1,
                            style: GoogleFonts.hankenGrotesk(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              height: 1.0,
                              color: AppColors.gold50,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ] else ...[
                    Row(
                      children: [
                        Text(
                          product.priceLabel,
                          style: GoogleFonts.hankenGrotesk(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            height: 1.2,
                            letterSpacing: -0.42,
                            color: AppColors.maroonAccent,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Flexible(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              if (product.badge == ProductBadge.limitedDrop) ...[
                                SvgPicture.asset(
                                  IconPath.shopDiamond,
                                  width: 12.w,
                                  height: 12.w,
                                ),
                                SizedBox(width: 3.w),
                                Flexible(
                                  child: Text(
                                    'Limited Drop',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.hankenGrotesk(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      height: 1.3,
                                      color: AppColors.burgundy,
                                    ),
                                  ),
                                ),
                              ] else ...[
                                SvgPicture.asset(
                                  IconPath.shopTick,
                                  width: 12.w,
                                  height: 12.w,
                                  colorFilter: const ColorFilter.mode(
                                    AppColors.gold600,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                SizedBox(width: 3.w),
                                Flexible(
                                  child: Text(
                                    'Licensed',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.hankenGrotesk(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      height: 1.3,
                                      color: AppColors.gold600,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        SvgPicture.asset(
                          IconPath.shopStar,
                          width: 12.w,
                          height: 12.w,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          '4.9 (128)',
                          style: GoogleFonts.hankenGrotesk(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            height: 1.4,
                            color: AppColors.black300,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Container(
                          width: 1,
                          height: 15.h,
                          color: AppColors.black50,
                        ),
                        SizedBox(width: 8.w),
                        SvgPicture.asset(
                          IconPath.shopZap,
                          width: 12.w,
                          height: 12.w,
                        ),
                        SizedBox(width: 4.w),
                        Flexible(
                          child: Text(
                            'Ships by Fri',
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.hankenGrotesk(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              height: 1.4,
                              color: AppColors.black300,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
