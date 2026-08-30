import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/icon_path.dart';
import '../../controllers/profile_controller.dart';
import '../../models/profile_models.dart';
import '../widgets/profile_app_bar.dart';
import 'help_center_screen.dart';

class HelpTopicScreen extends StatelessWidget {
  const HelpTopicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<ProfileController>();
    final topic = Get.arguments as HelpTopic? ?? ProfileController.topics.first;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: AppColors.offWhite,
        body: Column(
          children: [
            ProfileAppBar(
              title: topic.title,
              bottom: _TopicSearch(
                controller: c.topicSearch,
                hint: topic.searchHint,
                onChanged: (value) => c.topicQuery.value = value,
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 32.h),
                children: [
                  Obx(() {
                    final query = c.topicQuery.value.trim().toLowerCase();
                    final faqs = query.isEmpty
                        ? topic.faqs
                        : topic.faqs
                              .where(
                                (faq) =>
                                    faq.question.toLowerCase().contains(
                                      query,
                                    ) ||
                                    faq.answer.toLowerCase().contains(query),
                              )
                              .toList();
                    return Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14.r),
                        border: Border.all(color: AppColors.black50),
                      ),
                      child: Column(
                        children: [
                          for (var i = 0; i < faqs.length; i++)
                            _TopicFaq(
                              faq: faqs[i],
                              expanded: c.topicExpanded.value == i,
                              last: i == faqs.length - 1,
                              onTap: () => c.toggleTopicFaq(i),
                            ),
                        ],
                      ),
                    );
                  }),
                  SizedBox(height: 24.h),
                  HelpNeedCard(
                    onTap: () => c.openTicket(regarding: topic.title),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopicSearch extends StatelessWidget {
  const _TopicSearch({
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

class _TopicFaq extends StatelessWidget {
  const _TopicFaq({
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
