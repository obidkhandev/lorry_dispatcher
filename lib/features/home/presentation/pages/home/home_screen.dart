import 'package:lorry_dispatcher/core/routes/app_routes.dart';
import 'package:lorry_dispatcher/core/values/app_text_sytle.dart';
import 'package:lorry_dispatcher/export.dart';
import 'package:lorry_dispatcher/features/common/widget/custom_app_bar.dart';
import 'package:lorry_dispatcher/features/common/widget/custom_tab_bar.dart';
import 'package:lorry_dispatcher/features/home/presentation/pages/home/widget/drivers_page.dart';
import 'package:lorry_dispatcher/features/status/presentation/pages/status/widget/order_completed_page.dart';
import 'package:lorry_dispatcher/features/home/presentation/pages/home/widget/order_page.dart';
import 'package:lorry_dispatcher/features/home/presentation/part/add_order_bottom_sheet.dart';
import 'package:lorry_dispatcher/generated/l10n.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController tabController;
  int selectedTabIndex = 0;
  List<String> titles = ["Orders", "drivers"];

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            onTap: () {
              context.push(AppRoutes.createOrderScreen);
            },
            paddingV: 0,
            icon: AppIcons.add,
            radius: BorderRadius.circular(30.r),
            text: S.of(context).createOrder, // Replaced "Buyurtma yaratish"
          ),
        ),
      ),
      appBar: CustomAppBar(
        hasAutoLeading: false,
        toolbarHeight: 100.h,
        title: S.of(context).orders, // Replaced "Buyurtmalar"
        bottom: TabBar(
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          controller: tabController,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorColor: AppColors.primaryColor,
          labelColor: AppColors.primaryColor,
          onFocusChange: (v, index) {
            print("Index: $index");
          },
          onTap: (v) {
            setState(() {
              selectedTabIndex = v;
            });
          },
          labelStyle: AppTextStyles().body16w6,
          tabs: List.generate(titles.length, (index) {
            return Tab(text: titles[index]);
          }),
        ),
      ),
      body: TabBarView(
        clipBehavior: Clip.hardEdge,
        physics: NeverScrollableScrollPhysics(),
        controller: tabController,
        children: [OrderPage(), DriversPage()],
      ),
    );
  }
}
