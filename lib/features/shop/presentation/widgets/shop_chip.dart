import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/icon_path.dart';
import '../../../../features/authentication/presentation/widgets/auth_input.dart';

class ShopChip extends StatelessWidget {
  const ShopChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
    this.width,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: 32.h,
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? AppColors.maroonAccent : Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          border: selected ? null : Border.all(color: AppColors.black50),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            label,
            maxLines: 1,
            style: GoogleFonts.hankenGrotesk(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              height: 1.2,
              color: selected ? AppColors.maroon50 : AppColors.black400,
            ),
          ),
        ),
      ),
    );
  }
}

class ShopFilterButton extends StatelessWidget {
  const ShopFilterButton({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => showAuthMessage('Filters coming next.'),
      child: Container(
        padding: EdgeInsets.all(9.w),
        decoration: BoxDecoration(
          color: AppColors.gold50,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: AppColors.gold600),
        ),
        child: SizedBox(
          width: 18.w,
          height: 18.w,
          child: SvgPicture.asset(
            IconPath.shopFilter,
            width: 18.w,
            height: 18.w,
          ),
        ),
      ),
    );
  }
}
