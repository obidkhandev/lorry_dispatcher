import 'package:lorry_dispatcher/features/home/presentation/pages/home/widget/driver_busy_card.dart';
import 'package:lorry_dispatcher/features/home/presentation/pages/home/widget/driver_jobless_card.dart';
import 'package:lorry_dispatcher/features/home/presentation/pages/home/widget/driver_underrapair_card.dart';
import 'package:lorry_dispatcher/features/home/presentation/pages/home/widget/drivers_listview.dart';
import 'package:lorry_dispatcher/features/home/presentation/part/send_offer_bottom_sheet.dart';
import 'package:lorry_dispatcher/export.dart';

class DriversPage extends StatefulWidget {
  const DriversPage({super.key});

  @override
  State<DriversPage> createState() => _DriversPageState();
}

class _DriversPageState extends State<DriversPage> with TickerProviderStateMixin {
  late TabController tabController;
  int selectedTabIndex = 0;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        20.verticalSpace,
        DecoratedBox(
          decoration: BoxDecoration(
            color: context.theme.cardColor,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 0),
                blurRadius: 10.r,
                color: AppColors.black.withOpacity(0.1),
              ),
            ],
          ),
          child: CustomTabBar(
            tabController: tabController,
            selectedTabIndex: selectedTabIndex,
            onTabChanged: (v) {
              setState(() {
                selectedTabIndex = v;
              });
            },
            tabTitles: [
              S.of(context).jobless, // Localized "Available"
              S.of(context).busy, // Localized "Busy"
              S.of(context).underRepair, // Localized "Under Repair"
            ],
          ),
        ).paddingSymmetric(horizontal: 16.w),
        Expanded(
          child: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            controller: tabController,
            children: [
              DriversListview(
                card: DriverJoblessCard(
                  isActive: true,
                  onTap: () {
                    showSendOfferBottomSheet(context);
                  },
                ),
              ),
              DriversListview(card: DriverBusyCard()),
              DriversListview(card: DriverUnderrapairCard()),
            ],
          ),
        ),
      ],
    );
  }
}