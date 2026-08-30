import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/icon_path.dart';
import '../../../../core/utils/constants/image_path.dart';
import '../../../../features/authentication/presentation/widgets/auth_input.dart';
import '../../../../features/shop/controllers/shop_controller.dart';
import '../../controllers/profile_controller.dart';
import '../widgets/profile_app_bar.dart';
import '../widgets/profile_avatar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<ProfileController>();

    return ColoredBox(
      color: AppColors.offWhite,
      child: Column(
        children: [
          ProfileAppBar(
            title: 'Profile',
            centerTitle: true,
            onBack: () => Get.find<ShopController>().selectTab(0),
            trailing: GestureDetector(
              onTap: c.openEditProfile,
              behavior: HitTestBehavior.opaque,
              child: SizedBox(
                width: 24.w,
                height: 24.w,
                child: Center(
                  child: SvgPicture.asset(
                    IconPath.profileEdit,
                    width: 20.w,
                    height: 20.w,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
              children: [
                _Identity(controller: c),
                SizedBox(height: 24.h),
                Obx(() {
                  if (c.isElite.value) {
                    return _EliteActiveCard(onTap: c.openMembership);
                  }
                  return _ElitePromoCard(
                    label: c.upgradeLabel,
                    onTap: c.openMembership,
                  );
                }),
                SizedBox(height: 24.h),
                _MenuTile(
                  icon: IconPath.profileOrders,
                  label: 'Orders',
                  onTap: c.openOrders,
                ),
                SizedBox(height: 8.h),
                _MenuTile(
                  icon: IconPath.profileHeart,
                  label: 'Saved Items',
                  onTap: c.openSaved,
                ),
                SizedBox(height: 8.h),
                _MenuTile(
                  icon: IconPath.profileCard,
                  label: 'Payment Methods',
                  onTap: () => showAuthMessage('Payment methods coming next.'),
                ),
                SizedBox(height: 8.h),
                _MenuTile(
                  icon: IconPath.profilePin,
                  label: 'Addresses',
                  onTap: c.openAddresses,
                ),
                SizedBox(height: 8.h),
                _MenuTile(
                  icon: IconPath.profileBell,
                  label: 'Notifications',
                  onTap: c.openNotifications,
                ),
                SizedBox(height: 8.h),
                _MenuTile(
                  icon: IconPath.profileCrown,
                  label: 'Membership',
                  onTap: c.openMembership,
                ),
                SizedBox(height: 8.h),
                _MenuTile(
                  icon: IconPath.profileHelp,
                  label: 'Help Center',
                  onTap: c.openHelp,
                ),
                SizedBox(height: 20.h),
                GestureDetector(
                  onTap: c.logOut,
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 14.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.logoutRed.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          IconPath.profileLogout,
                          width: 20.w,
                          height: 20.w,
                        ),
                        SizedBox(width: 12.w),
                        Text(
                          'Log Out',
                          style: GoogleFonts.hankenGrotesk(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400,
                            height: 1.3,
                            color: AppColors.logoutRed,
                          ),
                        ),
                      ],
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

class _Identity extends StatelessWidget {
  const _Identity({required this.controller});

  final ProfileController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ProfileAvatarView(size: 68.w),
        SizedBox(width: 16.w),
        Expanded(
          child: Obx(() {
            final name = controller.profileName.value;
            final email = controller.profileEmail.value;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.hankenGrotesk(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                    color: AppColors.textBody,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  email,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.hankenGrotesk(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                    color: AppColors.black400,
                  ),
                ),
                SizedBox(height: 2.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: AppColors.gold50,
                    borderRadius: BorderRadius.circular(100.r),
                    border: Border.all(color: AppColors.gold200),
                  ),
                  child: Text(
                    controller.memberBadge,
                    style: GoogleFonts.hankenGrotesk(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                      color: AppColors.goldDeep,
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ],
    );
  }
}

class _ElitePromoCard extends StatelessWidget {
  const _ElitePromoCard({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14.r),
      child: Container(
        width: double.infinity,
        color: AppColors.burgundy,
        constraints: BoxConstraints(minHeight: 194.h),
        child: Stack(
          children: [
            Positioned(
              right: -30.w,
              top: 14.h,
              child: Image.asset(
                ImagePath.eliteEmblem,
                width: 176.w,
                height: 176.w,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.w),
              child: SizedBox(
                width: 249.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 40.w,
                      height: 40.w,
                      decoration: const BoxDecoration(
                        color: AppColors.maroonAccent,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Image.asset(
                        ImagePath.eliteCrown,
                        width: 24.w,
                        height: 24.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      'Join The Yard Elite',
                      style: GoogleFonts.marcellus(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        height: 1.2,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      'Free shipping credits, early access & member discounts',
                      style: GoogleFonts.hankenGrotesk(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                        color: const Color(0xFFC0BEB5),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    GestureDetector(
                      onTap: onTap,
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 8.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.gold,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Text(
                          label,
                          style: GoogleFonts.hankenGrotesk(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            height: 1.2,
                            color: Colors.white,
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
      ),
    );
  }
}

class _EliteActiveCard extends StatelessWidget {
  const _EliteActiveCard({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppColors.burgundy,
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Row(
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              decoration: const BoxDecoration(
                color: AppColors.maroonAccent,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Image.asset(
                ImagePath.eliteCrown,
                width: 24.w,
                height: 24.w,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Elite Member',
                    style: GoogleFonts.hankenGrotesk(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      height: 1.2,
                      color: AppColors.gold300,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'Manage your membership',
                    style: GoogleFonts.hankenGrotesk(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                      color: AppColors.black100,
                    ),
                  ),
                ],
              ),
            ),
            SvgPicture.asset(
              IconPath.profileChevron,
              width: 18.w,
              height: 18.w,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  const _MenuTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final String icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 15.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: AppColors.black50),
        ),
        child: Row(
          children: [
            SvgPicture.asset(icon, width: 20.w, height: 20.w),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.hankenGrotesk(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                  height: 1.3,
                  color: AppColors.textBody,
                ),
              ),
            ),
            SvgPicture.asset(
              IconPath.profileChevron,
              width: 18.w,
              height: 18.w,
            ),
          ],
        ),
      ),
    );
  }
}
