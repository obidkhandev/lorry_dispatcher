import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lorry_dispatcher/core/utills/helper_widget.dart';
import 'package:lorry_dispatcher/features/common/widget/custom_app_bar.dart';
import 'package:lorry_dispatcher/features/common/widget/custom_constrained_scroll.dart';
import 'package:lorry_dispatcher/features/common/widget/text_field_widget.dart';

import '../../../../../export.dart';

class AddCardScreen extends StatelessWidget {
  const AddCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Karta qo'shish",
      ),
      body: AppConstrainedScrollView(
        child: Column(
          children: [
            20.verticalSpace,
            CustomTextField(
              // suffixIcon: AppIcons.creditCard,
              hintText: "0000 0000 0000 0000",
              labelText: "Card Number",
            ),
            16.verticalSpace,
            CustomTextField(
              labelText: "Expiry Date",
              hintText: "MM/YY",
              // suffixIcon: AppIcons.calendar,
            ),
            16.verticalSpace,
            CustomTextField(
              labelText: "Card holder",
              hintText: "Enter card holder",
            ),
            Spacer(),
            CustomButton(
              text: "Add card",
            ),
          ],
        ).paddingSymmetric(horizontal: 16.w).paddingOnly(bottom: customButtonPadding),
      ),
    );
  }
}
