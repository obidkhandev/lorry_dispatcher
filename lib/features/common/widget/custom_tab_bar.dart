import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lorry_dispatcher/core/utills/extensions.dart';
import 'package:lorry_dispatcher/core/utills/widget_extantion.dart';
import 'package:lorry_dispatcher/core/values/app_colors.dart';


class CustomTabBar extends StatelessWidget {
  final TabController tabController;
  final int selectedTabIndex;
  final Function(int) onTabChanged;
  final List<String> tabTitles;

  const CustomTabBar({
    super.key,
    required this.tabController,
    required this.selectedTabIndex,
    required this.onTabChanged,
    required this.tabTitles,
  });


  @override
  Widget build(BuildContext context) {
    return TabBar(
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      controller: tabController,
      indicator: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(10.r),
      ),
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorPadding: EdgeInsets.symmetric(
        horizontal: 4.w,
        vertical: 6.h,
      ),
      isScrollable: true,
      tabAlignment: TabAlignment.start,
      indicatorColor: AppColors.primaryColor,
      labelColor: AppColors.primaryColor,
      onTap: onTabChanged,
      tabs: List.generate(tabTitles.length, (index) {
        return Tab(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                tabTitles[index],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.theme.textTheme.titleMedium?.copyWith(
                  color: selectedTabIndex == index
                      ? AppColors.white
                      : AppColors.grey600,
                  fontWeight: FontWeight.w500,
                ),
              ),
              10.horizontalSpace,
              DecoratedBox(
                decoration: BoxDecoration(
                  color: selectedTabIndex == index
                      ? AppColors.primaryOpacity
                      : AppColors.grey200,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  "12",
                  style: context.theme.textTheme.titleSmall?.copyWith(
                    color: selectedTabIndex == index
                        ? AppColors.primaryColor
                        : AppColors.grey808080,
                    fontWeight: FontWeight.w500,
                  ),
                ).paddingAll(4.sp),
              ),
            ],
          ),
        );
      }),
    );
  }
}