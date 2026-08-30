import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/icon_path.dart';
import '../../../../core/utils/constants/image_path.dart';
import '../../controllers/shop_controller.dart';
import '../widgets/product_card.dart';
import '../widgets/shop_chip.dart';

class VendorScreen extends StatelessWidget {
  const VendorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<ShopController>();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: AppColors.offWhite,
      ),
      child: Scaffold(
        backgroundColor: AppColors.offWhite,
        body: SingleChildScrollView(
          child: Column(
            children: [
              _VendorHeader(),
              Padding(
                padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'The Fabric Haven',
                      style: GoogleFonts.marcellus(
                        fontSize: 24.sp,
                        height: 1.2,
                        color: AppColors.textBody,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.black50,
                        borderRadius: BorderRadius.circular(25.r),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            IconPath.shopOrgDots,
                            width: 24.w,
                            height: 14.h,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            'ΩΨΦ',
                            style: GoogleFonts.hankenGrotesk(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textBody,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Flexible(
                            child: Text(
                              'Omega Psi Phi',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.hankenGrotesk(
                                fontSize: 12.sp,
                                height: 1.4,
                                color: AppColors.black400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),
                    const Divider(color: AppColors.black50),
                    SizedBox(height: 16.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Column(
                            children: [
                              _Stat(
                                icon: IconPath.shopStar,
                                value: '4.9',
                                label: '(142 reviews)',
                              ),
                              SizedBox(height: 12.h),
                              _Stat(
                                icon: IconPath.shopClock,
                                value: '1 hour',
                                label: 'Respond time',
                              ),
                              SizedBox(height: 12.h),
                              _Stat(
                                icon: IconPath.shopLocation,
                                value: 'Atlanta, GA',
                                label: 'Ships from',
                              ),
                              SizedBox(height: 12.h),
                              _Stat(
                                icon: IconPath.shopTruck,
                                value: 'Most orders ship within 2 days',
                                accent: true,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _Stat(
                                icon: IconPath.shopBox,
                                value: '42',
                                label: 'Products',
                              ),
                              SizedBox(height: 8.h),
                              _Stat(
                                icon: IconPath.shopCalendar,
                                value: '2024',
                                label: 'Vendor Since',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text:
                                'Premier artisan tailor specializing in heavyweight wool varsity jackets, custom leather goods, and high-density chenille embroidery for Divine Nine or ',
                            style: GoogleFonts.hankenGrotesk(
                              fontSize: 16.sp,
                              height: 1.6,
                              color: AppColors.black400,
                            ),
                          ),
                          TextSpan(
                            text: 'Read more',
                            style: GoogleFonts.hankenGrotesk(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              height: 1.3,
                              color: AppColors.maroonAccent,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    GestureDetector(
                      onTap: c.openContactVendor,
                      child: Container(
                        width: double.infinity,
                        height: 48.h,
                        decoration: BoxDecoration(
                          color: AppColors.burgundy50,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(color: AppColors.burgundy200),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              IconPath.shopMessage,
                              width: 20.w,
                              height: 20.w,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              'Message Vendor',
                              style: GoogleFonts.hankenGrotesk(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                height: 1.2,
                                color: AppColors.vendorRose,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Obx(
                      () => SizedBox(
                        height: 32.h,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            ShopChip(
                              label: 'All',
                              width: 81.w,
                              selected: c.vendorCategory.value == 'All',
                              onTap: () => c.setVendorCategory('All'),
                            ),
                            SizedBox(width: 8.w),
                            ShopChip(
                              label: 'Men',
                              width: 81.w,
                              selected: c.vendorCategory.value == 'Men',
                              onTap: () => c.setVendorCategory('Men'),
                            ),
                            SizedBox(width: 8.w),
                            ShopChip(
                              label: 'Women',
                              width: 104.w,
                              selected: c.vendorCategory.value == 'Women',
                              onTap: () => c.setVendorCategory('Women'),
                            ),
                            SizedBox(width: 8.w),
                            ShopChip(
                              label: 'Accessories',
                              width: 120.w,
                              selected: c.vendorCategory.value == 'Accessories',
                              onTap: () => c.setVendorCategory('Accessories'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Obx(() {
                      final products = c.vendorProducts;
                      return Column(
                        children: [
                          Row(
                            children: [
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '${products.length}',
                                      style: GoogleFonts.hankenGrotesk(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.textBody,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' Results',
                                      style: GoogleFonts.hankenGrotesk(
                                        fontSize: 14.sp,
                                        color: AppColors.black300,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              Flexible(
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Short: ',
                                        style: GoogleFonts.hankenGrotesk(
                                          fontSize: 14.sp,
                                          color: AppColors.black300,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'Price Low to High',
                                        style: GoogleFonts.hankenGrotesk(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.textBody,
                                        ),
                                      ),
                                    ],
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.right,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              SvgPicture.asset(
                                IconPath.shopChevron,
                                width: 16.w,
                                height: 16.w,
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          ...List.generate((products.take(6).length / 2).ceil(), (
                            row,
                          ) {
                            final left = products[row * 2];
                            final right = row * 2 + 1 < products.length
                                ? products[row * 2 + 1]
                                : null;
                            return Padding(
                              padding: EdgeInsets.only(bottom: 8.h),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: ProductCard(
                                      product: left,
                                      expand: true,
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Expanded(
                                    child: right != null
                                        ? ProductCard(
                                            product: right,
                                            expand: true,
                                          )
                                        : const SizedBox.shrink(),
                                  ),
                                ],
                              ),
                            );
                          }),
                          GestureDetector(
                            onTap: c.openShop,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'View All',
                                  style: GoogleFonts.hankenGrotesk(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.vendorRose,
                                  ),
                                ),
                                SizedBox(width: 4.w),
                                SvgPicture.asset(
                                  IconPath.shopArrowRight,
                                  width: 24.w,
                                  height: 24.w,
                                  colorFilter: const ColorFilter.mode(
                                    AppColors.vendorRose,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
                    SizedBox(height: 24.h),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: AppColors.black50),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Vendor Policies Q Fulfillment Guarantee',
                            style: GoogleFonts.marcellus(
                              fontSize: 20.sp,
                              height: 1.2,
                              color: AppColors.textBody,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            'Shipping Policy:',
                            style: GoogleFonts.hankenGrotesk(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textBody,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'Standard shipping via UPS Ground (3-5 business days). \nExpedited 2-day air available at checkout Tracking \nsent via email upon dispatch.',
                            style: GoogleFonts.hankenGrotesk(
                              fontSize: 14.sp,
                              height: 1.5,
                              color: AppColors.black400,
                            ),
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            'Return & Exchange Policy:',
                            style: GoogleFonts.hankenGrotesk(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textBody,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'Free returns within 30 days for unworn standard items. \nMade-to-order items eligible for size exchanges within \n14 days.',
                            style: GoogleFonts.hankenGrotesk(
                              fontSize: 14.sp,
                              height: 1.5,
                              color: AppColors.black400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _VendorHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final avatarSize = 100.w;
    final coverHeight = 225.h;
    final headerHeight = coverHeight + avatarSize / 2;

    return SizedBox(
      height: headerHeight,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          SizedBox(
            height: coverHeight,
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(ImagePath.shopVendorCover, fit: BoxFit.cover),
                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xD12A060D), Color(0x000D050B)],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 0),
              child: Row(
                children: [
                  _CircleBtn(icon: IconPath.shopBack, onTap: Get.back),
                  const Spacer(),
                  _CircleBtn(icon: IconPath.shopShare, onTap: () {}),
                ],
              ),
            ),
          ),
          Positioned(
            left: 16.w,
            top: coverHeight - avatarSize / 2,
            child: Container(
              width: avatarSize,
              height: avatarSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
                image: const DecorationImage(
                  image: AssetImage(ImagePath.shopVendorAvatar),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            left: 16.w + avatarSize + 12.w,
            right: 16.w,
            bottom: 8.h,
            child: Wrap(
              spacing: 8.w,
              runSpacing: 4.h,
              children: [
                _HeaderBadge(
                  icon: IconPath.shopTick,
                  label: 'Licensed',
                  background: AppColors.burgundy,
                  foreground: AppColors.gold400,
                  iconColor: AppColors.gold400,
                ),
                _HeaderBadge(
                  icon: IconPath.shopSparkle,
                  label: 'Featured Vendor',
                  background: AppColors.gold50,
                  foreground: AppColors.burgundy,
                  border: AppColors.burgundy100,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderBadge extends StatelessWidget {
  const _HeaderBadge({
    required this.icon,
    required this.label,
    required this.background,
    required this.foreground,
    this.iconColor,
    this.border,
  });

  final String icon;
  final String label;
  final Color background;
  final Color foreground;
  final Color? iconColor;
  final Color? border;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(43.r),
        border: border == null ? null : Border.all(color: border!),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            icon,
            width: 12.w,
            height: 12.w,
            colorFilter: iconColor == null
                ? null
                : ColorFilter.mode(iconColor!, BlendMode.srcIn),
          ),
          SizedBox(width: 3.w),
          Text(
            label,
            style: GoogleFonts.hankenGrotesk(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              height: 1.2,
              color: foreground,
            ),
          ),
        ],
      ),
    );
  }
}

class _CircleBtn extends StatelessWidget {
  const _CircleBtn({required this.icon, required this.onTap});

  final String icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36.w,
        height: 36.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
        ),
        alignment: Alignment.center,
        child: SvgPicture.asset(icon, width: 20.w, height: 20.w),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({
    required this.icon,
    required this.value,
    this.label,
    this.accent = false,
  });

  final String icon;
  final String value;
  final String? label;
  final bool accent;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(icon, width: 16.w, height: 16.w),
        SizedBox(width: 8.w),
        Flexible(
                          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: value,
                  style: GoogleFonts.hankenGrotesk(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    height: 1.3,
                    color: accent ? AppColors.maroonDark : AppColors.textBody,
                  ),
                ),
                if (label != null)
                  TextSpan(
                    text: ' $label',
                    style: GoogleFonts.hankenGrotesk(
                      fontSize: 12.sp,
                      height: 1.3,
                      color: AppColors.black400,
                    ),
                  ),
              ],
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
