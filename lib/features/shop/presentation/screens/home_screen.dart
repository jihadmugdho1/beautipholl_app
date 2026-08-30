import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/icon_path.dart';
import '../../../../core/utils/constants/image_path.dart';
import '../../controllers/shop_controller.dart';
import '../../models/product_model.dart';
import '../widgets/product_card.dart';
import '../widgets/shop_chip.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<ShopController>();

    return ColoredBox(
      color: AppColors.offWhite,
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => Row(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ShopChip(
                            label: 'Men',
                            width: 81.w,
                            selected: c.homeCategory.value == 'Men',
                            onTap: () => c.setHomeCategory('Men'),
                          ),
                          SizedBox(width: 8.w),
                          ShopChip(
                            label: 'Women',
                            width: 104.w,
                            selected: c.homeCategory.value == 'Women',
                            onTap: () => c.setHomeCategory('Women'),
                          ),
                          SizedBox(width: 8.w),
                          ShopChip(
                            label: 'Children',
                            width: 104.w,
                            selected: c.homeCategory.value == 'Children',
                            onTap: () => c.setHomeCategory('Children'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  const ShopFilterButton(),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            _HeroBanner(onShopNow: c.openShop),
            SizedBox(height: 24.h),
            _SectionHeader(title: 'Shop by occasion', onViewAll: c.openShop),
            SizedBox(height: 12.h),
            SizedBox(
              height: 141.h,
              child: Row(
                children: [
                  _OccasionCard(
                    image: ImagePath.shopOccasion1,
                    label: 'Crossing',
                    onTap: c.openShop,
                  ),
                  SizedBox(width: 8.w),
                  _OccasionCard(
                    image: ImagePath.shopOccasion2,
                    label: 'Probate',
                    onTap: c.openShop,
                  ),
                  SizedBox(width: 8.w),
                  _OccasionCard(
                    image: ImagePath.shopOccasion2,
                    label: 'Homecoming',
                    onTap: c.openShop,
                  ),
                  SizedBox(width: 8.w),
                  _OccasionCard(
                    image: ImagePath.shopOccasion3,
                    label: 'Founders Day',
                    onTap: c.openShop,
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            _SectionHeader(
              title: 'Most Popular for ${c.orgShort}',
              subtitle: 'Because you bought a une jacket',
              onViewAll: c.openShop,
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                Expanded(
                  child: ProductCard(
                    product: ShopCatalog.products[0],
                    expand: true,
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: ProductCard(
                    product: ShopCatalog.products[0],
                    expand: true,
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),
            _SupportVendorsCard(onTap: c.openVendor),
            SizedBox(height: 20.h),
            const _TrustTicker(),
          ],
        ),
      ),
    );
  }
}

class _HeroSlide {
  const _HeroSlide({
    required this.title,
    required this.subtitle,
    required this.image,
  });

  final String title;
  final String subtitle;
  final String image;
}

class _HeroBanner extends StatefulWidget {
  const _HeroBanner({required this.onShopNow});

  final VoidCallback onShopNow;

  @override
  State<_HeroBanner> createState() => _HeroBannerState();
}

class _HeroBannerState extends State<_HeroBanner> {
  static const _slides = [
    _HeroSlide(
      title: 'Line Gifts & Fits',
      subtitle: 'Up to 30% off • licensed vendors only',
      image: ImagePath.shopHero,
    ),
    _HeroSlide(
      title: 'Homecoming Drops',
      subtitle: 'New licensed fits for the season',
      image: ImagePath.shopProduct,
    ),
    _HeroSlide(
      title: 'Crossing Essentials',
      subtitle: 'Official line gifts from verified vendors',
      image: ImagePath.shopProduct2,
    ),
    _HeroSlide(
      title: 'Founders Day Fits',
      subtitle: 'Celebrate with gold & purple staples',
      image: ImagePath.shopProduct3,
    ),
    _HeroSlide(
      title: 'Shop the Yard',
      subtitle: 'Members save more on licensed apparel',
      image: ImagePath.shopProductHero,
    ),
  ];

  late final PageController _pageController;
  Timer? _timer;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startAutoPlay();
  }

  void _startAutoPlay() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!mounted || !_pageController.hasClients) return;
      _pageController.nextPage(
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 180.h,
      decoration: BoxDecoration(
        color: AppColors.maroon700,
        borderRadius: BorderRadius.circular(12.r),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _index = index % _slides.length);
              _startAutoPlay();
            },
            itemBuilder: (context, index) {
              final slide = _slides[index % _slides.length];
              return Stack(
                children: [
                  Positioned(
                    right: -10.w,
                    bottom: 0,
                    child: Image.asset(
                      slide.image,
                      width: 166.w,
                      height: 133.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 16.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            slide.title,
                            style: GoogleFonts.marcellus(
                              fontSize: 32.sp,
                              height: 1.2,
                              color: AppColors.gold200,
                            ),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          slide.subtitle,
                          style: GoogleFonts.hankenGrotesk(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            height: 1.5,
                            color: AppColors.burgundy50,
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: widget.onShopNow,
                          child: Container(
                            width: 118.w,
                            height: 32.h,
                            decoration: BoxDecoration(
                              color: AppColors.burgundy,
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border(
                                top: BorderSide(
                                  color: AppColors.burgundy100,
                                  width: 0.75,
                                ),
                                left: BorderSide(
                                  color: AppColors.burgundy100,
                                  width: 0.75,
                                ),
                                right: BorderSide(
                                  color: AppColors.burgundy100,
                                  width: 0.75,
                                ),
                                bottom: BorderSide(
                                  color: AppColors.burgundy100,
                                  width: 3,
                                ),
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Shop Now',
                              style: GoogleFonts.hankenGrotesk(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                height: 1.2,
                                color: AppColors.burgundy50,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 7.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_slides.length, (i) {
                final active = i == _index;
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 1.5.w),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    width: 4.w,
                    height: 4.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: active ? Colors.white : const Color(0xFFD2D2D2),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    required this.onViewAll,
    this.subtitle,
  });

  final String title;
  final String? subtitle;
  final VoidCallback onViewAll;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.marcellus(
                  fontSize: 20.sp,
                  height: 1.2,
                  color: AppColors.textBody,
                ),
              ),
              if (subtitle != null) ...[
                SizedBox(height: 4.h),
                Text(
                  subtitle!,
                  style: GoogleFonts.hankenGrotesk(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                    color: AppColors.black300,
                  ),
                ),
              ],
            ],
          ),
        ),
        GestureDetector(
          onTap: onViewAll,
          child: Row(
            children: [
              Text(
                'View All',
                style: GoogleFonts.hankenGrotesk(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  height: 1.2,
                  color: AppColors.maroonDark,
                ),
              ),
              SizedBox(width: 4.w),
              SvgPicture.asset(
                IconPath.shopArrowRight,
                width: 16.w,
                height: 16.w,
                colorFilter: const ColorFilter.mode(
                  AppColors.maroonDark,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _OccasionCard extends StatelessWidget {
  const _OccasionCard({
    required this.image,
    required this.label,
    required this.onTap,
  });

  final String image;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(image, fit: BoxFit.cover),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                height: 42.h,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.gold700.withValues(alpha: 0),
                        AppColors.gold700.withValues(alpha: 0.85),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 8.w,
                bottom: 8.h,
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.hankenGrotesk(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    height: 1.3,
                    color: AppColors.gold50,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SupportVendorsCard extends StatelessWidget {
  const _SupportVendorsCard({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.burgundy50,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: AppColors.burgundy,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.burgundy100, width: 4),
            ),
            alignment: Alignment.center,
            child: SvgPicture.asset(
              IconPath.shopStore,
              width: 16.w,
              height: 16.w,
              colorFilter: const ColorFilter.mode(
                AppColors.burgundy50,
                BlendMode.srcIn,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Support Licensed Vendors',
                  style: GoogleFonts.hankenGrotesk(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    height: 1.3,
                    color: AppColors.burgundy400,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Every purchase supports our Divine 9 community and local businesses.',
                  style: GoogleFonts.hankenGrotesk(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    height: 1.4,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 12.h),
                GestureDetector(
                  onTap: onTap,
                  child: Container(
                    height: 32.h,
                    width: 120.w,
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: AppColors.maroonAccent),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Shop Vendors',
                      style: GoogleFonts.hankenGrotesk(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        height: 1.3,
                        color: AppColors.burgundy400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TrustTicker extends StatelessWidget {
  const _TrustTicker();

  @override
  Widget build(BuildContext context) {
    Widget item(String icon, String label) {
      return Row(
        children: [
          SvgPicture.asset(icon, width: 24.w, height: 24.w),
          SizedBox(width: 6.w),
          Text(
            label,
            style: GoogleFonts.hankenGrotesk(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              height: 1.4,
              color: AppColors.black400,
            ),
          ),
        ],
      );
    }

    return SizedBox(
      height: 24.w,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          item(IconPath.shopLicensed, '100% Officially Licensed'),
          SizedBox(width: 16.w),
          item(IconPath.shopTruck, 'Fast & Reliable Shipping'),
          SizedBox(width: 16.w),
          item(IconPath.shopSupport, 'Dedicated Support'),
          SizedBox(width: 16.w),
          item(IconPath.shopSecure, 'Secure Payment'),
        ],
      ),
    );
  }
}
