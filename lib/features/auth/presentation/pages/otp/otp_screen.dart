import 'package:flutter/services.dart';
import 'package:lorry_dispatcher/core/routes/app_routes.dart';
import 'package:lorry_dispatcher/export.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _otpController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.isDarkMode
          ? context.theme.scaffoldBackgroundColor
          : AppColors.white,
      appBar: CustomAppBar(),
      bottomNavigationBar: SafeArea(
        top: false,
        child: CustomButton(text: "Ro'yxatdan o'tish", onTap: () {
          context.pushNamed(AppRoutes.registerScreen);
        })
            .paddingOnly(
          left: 16.w,
          right: 16.w,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
      ),
      body: Column(
        children: [
          Text(
            "+998 99 842 7979 \n raqamiga kodni SMS tarzda yubordik",
            style: context.theme.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          32.verticalSpace,
          Center(
            child: Pinput(
              controller: _otpController,
              onCompleted: (v) {},
              length: 4,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              showCursor: true,
              cursor: Container(
                height: 30.h,
                width: 2.w,
                color: AppColors.primaryColor,
              ),

              focusedPinTheme: PinTheme(
                width: 70.w,
                height: 70.h,
                textStyle: context.theme.textTheme.headlineLarge?.copyWith(
                  fontSize: 26.sp,
                ),
                decoration: BoxDecoration(
                  color: context.isDarkMode
                      ? context.theme.cardColor
                      : AppColors.scaffoldBackground,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.primaryColor),
                ),
              ),
              defaultPinTheme: PinTheme(
                width: 70.w,
                height: 70.h,
                textStyle: context.theme.textTheme.headlineLarge?.copyWith(
                  fontSize: 26.sp,
                ),
                decoration: BoxDecoration(
                  color: context.isDarkMode
                      ? context.theme.cardColor
                      : AppColors.scaffoldBackground,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          10.verticalSpace,
          Center(
            child: TextButton(
              onPressed: () {},
              child: Text(
                S.of(context).resendCode,
                style: context.theme.textTheme.titleMedium?.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ),
          // : Center(
          //     child: RichText(
          //       text: TextSpan(
          //         children: [
          //           TextSpan(
          //             text: S.of(context).resendCode,
          //             style: context.theme.textTheme.titleMedium,
          //           ),
          //           TextSpan(
          //             text:
          //                 " ${state.retryAfter?.toTimeFormat()} ${S.of(context).seconds}",
          //             style: AppTextStyles().body16w6.copyWith(
          //               color: AppColors.primaryColor,
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          Spacer(),

        ],
      ).paddingSymmetric(horizontal: 16.w),
    );
  }
}
