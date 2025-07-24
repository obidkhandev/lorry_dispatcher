import 'package:intl/intl.dart';
import 'package:lorry_dispatcher/core/values/app_text_sytle.dart';

import '../../../../../../export.dart';

class CustomSalaryWidget extends StatelessWidget {
  final String? title;
  final int amount;
  const CustomSalaryWidget({super.key, this.title,  this.amount = 0});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Dimensions.commonBorderRadius14.r),
      child: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset(
            AppIcons.mothlyProfitDecoration,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 30.h,
            left: 16.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title ?? "Oylik daromad",
                  style: AppTextStyles().body15w6.copyWith(
                    color: AppColors.white,
                  ),
                ),
                Text(
                  NumberFormat.currency(locale: 'uz').format(amount),
                  style: AppTextStyles().body26w5.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}