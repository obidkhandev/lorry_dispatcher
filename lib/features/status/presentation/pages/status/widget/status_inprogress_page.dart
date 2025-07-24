import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lorry_dispatcher/core/utills/helper_widget.dart';
import 'package:lorry_dispatcher/features/status/presentation/pages/status/widget/status_inprogress_card.dart';

class OrderInProgressPage extends StatelessWidget {
  const OrderInProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      clipBehavior: Clip.none,
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
      ).copyWith(top: 20.h, bottom: customButtonPadding + 20),
      itemBuilder: (_, index) {
        return OrderInprogressCard(status: index + 1);
      },
      separatorBuilder: (_, index) {
        return 12.verticalSpace;
      },
      itemCount: 4,
    );
  }
}
