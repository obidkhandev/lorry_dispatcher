import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lorry_dispatcher/core/utills/helper_widget.dart';
import 'package:lorry_dispatcher/export.dart';
import 'package:lorry_dispatcher/features/common/widget/custom_salary_widget.dart';
import 'package:lorry_dispatcher/features/home/presentation/pages/home/widget/order_completed_card.dart';

class OrderCompletedPage extends StatelessWidget {
  const OrderCompletedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        20.verticalSpace,
        SizedBox(
          height: 120.h,
          child: CustomSalaryWidget(amount: 1000),
        ).paddingSymmetric(horizontal: 16.w),
        10.verticalSpace,
        Expanded(
          child: ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 16.w).copyWith(bottom: customButtonPadding + 20),
            itemBuilder: (_, index) {
              return OrderCompletedCard();
            },
            separatorBuilder: (_, index) {
              return 12.verticalSpace;
            },
            itemCount: 10,
          ),
        ),
      ],
    );
  }
}
