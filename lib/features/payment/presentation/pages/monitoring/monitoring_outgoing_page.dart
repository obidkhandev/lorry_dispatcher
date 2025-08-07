import 'package:lorry_dispatcher/core/utills/helper_widget.dart';
import 'package:lorry_dispatcher/export.dart';
import 'package:lorry_dispatcher/features/payment/presentation/pages/balance/widget/balance_item_card.dart';

class MonitoringOutgoingPage extends StatelessWidget {
  const MonitoringOutgoingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
      ).copyWith(top: 20.h, bottom: customButtonPadding),
      itemBuilder: (_, index) {
        return BalanceItemCard(title: "Chiqim\n");
      },
      separatorBuilder: (_, index) {
        return 10.verticalSpace;
      },
      itemCount: 10,
    );
  }
}
