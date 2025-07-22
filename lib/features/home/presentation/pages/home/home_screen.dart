import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lorry_dispatcher/core/values/app_colors.dart';
import 'package:lorry_dispatcher/export.dart';
import 'package:lorry_dispatcher/features/common/widget/custom_app_bar.dart';
import 'package:lorry_dispatcher/features/common/widget/custom_tab_bar.dart';
import 'package:lorry_dispatcher/features/home/presentation/pages/home/widget/order_card.dart';
import 'package:lorry_dispatcher/features/home/presentation/pages/home/widget/order_completed_page.dart';
import 'package:lorry_dispatcher/features/home/presentation/pages/home/widget/order_page.dart';
import 'package:lorry_dispatcher/features/home/presentation/pages/home/widget/status_inprogress_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController tabController;
  int selectedTabIndex = 0;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox(
        width: context.w * 0.5,
        child: DecoratedBox(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 0),
                color: AppColors.black.withOpacity(0.2),
                blurRadius: 30.r,
              ),
            ],
          ),
          child: CustomButton(
            height: 40.h,
            paddingV: 0,
            icon: AppIcons.add,
            radius: BorderRadius.circular(30.r),
            text: "Buyurtma yaratish",
          ),
        ),
      ),
      appBar: CustomAppBar(
        toolbarHeight: 100.h,
        title: "Buyurtmalar",
        bottom: CustomTabBar(

          tabController: tabController,
          selectedTabIndex: selectedTabIndex,
          onTabChanged: (v) {
            setState(() {
              selectedTabIndex = v;
            });
          },
          tabTitles: ["Buyurtmalar", "Jarayonda", "Bajarilgan"],
        ).paddingSymmetric(horizontal: 16.w),
      ),
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: tabController,
        children: [OrderPage(), OrderInProgressPage(), OrderCompletedPage()],
      ),
    );
  }
}
