import 'package:lorry_dispatcher/export.dart';
import 'package:lorry_dispatcher/features/payment/presentation/pages/receipts/widget/receipts_item_card.dart';

class ReceiptsScreen extends StatelessWidget {
  const ReceiptsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "ReceiptsScreen"),
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: DecoratedBox(
              decoration: AppDecoration.cardDecoration(context).copyWith(
                borderRadius: BorderRadius.circular(20.r),
                // boxShadow: [],
              ),
              child: Column(
                children: [
                  Text(
                    "Kartaga o'tkazilgan pul miqdori:",
                    style: context.theme.textTheme.titleMedium,
                  ),
                  Text(
                    "2 2222",
                    style: context.theme.textTheme.titleLarge?.copyWith(
                      color: AppColors.brandElectric,
                    ),
                  ),
                ],
              ).paddingAll(10.sp),
            ).paddingOnly(top: 20.h, left: 16.w, right: 16.w, bottom: 20.h),
          ),
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              itemBuilder: (_, index) {
                return ReceiptsItemCard(
                  title: "O'tkazma muvaffaqiyatli",
                  amount: "238 727.49 so'm",
                  date: "17.07.2025 13:30:40",
                  cardNumber: "6262********3751",
                );
              },
              separatorBuilder: (_, index) {
                return 10.verticalSpace;
              },
              itemCount: 3,
            ),
          ),
        ],
      ),
    );
  }
}
