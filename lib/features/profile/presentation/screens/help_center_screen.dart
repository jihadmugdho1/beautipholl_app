import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/icon_path.dart';
import '../../../../features/cart/presentation/widgets/cart_gold_button.dart';
import '../../../../routes/app_routes.dart';
import '../../controllers/profile_controller.dart';
import '../../models/profile_models.dart';
import '../widgets/profile_app_bar.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<ProfileController>();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: AppColors.offWhite,
        body: Column(
          children: [
            Obx(
              () => ProfileAppBar(
                title: 'Help Center',
                trailing: c.isElite.value
                    ? Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.gold50,
                          borderRadius: BorderRadius.circular(26.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              IconPath.checkCircle,
                              width: 16.w,
                              height: 16.w,
                              colorFilter: const ColorFilter.mode(
                                AppColors.gold800,
                                BlendMode.srcIn,
                              ),
                            ),
                            SizedBox(width: 6.w),
                            Text(
                              'Priority Support',
                              style: GoogleFonts.hankenGrotesk(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                height: 1.2,
                                color: AppColors.gold800,
                              ),
                            ),
                          ],
                        ),
                      )
                    : null,
                bottom: _HelpSearch(
                  controller: c.helpSearch,
                  hint: 'Search for help...',
                  onChanged: (value) => c.helpQuery.value = value,
                ),
              ),
            ),
            Expanded(
              child: Obx(() {
                final topics = c.filteredTopics;
                final faqs = c.filteredPopular;
                return ListView(
                  padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 32.h),
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _QuickCard(
                            icon: IconPath.helpOrder,
                            title: "Where's my order?",
                            subtitle: 'Track it now',
                            onTap: c.openOrders,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: _QuickCard(
                            icon: IconPath.helpReturn,
                            title: 'Start a Return',
                            subtitle: 'Easy returns',
                            onTap: () => Get.toNamed(AppRoute.returnListScreen),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: _QuickCard(
                            icon: IconPath.helpContact,
                            title: 'Contact Support',
                            subtitle: 'Within 24 hours',
                            onTap: () => c.openTicket(),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),
                    Text(
                      'Browse by Topic',
                      style: GoogleFonts.marcellus(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w400,
                        height: 1.2,
                        color: AppColors.textBody,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14.r),
                        border: Border.all(color: AppColors.black50),
                      ),
                      child: Column(
                        children: [
                          for (var i = 0; i < topics.length; i++)
                            _TopicRow(
                              topic: topics[i],
                              last: i == topics.length - 1,
                              onTap: () => c.openTopic(topics[i]),
                            ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Text(
                      'Popular Questions',
                      style: GoogleFonts.marcellus(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w400,
                        height: 1.2,
                        color: AppColors.textBody,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14.r),
                        border: Border.all(color: AppColors.black50),
                      ),
                      child: Column(
                        children: [
                          for (var i = 0; i < faqs.length; i++)
                            _FaqTile(
                              faq: faqs[i],
                              expanded: c.expandedFaq.value == i,
                              last: i == faqs.length - 1,
                              onTap: () => c.toggleFaq(i),
                            ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),
                    HelpNeedCard(onTap: () => c.openTicket()),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class _HelpSearch extends StatelessWidget {
  const _HelpSearch({
    required this.controller,
    required this.hint,
    required this.onChanged,
  });

  final TextEditingController controller;
  final String hint;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: AppColors.offWhite,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            IconPath.search,
            width: 24.w,
            height: 24.w,
            colorFilter: const ColorFilter.mode(
              AppColors.black400,
              BlendMode.srcIn,
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              cursorColor: AppColors.gold,
              style: GoogleFonts.hankenGrotesk(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                height: 1.6,
                color: AppColors.textBody,
              ),
              decoration: InputDecoration(
                isDense: true,
                isCollapsed: true,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                border: InputBorder.none,
                hintText: hint,
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
    );
  }
}

class _QuickCard extends StatelessWidget {
  const _QuickCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final String icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.all(13.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: AppColors.black50),
        ),
        child: Column(
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: AppColors.maroon50,
                borderRadius: BorderRadius.circular(14.r),
              ),
              alignment: Alignment.center,
              child: SvgPicture.asset(icon, width: 20.w, height: 20.w),
            ),
            SizedBox(height: 8.h),
            Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.hankenGrotesk(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                height: 1.2,
                letterSpacing: -0.42,
                color: AppColors.textBody,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.hankenGrotesk(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                height: 1.4,
                color: AppColors.black400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopicRow extends StatelessWidget {
  const _TopicRow({
    required this.topic,
    required this.last,
    required this.onTap,
  });

  final HelpTopic topic;
  final bool last;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          border: last
              ? null
              : const Border(bottom: BorderSide(color: Color(0xFFF0F0F0))),
        ),
        child: Row(
          children: [
            Container(
              width: 32.w,
              height: 32.w,
              decoration: BoxDecoration(
                color: AppColors.offWhite300,
                borderRadius: BorderRadius.circular(10.r),
              ),
              alignment: Alignment.center,
              child: SvgPicture.asset(topic.icon, width: 16.w, height: 16.w),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                topic.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.hankenGrotesk(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  height: 1.6,
                  color: AppColors.textBody,
                ),
              ),
            ),
            SvgPicture.asset(
              IconPath.helpTopicChevron,
              width: 16.w,
              height: 16.w,
            ),
          ],
        ),
      ),
    );
  }
}

class _FaqTile extends StatelessWidget {
  const _FaqTile({
    required this.faq,
    required this.expanded,
    required this.last,
    required this.onTap,
  });

  final HelpFaq faq;
  final bool expanded;
  final bool last;
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
          border: last
              ? null
              : const Border(bottom: BorderSide(color: Color(0xFFF0F0F0))),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    faq.question,
                    style: GoogleFonts.hankenGrotesk(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      height: 1.6,
                      color: AppColors.textBody,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Padding(
                  padding: EdgeInsets.only(top: 2.h),
                  child: SvgPicture.asset(
                    expanded ? IconPath.helpFaqUp : IconPath.helpFaqDown,
                    width: 16.w,
                    height: 16.w,
                  ),
                ),
              ],
            ),
            if (expanded) ...[
              SizedBox(height: 12.h),
              Container(height: 1, color: AppColors.offWhite),
              SizedBox(height: 12.h),
              Text(
                faq.answer,
                style: GoogleFonts.hankenGrotesk(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                  color: AppColors.black400,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class HelpNeedCard extends StatelessWidget {
  const HelpNeedCard({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.burgundy50,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Row(
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
                  IconPath.helpHeadset,
                  width: 16.w,
                  height: 16.w,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Still need help?',
                      style: GoogleFonts.marcellus(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w400,
                        height: 1.2,
                        color: AppColors.burgundy400,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      "Our support team typically responds within 24 hours. We're here to help.",
                      style: GoogleFonts.hankenGrotesk(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                        color: AppColors.textBody,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          CartGoldButton(label: 'Open a Ticket', onTap: onTap),
        ],
      ),
    );
  }
}
