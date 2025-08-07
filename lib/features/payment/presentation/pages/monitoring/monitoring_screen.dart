import 'package:lorry_dispatcher/export.dart';
import 'package:lorry_dispatcher/features/payment/presentation/pages/monitoring/monitoring_actions_page.dart';
import 'package:lorry_dispatcher/features/payment/presentation/pages/monitoring/monitoring_income_page.dart';
import 'package:lorry_dispatcher/features/payment/presentation/pages/monitoring/monitoring_outgoing_page.dart';

class MonitoringScreen extends StatefulWidget {
  const MonitoringScreen({super.key});

  @override
  State<MonitoringScreen> createState() => _MonitoringScreenState();
}

class _MonitoringScreenState extends State<MonitoringScreen>
    with TickerProviderStateMixin {
  late TabController tabController;

  int selectedTab = 0;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Monitoring",
        toolbarHeight: 100.h,
        rightIcon: AppIcons.filter,
        bottom: CustomTabBar(
          tabController: tabController,
          selectedTabIndex: selectedTab,
          onTabChanged: (v) {
            setState(() {
              selectedTab = v;
            });
          },
          unSelectedTextColor: AppColors.grey600,
          tabTitles: ["Kirim", "Chiqim", "Amallar"],
        ).paddingSymmetric(horizontal: 16.w),
      ),
      body: TabBarView(
        clipBehavior: Clip.none,
        controller: tabController,
        children: [
          MonitoringIncomePage(),
          MonitoringOutgoingPage(),
          MonitoringActionsPage(),
        ],
      ),
    );
  }
}
