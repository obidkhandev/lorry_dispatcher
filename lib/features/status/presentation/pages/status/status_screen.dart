import '../../../../../export.dart';

class StatusScreen extends StatefulWidget {
  const StatusScreen({super.key});

  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen>
    with TickerProviderStateMixin {
  late TabController tabController;
  int selectedTabIndex = 0;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        hasAutoLeading: false,
        toolbarHeight: 100.h,
        title: S.of(context).orders, // Replaced "Buyurtmalar"
        bottom: CustomTabBar(
          tabController: tabController,
          selectedTabIndex: selectedTabIndex,
          onTabChanged: (v) {
            setState(() {
              selectedTabIndex = v;
            });
          },
          tabTitles: [S.of(context).inProgress, S.of(context).completed],
        ).paddingSymmetric(horizontal: 16.w),
      ),
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: tabController,
        children: [OrderInProgressPage(), OrderCompletedPage()],
      ),
    );
  }
}
