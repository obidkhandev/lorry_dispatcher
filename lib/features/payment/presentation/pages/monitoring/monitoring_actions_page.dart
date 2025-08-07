import 'package:lorry_dispatcher/core/utills/helper_widget.dart';
import 'package:lorry_dispatcher/export.dart';
import 'package:lorry_dispatcher/features/payment/presentation/pages/balance/widget/balance_item_card.dart';

class MonitoringActionsPage extends StatelessWidget {
  const MonitoringActionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
      ).copyWith(top: 20.h, bottom: customButtonPadding),
      itemBuilder: (_, index) {
        return BalanceItemCard(
          title: index % 2 == 0 ? "Kirim\n" : "Chiqim\n",
          isIncome: index % 2 == 0,
        );
      },
      separatorBuilder: (_, index) {
        return 10.verticalSpace;
      },
      itemCount: 20,
    );
  }
}
