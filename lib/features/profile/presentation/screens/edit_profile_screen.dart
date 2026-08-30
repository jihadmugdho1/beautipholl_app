import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/constants/colors.dart';
import '../../../../features/cart/presentation/widgets/cart_gold_button.dart';
import '../../../../features/cart/presentation/widgets/checkout_footer.dart';
import '../../controllers/profile_controller.dart';
import '../widgets/profile_app_bar.dart';
import '../widgets/profile_avatar.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<ProfileController>();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: AppColors.offWhite,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            children: [
              const ProfileAppBar(title: 'Edit Profile', centerTitle: true),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 24.h),
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  children: [
                    Center(
                      child: ProfileAvatarView(
                        size: 96.w,
                        showCamera: true,
                        onTap: c.showPhotoPicker,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    GestureDetector(
                      onTap: c.showPhotoPicker,
                      child: Text(
                        'Change photo',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.hankenGrotesk(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          height: 1.2,
                          color: AppColors.maroonAccent,
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    _Field(controller: c.nameController, hint: 'Full name'),
                    SizedBox(height: 12.h),
                    _Field(
                      controller: c.emailController,
                      hint: 'Email',
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 12.h),
                    _Field(
                      controller: c.phoneController,
                      hint: 'Phone number',
                      keyboardType: TextInputType.phone,
                    ),
                  ],
                ),
              ),
              CheckoutFooter(
                child: CartGoldButton(
                  label: 'Save Changes',
                  onTap: c.saveProfile,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Field extends StatelessWidget {
  const _Field({
    required this.controller,
    required this.hint,
    this.keyboardType,
  });

  final TextEditingController controller;
  final String hint;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 13.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        cursorColor: AppColors.gold,
        style: GoogleFonts.hankenGrotesk(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.textBody,
        ),
        decoration: InputDecoration(
          isDense: true,
          isCollapsed: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          border: InputBorder.none,
          hintText: hint,
          hintStyle: GoogleFonts.hankenGrotesk(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.textBody.withValues(alpha: 0.5),
          ),
        ),
      ),
    );
  }
}
