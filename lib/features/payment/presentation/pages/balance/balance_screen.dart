import 'package:lorry_dispatcher/core/routes/app_routes.dart';
import 'package:lorry_dispatcher/core/utills/helper_widget.dart';
import 'package:lorry_dispatcher/export.dart';
import 'package:lorry_dispatcher/features/payment/presentation/pages/balance/widget/balance_item_card.dart';
import 'package:lorry_dispatcher/features/payment/presentation/pages/balance/widget/balance_status.dart';

class BalanceScreen extends StatelessWidget {
  const BalanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final balanceStatusTitle = ["Jarayonda", "Hamyonda", "To'langan"];

    return Scaffold(
      appBar: CustomAppBar(title: "Balance"),
      body: Column(
        children: [
          40.verticalSpace,
          Text("Jami hisoblangan", style: context.theme.textTheme.titleMedium),
          Text(
            "4 0000",
            style: context.theme.textTheme.titleLarge?.copyWith(
              fontSize: 28.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          20.verticalSpace,
          SizedBox(
            height: 65.h,
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) {
                return BalanceStatus(
                  title: balanceStatusTitle[index],
                  balance: '1 2233',
                  onTap: () {
                    if(index == 1) context.push(AppRoutes.transferScreen);
                    if(index == 2) context.push(AppRoutes.receiptsScreen);
                  },
                );
              },
              separatorBuilder: (_, index) {
                return 10.horizontalSpace;
              },
              itemCount: balanceStatusTitle.length,
            ),
          ),
          20.verticalSpace,
          Row(
            children: [
              Text(
                "To'lovlar tarixi",
                style: context.theme.textTheme.titleMedium,
              ),
              Spacer(),
              TextButton(
                onPressed: () {
                  context.push(AppRoutes.monitoringScreen);
                },
                child: Text(
                  "Hammasi",
                  style: context.theme.textTheme.titleMedium?.copyWith(
                    color: AppColors.brandElectric,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ).paddingOnly(left: 16.w, right: 10.w),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.only(
                top: 10.h,
                bottom: customButtonPadding,
                left: 16.w,
                right: 16.w,
              ),
              shrinkWrap: true,
              itemBuilder: (_, index) {
                return BalanceItemCard();
              },
              separatorBuilder: (_, index) {
                return 10.verticalSpace;
              },
              itemCount: 7,
            ),
          ),
        ],
      ),
    );
  }
}
