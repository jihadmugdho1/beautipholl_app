import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/services/storage_service.dart';
import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/icon_path.dart';
import '../../../../core/utils/constants/image_path.dart';
import '../../../../features/authentication/presentation/widgets/auth_input.dart';
import '../../../../routes/app_routes.dart';
import '../../controllers/product_controller.dart';
import '../../controllers/shop_controller.dart';
import '../../models/product_model.dart';
import '../widgets/product_card.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<ProductController>();
    final shop = Get.find<ShopController>();
    final thumbs = [
      ImagePath.shopProductHero,
      ImagePath.shopThumb1,
      ImagePath.shopThumb2,
      ImagePath.shopThumb3,
    ];

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.white,
      ),
      child: Scaffold(
        backgroundColor: AppColors.offWhite,
        body: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(child: _Gallery(thumbs: thumbs)),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 100.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _InfoCard(controller: c, shop: shop),
                          SizedBox(height: 12.h),
                          _OptionsCard(controller: c),
                          SizedBox(height: 12.h),
                          const _ConditionCard(),
                          SizedBox(height: 12.h),
                          _SizeGuideCard(controller: c),
                          SizedBox(height: 12.h),
                          const _TimeCard(
                            icon: IconPath.shopClock,
                            title: 'Production Time',
                            body:
                                '4 business days — made specifically for your order',
                            gold: true,
                          ),
                          SizedBox(height: 12.h),
                          const _TimeCard(
                            icon: IconPath.shopShip,
                            title: 'Shipping Time',
                            body:
                                'Delivered in 3–5 business days after production',
                            footnote: 'Ships from Atlanta, GA · Standard \$5.99',
                          ),
                          SizedBox(height: 12.h),
                          const _CustomizationCard(),
                          SizedBox(height: 12.h),
                          _FaqCard(controller: c),
                          SizedBox(height: 12.h),
                          const _DescriptionCard(),
                          SizedBox(height: 12.h),
                          const _ShippingReturnsCard(),
                          SizedBox(height: 12.h),
                          const _ReviewsCard(),
                          SizedBox(height: 24.h),
                          Text(
                            'Related Products',
                            style: GoogleFonts.marcellus(
                              fontSize: 20.sp,
                              height: 1.2,
                              color: AppColors.textBody,
                            ),
                          ),
                          SizedBox(height: 12.h),
                          SizedBox(
                            height: 288.h,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.only(bottom: 4.h),
                              children: [
                                ProductCard(product: ShopCatalog.products[0]),
                                SizedBox(width: 8.w),
                                ProductCard(product: ShopCatalog.products[1]),
                                SizedBox(width: 8.w),
                                ProductCard(product: ShopCatalog.products[0]),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _AddToCartBar(onAdd: shop.addToCart),
          ],
        ),
      ),
    );
  }
}

class _Gallery extends StatelessWidget {
  const _Gallery({required this.thumbs});

  final List<String> thumbs;

  @override
  Widget build(BuildContext context) {
    final c = Get.find<ProductController>();
    final shop = Get.find<ShopController>();

    return Column(
      children: [
        SizedBox(
          height: 340.h,
          width: double.infinity,
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.topCenter,
            children: [
              Obx(
                () => Image.asset(
                  thumbs[c.selectedThumb.value.clamp(0, thumbs.length - 1)],
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 44.h,
                left: 16.w,
                right: 16.w,
                child: Row(
                  children: [
                    _RoundIcon(
                      icon: IconPath.shopBack,
                      onTap: Get.back,
                    ),
                    const Spacer(),
                    Obx(() {
                      final id = c.productId.value;
                      final saved = shop.savedIds.contains(id);
                      return _RoundIcon(
                        icon: saved
                            ? IconPath.shopHeartFilled
                            : IconPath.shopHeart,
                        color: saved ? AppColors.maroonAccent : null,
                        onTap: () => shop.toggleSaved(id),
                      );
                    }),
                    SizedBox(width: 8.w),
                    _RoundIcon(
                      icon: IconPath.shopShare,
                      onTap: () => showAuthMessage('Share link copied.'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Obx(() {
            return Row(
              children: List.generate(thumbs.length, (index) {
                final selected = c.selectedThumb.value == index;
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: index == thumbs.length - 1 ? 0 : 8.w,
                    ),
                    child: GestureDetector(
                      onTap: () => c.selectThumb(index),
                      child: Container(
                        height: 81.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          border: selected
                              ? Border.all(
                                  color: AppColors.maroonAccent,
                                  width: 1.5,
                                )
                              : null,
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Image.asset(thumbs[index], fit: BoxFit.cover),
                      ),
                    ),
                  ),
                );
              }),
            );
          }),
        ),
      ],
    );
  }
}

class _RoundIcon extends StatelessWidget {
  const _RoundIcon({
    required this.icon,
    required this.onTap,
    this.color,
  });

  final String icon;
  final VoidCallback onTap;
  final Color? color;

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
        child: SizedBox(
          width: 20.w,
          height: 20.w,
          child: SvgPicture.asset(
            icon,
            fit: BoxFit.contain,
            colorFilter: ColorFilter.mode(
              color ?? const Color(0xFF1E1E1E),
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.controller, required this.shop});

  final ProductController controller;
  final ShopController shop;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Purple & Gold Crewneck Sweatshirt',
            style: GoogleFonts.marcellus(
              fontSize: 24.sp,
              height: 1.2,
              color: AppColors.textBody,
            ),
          ),
          SizedBox(height: 12.h),
          GestureDetector(
            onTap: shop.openVendor,
            child: Container(
              constraints: BoxConstraints(minHeight: 40.h),
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: AppColors.burgundy50,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                children: [
                  Container(
                    width: 24.w,
                    height: 24.w,
                    decoration: const BoxDecoration(
                      color: AppColors.maroonDark,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 16.w,
                      height: 16.w,
                      child: SvgPicture.asset(
                        IconPath.shopStorefront,
                        fit: BoxFit.contain,
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      'The Fabric Haven',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                        letterSpacing: -0.28,
                        decoration: TextDecoration.underline,
                        color: AppColors.maroonAccent,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  SizedBox(
                    width: 16.w,
                    height: 16.w,
                    child: SvgPicture.asset(
                      IconPath.shopStarRate,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    '4.2',
                    style: GoogleFonts.hankenGrotesk(
                      fontSize: 12.sp,
                      height: 1.4,
                      color: const Color(0xFF484848),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 12.h),
          GestureDetector(
            onTap: shop.openContactVendor,
            child: Row(
              children: [
                SizedBox(
                  width: 24.w,
                  height: 24.w,
                  child: SvgPicture.asset(
                    IconPath.shopMessage,
                    fit: BoxFit.contain,
                  ),
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
          SizedBox(height: 12.h),
          Container(
            padding: EdgeInsets.only(bottom: 8.h),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: AppColors.black50)),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: AppColors.textBody,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    shop.orgLetters,
                    style: GoogleFonts.hankenGrotesk(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      height: 1.2,
                      letterSpacing: -0.36,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Flexible(
                  child: Text(
                    StorageService.organizationName ?? 'Alpha Phi Alpha',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.hankenGrotesk(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      height: 1.2,
                      letterSpacing: -0.36,
                      color: AppColors.black300,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Text(
                        '\$58.00',
                        style: GoogleFonts.marcellus(
                          fontSize: 32.sp,
                          height: 1.2,
                          color: AppColors.maroonAccent,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Text(
                        '\$70.00',
                        style: GoogleFonts.hankenGrotesk(
                          fontSize: 16.sp,
                          height: 1.6,
                          decoration: TextDecoration.lineThrough,
                          color: AppColors.black300,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: AppColors.successGreen.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  'Save 18%',
                  style: GoogleFonts.hankenGrotesk(
                    fontSize: 12.sp,
                    height: 1.2,
                    color: AppColors.successGreen,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Obx(() {
            return Row(
              children: [
                if (controller.isElite.value) ...[
                  SizedBox(
                    width: 14.w,
                    height: 14.w,
                    child: SvgPicture.asset(
                      IconPath.shopTick,
                      fit: BoxFit.contain,
                      colorFilter: const ColorFilter.mode(
                        AppColors.gold600,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  SizedBox(width: 4.w),
                ],
                Expanded(
                  child: Text(
                    'Member price: \$50.00',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.hankenGrotesk(
                      fontSize: 14.sp,
                      height: 1.5,
                      color: AppColors.black400,
                    ),
                  ),
                ),
                if (!controller.isElite.value)
                  GestureDetector(
                    onTap: () => Get.toNamed(AppRoute.eliteJoinScreen),
                    child: Text(
                      'Join Elite',
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        height: 1.5,
                        letterSpacing: -0.28,
                        decoration: TextDecoration.underline,
                        color: AppColors.maroonAccent,
                      ),
                    ),
                  ),
              ],
            );
          }),
        ],
      ),
    );
  }
}

class _OptionsCard extends StatelessWidget {
  const _OptionsCard({required this.controller});

  final ProductController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Color:',
            style: GoogleFonts.hankenGrotesk(
              fontSize: 14.sp,
              height: 1.5,
              color: AppColors.textBody,
            ),
          ),
          SizedBox(height: 8.h),
          Obx(() {
            return Row(
              children: List.generate(ProductController.colors.length, (i) {
                final selected = controller.selectedColor.value == i;
                return Padding(
                  padding: EdgeInsets.only(right: 6.w),
                  child: GestureDetector(
                    onTap: () => controller.selectColor(i),
                    child: Container(
                      width: 24.w,
                      height: 24.w,
                      alignment: Alignment.center,
                      child: Container(
                        width: selected ? 24.w : 20.w,
                        height: selected ? 24.w : 20.w,
                        decoration: BoxDecoration(
                          color: Color(ProductController.colors[i].value),
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: selected
                            ? SizedBox(
                                width: 10.w,
                                height: 10.w,
                                child: SvgPicture.asset(
                                  IconPath.shopTick,
                                  fit: BoxFit.contain,
                                  colorFilter: const ColorFilter.mode(
                                    Colors.white,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              )
                            : null,
                      ),
                    ),
                  ),
                );
              }),
            );
          }),
          Padding(
            padding: EdgeInsets.only(top: 12.h, bottom: 12.h),
            child: const Divider(height: 1, color: AppColors.black50),
          ),
          Text(
            'Select Size:',
            style: GoogleFonts.hankenGrotesk(
              fontSize: 14.sp,
              height: 1.5,
              color: AppColors.textBody,
            ),
          ),
          SizedBox(height: 8.h),
          Obx(() {
            return Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: ProductController.sizes.map((size) {
                final selected = controller.selectedSize.value == size;
                return GestureDetector(
                  onTap: () => controller.selectSize(size),
                  child: Container(
                    constraints: BoxConstraints(minWidth: 48.w, minHeight: 36.h),
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 8.h,
                    ),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: selected
                          ? AppColors.maroonAccent
                          : AppColors.offWhite,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(
                        color: selected
                            ? AppColors.maroonAccent
                            : AppColors.black50,
                      ),
                    ),
                    child: Text(
                      size,
                      style: GoogleFonts.hankenGrotesk(
                        fontSize: 14.sp,
                        height: 1.3,
                        fontWeight:
                            selected ? FontWeight.w600 : FontWeight.w400,
                        color: selected
                            ? Colors.white
                            : AppColors.maroon950,
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          }),
          Padding(
            padding: EdgeInsets.only(top: 12.h, bottom: 12.h),
            child: const Divider(height: 1, color: AppColors.black50),
          ),
          Row(
            children: [
              Text(
                'Quantity:',
                style: GoogleFonts.hankenGrotesk(
                  fontSize: 14.sp,
                  height: 1.5,
                  color: AppColors.textBody,
                ),
              ),
              const Spacer(),
              Container(
                width: 159.w,
                height: 42.h,
                padding: EdgeInsets.symmetric(horizontal: 9.w),
                decoration: BoxDecoration(
                  color: AppColors.offWhite400,
                  borderRadius: BorderRadius.circular(24.r),
                  border: Border.all(color: AppColors.black100),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: controller.decrementQty,
                      behavior: HitTestBehavior.opaque,
                      child: SizedBox(
                        width: 32.w,
                        height: 32.w,
                        child: Center(
                          child: SizedBox(
                            width: 14.w,
                            height: 14.w,
                            child: SvgPicture.asset(
                              IconPath.shopMinus,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Obx(
                      () => Text(
                        '${controller.quantity.value}',
                        style: GoogleFonts.hankenGrotesk(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          height: 1.2,
                          color: AppColors.textBody,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: controller.incrementQty,
                      behavior: HitTestBehavior.opaque,
                      child: SizedBox(
                        width: 32.w,
                        height: 32.w,
                        child: Center(
                          child: SizedBox(
                            width: 14.w,
                            height: 14.w,
                            child: SvgPicture.asset(
                              IconPath.shopPlus,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ConditionCard extends StatelessWidget {
  const _ConditionCard();

  @override
  Widget build(BuildContext context) {
    return _WhiteCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: 14.w,
                height: 14.w,
                child: SvgPicture.asset(
                  IconPath.shopShirt,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  'Condition & Production',
                  style: GoogleFonts.hankenGrotesk(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    height: 1.3,
                    color: AppColors.textBody,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          _kv('Condition', 'New / Made to Order'),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: const Divider(height: 1, color: AppColors.black50),
          ),
          _kv('Production', 'Ships in 4 days'),
          SizedBox(height: 8.h),
          Text(
            'Made specifically for your order. Each piece is crafted after purchase.',
            style: GoogleFonts.hankenGrotesk(
              fontSize: 12.sp,
              height: 1.5,
              color: AppColors.black300,
            ),
          ),
        ],
      ),
    );
  }

  Widget _kv(String k, String v) {
    return Row(
      children: [
        Text(
          k,
          style: GoogleFonts.hankenGrotesk(
            fontSize: 12.sp,
            height: 1.5,
            color: AppColors.black300,
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            v,
            textAlign: TextAlign.right,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.hankenGrotesk(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              height: 1.5,
              color: AppColors.textBody,
            ),
          ),
        ),
      ],
    );
  }
}

class _SizeGuideCard extends StatelessWidget {
  const _SizeGuideCard({required this.controller});

  final ProductController controller;

  @override
  Widget build(BuildContext context) {
    return _WhiteCard(
      bordered: true,
      child: Column(
        children: [
          GestureDetector(
            onTap: controller.toggleSizeGuide,
            child: Row(
              children: [
                SizedBox(
                  width: 14.w,
                  height: 14.w,
                  child: SvgPicture.asset(
                    IconPath.shopRuler,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    'Size Guide',
                    style: GoogleFonts.hankenGrotesk(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textBody,
                    ),
                  ),
                ),
                Obx(
                  () => Transform.rotate(
                    angle: controller.sizeGuideOpen.value ? 0 : 3.14159,
                    child: SizedBox(
                      width: 16.w,
                      height: 16.w,
                      child: SvgPicture.asset(
                        IconPath.shopChevronUp,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Obx(() {
            if (!controller.sizeGuideOpen.value) {
              return const SizedBox.shrink();
            }
            return Column(
              children: [
                SizedBox(height: 12.h),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.black50),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Column(
                    children: [
                      _sizeRow(['Size', 'Chest (in)', 'Length (in)'], header: true),
                      ...ProductController.sizeRows.map(
                        (row) => _sizeRow(row, highlight: row[0] == 'M'),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Measurements in inches. Model is 6\'0" and wears size M.',
                    style: GoogleFonts.hankenGrotesk(
                      fontSize: 12.sp,
                      height: 1.5,
                      color: AppColors.black300,
                    ),
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _sizeRow(List<String> cells, {bool header = false, bool highlight = false}) {
    return Container(
      decoration: BoxDecoration(
        color: highlight
            ? AppColors.gold50
            : header
                ? AppColors.offWhite
                : Colors.white,
        border: const Border(bottom: BorderSide(color: AppColors.black50)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: header ? 8.h : 10.h),
      child: Row(
        children: List.generate(3, (i) {
          return Expanded(
            child: Text(
              cells[i],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.hankenGrotesk(
                fontSize: header ? 12.sp : 13.sp,
                fontWeight: header || (highlight && i == 0)
                    ? FontWeight.w600
                    : FontWeight.w400,
                color: highlight && i == 0
                    ? AppColors.maroonAccent
                    : i == 0 || header
                        ? AppColors.textBody
                        : AppColors.black400,
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _TimeCard extends StatelessWidget {
  const _TimeCard({
    required this.icon,
    required this.title,
    required this.body,
    this.footnote,
    this.gold = false,
  });

  final String icon;
  final String title;
  final String body;
  final String? footnote;
  final bool gold;

  @override
  Widget build(BuildContext context) {
    return _WhiteCard(
      bordered: true,
      child: Row(
        children: [
          Container(
            width: 36.w,
            height: 36.w,
            decoration: BoxDecoration(
              color: gold ? AppColors.gold50 : AppColors.offWhite,
              borderRadius: BorderRadius.circular(10.r),
              border: gold ? null : Border.all(color: AppColors.black50),
            ),
            alignment: Alignment.center,
            child: SizedBox(
              width: 16.w,
              height: 16.w,
              child: SvgPicture.asset(icon, fit: BoxFit.contain),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.hankenGrotesk(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textBody,
                  ),
                ),
                Text(
                  body,
                  style: GoogleFonts.hankenGrotesk(
                    fontSize: 13.sp,
                    height: 1.6,
                    color: AppColors.black400,
                  ),
                ),
                if (footnote != null)
                  Text(
                    footnote!,
                    style: GoogleFonts.hankenGrotesk(
                      fontSize: 12.sp,
                      height: 1.5,
                      color: AppColors.black300,
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

class _CustomizationCard extends StatelessWidget {
  const _CustomizationCard();

  @override
  Widget build(BuildContext context) {
    const items = [
      ['Monogramming', ' — Add initials or name (up to 8 characters)'],
      ['Chapter Name', ' — Print your chapter city/state on the sleeve'],
      ['Line Number', ' — Add your line number below chapter seal'],
      ['Size Adjustments', ' — Tailored fit available (+\$8.00)'],
    ];

    return _WhiteCard(
      bordered: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: 14.w,
                height: 14.w,
                child: SvgPicture.asset(
                  IconPath.shopCustom,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  'Customization Options',
                  style: GoogleFonts.hankenGrotesk(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textBody,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          ...items.map(
            (item) => Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 6.h),
                    child: Container(
                      width: 5.w,
                      height: 5.w,
                      decoration: const BoxDecoration(
                        color: AppColors.maroonAccent,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: item[0],
                            style: GoogleFonts.hankenGrotesk(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textBody,
                            ),
                          ),
                          TextSpan(
                            text: item[1],
                            style: GoogleFonts.hankenGrotesk(
                              fontSize: 12.sp,
                              color: AppColors.black300,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Text(
            'Select customization details after adding to cart, or contact the vendor for complex requests.',
            style: GoogleFonts.hankenGrotesk(
              fontSize: 12.sp,
              height: 1.5,
              color: AppColors.black300,
            ),
          ),
        ],
      ),
    );
  }
}

class _FaqCard extends StatelessWidget {
  const _FaqCard({required this.controller});

  final ProductController controller;

  @override
  Widget build(BuildContext context) {
    return _WhiteCard(
      bordered: true,
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 14.w,
                height: 14.w,
                child: SvgPicture.asset(
                  IconPath.shopFaq,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  'Frequently Asked Questions',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.hankenGrotesk(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textBody,
                  ),
                ),
              ),
            ],
          ),
          ...List.generate(ProductController.faqs.length, (i) {
            return Container(
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: AppColors.black50)),
              ),
              child: Obx(() {
                final open = controller.expandedFaq.value == i;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => controller.toggleFaq(i),
                      behavior: HitTestBehavior.opaque,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                ProductController.faqs[i].$1,
                                style: GoogleFonts.hankenGrotesk(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                  height: 1.4,
                                  color: AppColors.textBody,
                                ),
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Transform.rotate(
                              angle: open ? 3.14159 : 0,
                              child: SizedBox(
                                width: 15.w,
                                height: 15.w,
                                child: SvgPicture.asset(
                                  IconPath.shopFaqChevron,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (open)
                      Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: Text(
                          ProductController.faqs[i].$2,
                          style: GoogleFonts.hankenGrotesk(
                            fontSize: 13.sp,
                            height: 1.5,
                            color: AppColors.black400,
                          ),
                        ),
                      ),
                  ],
                );
              }),
            );
          }),
        ],
      ),
    );
  }
}

class _DescriptionCard extends StatelessWidget {
  const _DescriptionCard();

  @override
  Widget build(BuildContext context) {
    return _WhiteCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Description',
            style: GoogleFonts.marcellus(
              fontSize: 20.sp,
              height: 1.2,
              color: AppColors.textBody,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Official licensed Omega Psi Phi crewneck sweatshirt. Made from 80% cotton / 20% polyester blend. Features embroidered Greek letters and chapter seal on chest.',
            style: GoogleFonts.hankenGrotesk(
              fontSize: 14.sp,
              height: 1.5,
              color: AppColors.black400,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            'Materials & Specifications',
            style: GoogleFonts.hankenGrotesk(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.textBody,
            ),
          ),
          ...const [
            '100% Satin Nylon Shell',
            'Polyester filling',
            '80% Cotton / 20% Polyester',
            'Machine wash cold, inside out',
          ].map(_bullet),
          SizedBox(height: 8.h),
          Text(
            'Care Instructions',
            style: GoogleFonts.hankenGrotesk(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.textBody,
            ),
          ),
          ...const [
            'Dry clean or spot clean',
            'Do not iron over embroidery',
            'Do not bleach',
            'Tumble dry low',
          ].map(_bullet),
        ],
      ),
    );
  }

  Widget _bullet(String text) {
    return Padding(
      padding: EdgeInsets.only(left: 12.w, top: 2.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '•  ',
            style: GoogleFonts.hankenGrotesk(
              fontSize: 14.sp,
              height: 1.5,
              color: AppColors.black400,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.hankenGrotesk(
                fontSize: 14.sp,
                height: 1.5,
                color: AppColors.black400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ShippingReturnsCard extends StatelessWidget {
  const _ShippingReturnsCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(25.w),
      decoration: BoxDecoration(
        color: AppColors.burgundy,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0x339B8D8D)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 22.w,
                height: 22.w,
                child: SvgPicture.asset(
                  IconPath.shopShipFrom,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ships from Atlanta, GA',
                      style: GoogleFonts.hankenGrotesk(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.7,
                        color: const Color(0xFFE4E2DD),
                      ),
                    ),
                    Text(
                      'Standard \$5.99 • Free over \$150',
                      style: GoogleFonts.hankenGrotesk(
                        fontSize: 12.sp,
                        color: const Color(0xFFD3C3C3),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: const Divider(color: Color(0x334F4444)),
          ),
          Row(
            children: [
              SizedBox(
                width: 22.w,
                height: 22.w,
                child: SvgPicture.asset(
                  IconPath.shopReturns,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Free returns within 30 days',
                      style: GoogleFonts.hankenGrotesk(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.7,
                        color: const Color(0xFFE4E2DD),
                      ),
                    ),
                    Text(
                      'Hassle-free legacy exchanges',
                      style: GoogleFonts.hankenGrotesk(
                        fontSize: 12.sp,
                        color: const Color(0xFFD3C3C3),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ReviewsCard extends StatelessWidget {
  const _ReviewsCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Reviews',
                style: GoogleFonts.marcellus(
                  fontSize: 20.sp,
                  height: 1.2,
                  color: AppColors.textBody,
                ),
              ),
              SizedBox(width: 8.w),
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.gold50,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: AppColors.gold200),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 12.w,
                          height: 12.w,
                          child: SvgPicture.asset(
                            IconPath.shopStar,
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '4.8',
                                style: GoogleFonts.hankenGrotesk(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.gold,
                                ),
                              ),
                              TextSpan(
                                text: ' (292)',
                                style: GoogleFonts.hankenGrotesk(
                                  fontSize: 12.sp,
                                  color: AppColors.black300,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                'View All',
                style: GoogleFonts.hankenGrotesk(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                  color: AppColors.maroonAccent,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          SizedBox(
            height: 200.h,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                _ReviewTile(),
                SizedBox(width: 8),
                _ReviewTile(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ReviewTile extends StatelessWidget {
  const _ReviewTile();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 311.w,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.offWhite400,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Samantha D.',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.hankenGrotesk(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textBody,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              SizedBox(
                width: 98.w,
                height: 16.h,
                child: SvgPicture.asset(
                  IconPath.shopReviewStars,
                  fit: BoxFit.contain,
                  alignment: Alignment.centerRight,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            '"These earbuds are fantastic! The sound quality is crystal clear, and they fit snugly in my ears. I love how they block out background noise, making my music experience immersive. Plus, the battery life is impressive!"',
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.hankenGrotesk(
              fontSize: 14.sp,
              height: 1.5,
              color: AppColors.textBody,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'August 14, 2023',
            style: GoogleFonts.hankenGrotesk(
              fontSize: 12.sp,
              height: 1.4,
              color: AppColors.black300,
            ),
          ),
        ],
      ),
    );
  }
}

class _AddToCartBar extends StatelessWidget {
  const _AddToCartBar({required this.onAdd});

  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.black50)),
      ),
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 12.h),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Total',
                  style: GoogleFonts.hankenGrotesk(
                    fontSize: 12.sp,
                    height: 1.4,
                    color: AppColors.black300,
                  ),
                ),
                Text(
                  '\$58.00',
                  style: GoogleFonts.marcellus(
                    fontSize: 24.sp,
                    height: 1.2,
                    color: AppColors.textBody,
                  ),
                ),
              ],
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 197.w),
                  child: GestureDetector(
                    onTap: onAdd,
                    child: Container(
                      width: double.infinity,
                      height: 48.h,
                      decoration: BoxDecoration(
                        color: AppColors.gold,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 24.w,
                            height: 24.w,
                            child: SvgPicture.asset(
                              IconPath.shopCart,
                              fit: BoxFit.contain,
                              colorFilter: const ColorFilter.mode(
                                AppColors.burgundy,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Flexible(
                            child: Text(
                              'Add To Cart',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.hankenGrotesk(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                height: 1.2,
                                color: AppColors.burgundy,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WhiteCard extends StatelessWidget {
  const _WhiteCard({required this.child, this.bordered = false});

  final Widget child;
  final bool bordered;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(13.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: bordered ? Border.all(color: AppColors.black50) : null,
      ),
      child: child,
    );
  }
}
