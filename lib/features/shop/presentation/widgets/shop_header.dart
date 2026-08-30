import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/icon_path.dart';
import '../../../../features/authentication/presentation/widgets/auth_input.dart';
import '../../controllers/shop_controller.dart';

class ShopHeader extends StatelessWidget {
  const ShopHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<ShopController>();

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(color: AppColors.burgundy),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          const Positioned.fill(
            child: IgnorePointer(
              child: CustomPaint(
                painter: _HeaderLightPainter(),
                child: SizedBox.expand(),
              ),
            ),
          ),
          SafeArea(
            bottom: false,
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: c.changeOrganization,
                        child: Container(
                          width: 98.w,
                          height: 36.h,
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          decoration: BoxDecoration(
                            color: const Color(0x1AC9A84C),
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(color: AppColors.gold100),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  c.orgLetters,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.hankenGrotesk(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    height: 1.2,
                                    color: AppColors.gold300,
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.arrow_drop_down,
                                size: 20.w,
                                color: AppColors.gold300,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                      Obx(() {
                        final count = c.cartCount.value;
                        return GestureDetector(
                          onTap: c.openCart,
                          child: SizedBox(
                            width: 40.w,
                            height: 41.h,
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Positioned(
                                  top: 1.h,
                                  child: Container(
                                    width: 40.w,
                                    height: 40.w,
                                    decoration: BoxDecoration(
                                      color: AppColors.maroon50,
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                    child: Center(
                                      child: SvgPicture.asset(
                                        IconPath.shopCart,
                                        width: 24.w,
                                        height: 24.w,
                                        colorFilter: const ColorFilter.mode(
                                          AppColors.maroonAccent,
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: -7.w,
                                  top: 0,
                                  child: Container(
                                    width: 16.w,
                                    height: 16.w,
                                    decoration: const BoxDecoration(
                                      color: AppColors.gold300,
                                      shape: BoxShape.circle,
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      '$count',
                                      style: GoogleFonts.hankenGrotesk(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w700,
                                        height: 1,
                                        color: AppColors.maroonAccent,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  AuthThemeScope(
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.fromLTRB(12.w, 14.h, 12.w, 14.h),
                      decoration: BoxDecoration(
                        color: AppColors.offWhite,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: SizedBox(
                        height: 26.h,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 24.w,
                              height: 24.w,
                              child: SvgPicture.asset(
                                IconPath.search,
                                width: 24.w,
                                height: 24.w,
                                fit: BoxFit.contain,
                                colorFilter: const ColorFilter.mode(
                                  AppColors.black400,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: TextField(
                                controller: c.searchController,
                                onChanged: c.onSearchChanged,
                                cursorColor: AppColors.gold,
                                textAlignVertical: TextAlignVertical.center,
                                style: GoogleFonts.hankenGrotesk(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  height: 1.6,
                                  color: AppColors.textBody,
                                ),
                                decoration:
                                    authBareDecoration(
                                      hint: 'Search apparel, gifts, drops...',
                                      hintColor: AppColors.black400,
                                    ).copyWith(
                                      hintStyle: GoogleFonts.hankenGrotesk(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400,
                                        height: 1.6,
                                        color: AppColors.black400,
                                      ),
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Figma Home header light streaks (`106:305`): five rotated beams,
/// mix-blend plus-lighter, blur 4px, maroon → transparent.
class _HeaderLightPainter extends CustomPainter {
  const _HeaderLightPainter();

  static const _designWidth = 402.0;
  static const _beamBoxW = 240.106;
  static const _beamBoxH = 247.679;
  static const _beamW = 42.679;
  static const _beamH = 302.318;
  static const _angle = 43.56 * math.pi / 180;

  static const _rays = <(double, double)>[
    (229.0, -16.0),
    (185.0, -63.0),
    (205.0, -42.0),
    (226.0, -24.0),
    (218.0, -44.0),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) return;

    final s = size.width / _designWidth;
    canvas.drawRect(Offset.zero & size, Paint()..color = AppColors.burgundy);

    for (final ray in _rays) {
      final cx = (ray.$1 + _beamBoxW / 2) * s;
      final cy = (ray.$2 + _beamBoxH / 2) * s;

      canvas.save();
      canvas.translate(cx, cy);
      canvas.rotate(_angle);

      final rect = Rect.fromCenter(
        center: Offset.zero,
        width: _beamW * s,
        height: _beamH * s,
      );

      final paint = Paint()
        ..blendMode = BlendMode.plus
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, 4.027 * s)
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.0, 0.8],
          colors: [
            AppColors.maroonAccent.withValues(alpha: 0.3),
            AppColors.burgundy.withValues(alpha: 0),
          ],
        ).createShader(rect);

      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, Radius.circular(8 * s)),
        paint,
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
