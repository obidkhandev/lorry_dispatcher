import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lorry_dispatcher/core/utills/helper_widget.dart';
import 'package:lorry_dispatcher/features/payment/presentation/pages/balance/widget/balance_item_card.dart';

class MonitoringIncomePage extends StatelessWidget {
  const MonitoringIncomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
      ).copyWith(top: 20.h, bottom: customButtonPadding),
      itemBuilder: (_, index) {
        return BalanceItemCard(
          isIncome: true,
        );
      },
      separatorBuilder: (_, index) {
        return 10.verticalSpace;
      },
      itemCount: 10,
    );
  }
}
