import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lorry_dispatcher/core/utills/helper_widget.dart';
import 'package:lorry_dispatcher/core/utills/widget_extantion.dart';
import 'package:lorry_dispatcher/core/values/app_colors.dart';
import 'package:lorry_dispatcher/core/values/app_text_sytle.dart';
import 'package:lorry_dispatcher/features/common/widget/custom_tab_bar.dart';
import 'package:lorry_dispatcher/features/status/presentation/pages/status/widget/status_inprogress_card.dart';

class OrderInProgressPage extends StatefulWidget {
  const OrderInProgressPage({super.key});

  @override
  State<OrderInProgressPage> createState() => _OrderInProgressPageState();
}

class _OrderInProgressPageState extends State<OrderInProgressPage>
    with TickerProviderStateMixin {
  late TabController tabController;
  int selectedTabIndex = 0;

  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          dividerColor: AppColors.transparent,
          indicatorSize: TabBarIndicatorSize.tab,
          labelStyle: AppTextStyles().body16w4,
          indicator: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(10.r),
          ),
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          indicatorColor: AppColors.primaryColor,
          labelColor: AppColors.white,
          indicatorPadding: EdgeInsets.symmetric(
            vertical: 6.h,
          ),
          controller: tabController,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          tabs: [
            Tab(text: "yetib keldi"),
            Tab(text: "yuklangan"),
            Tab(text: "tushirish uchun yetib keldi"),
            Tab(text: "tushirilgan"),
          ],
        ),
        Expanded(
          child: ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
            ).copyWith(top: 20.h, bottom: customButtonPadding),
            itemBuilder: (_, index) {
              return OrderInprogressCard(status: index + 1);
            },
            separatorBuilder: (_, index) {
              return 12.verticalSpace;
            },
            itemCount: 4,
          ),
        ),
      ],
    );
  }
}
