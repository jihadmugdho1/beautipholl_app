import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/icon_path.dart';
import '../../controllers/shop_controller.dart';

class ShopNavBar extends StatelessWidget {
  const ShopNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<ShopController>();

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 4.4,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Obx(() {
            final selected = c.tabIndex.value;
            return Row(
              children: [
                _NavItem(
                  icon: selected == 0
                      ? IconPath.shopHome
                      : IconPath.shopHomeOutline,
                  label: 'Home',
                  selected: selected == 0,
                  onTap: () => c.selectTab(0),
                ),
                _NavItem(
                  icon: selected == 1
                      ? IconPath.shopBagFilled
                      : IconPath.shopBag,
                  label: 'Shop',
                  selected: selected == 1,
                  onTap: () => c.selectTab(1),
                ),
                _NavItem(
                  icon: selected == 2
                      ? IconPath.shopHeartFilled
                      : IconPath.shopHeartNav,
                  label: 'Saved',
                  selected: selected == 2,
                  onTap: () => c.selectTab(2),
                ),
                _NavItem(
                  icon: selected == 3
                      ? IconPath.shopCartFilled
                      : IconPath.shopCartNav,
                  label: 'Cart',
                  selected: selected == 3,
                  onTap: () => c.selectTab(3),
                ),
                _NavItem(
                  icon: selected == 4
                      ? IconPath.shopProfileFilled
                      : IconPath.shopProfile,
                  label: 'Profile',
                  selected: selected == 4,
                  onTap: () => c.selectTab(4),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.maroonAccent : AppColors.black400;

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: selected ? AppColors.maroon50 : Colors.transparent,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 24.w,
                height: 24.w,
                child: SvgPicture.asset(
                  icon,
                  width: 24.w,
                  height: 24.w,
                  fit: BoxFit.contain,
                  colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                ),
              ),
              SizedBox(height: 4.h),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  label,
                  maxLines: 1,
                  style: GoogleFonts.hankenGrotesk(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                    color: color,
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
