import 'package:lorry_dispatcher/core/utills/helper_widget.dart';
import 'package:lorry_dispatcher/export.dart';
import 'package:lorry_dispatcher/features/common/widget/custom_calendar_widget.dart';
import 'package:lorry_dispatcher/features/common/widget/custom_salary_widget.dart';
import 'package:lorry_dispatcher/features/status/presentation/pages/status/widget/order_completed_card.dart';

class OrderCompletedPage extends StatelessWidget {
  const OrderCompletedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomDropdownDateRangeWidget(
          onRangeSelected: (v) {},
        ).paddingSymmetric(horizontal: 16.w, vertical: 20.h),
        SizedBox(
          height: 120.h,
          child: CustomSalaryWidget(amount: 1000),
        ).paddingSymmetric(horizontal: 16.w),
        16.verticalSpace,
        Expanded(
          child: ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
            ).copyWith(bottom: customButtonPadding),
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
