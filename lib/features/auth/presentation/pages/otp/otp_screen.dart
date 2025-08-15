import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lorry_dispatcher/core/routes/app_routes.dart';
import 'package:lorry_dispatcher/core/utills/number_formatter.dart';
import 'package:lorry_dispatcher/core/values/app_strings.dart';
import 'package:lorry_dispatcher/core/values/app_text_sytle.dart';
import 'package:lorry_dispatcher/export.dart';
import 'package:lorry_dispatcher/features/common/bloc/auth/auth_bloc.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatefulWidget {
  final String phone;

  const OtpScreen({super.key, required this.phone});

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
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final bloc = context.read<AuthBloc>();
        return Scaffold(
          backgroundColor: context.isDarkMode
              ? context.theme.scaffoldBackgroundColor
              : AppColors.white,
          appBar: CustomAppBar(),
          bottomNavigationBar: SafeArea(
            top: false,
            child:
                CustomButton(
                  text: "Ro'yxatdan o'tish",
                  isLoading: state.otpVerifySt == Status.LOADING,
                  onTap: () {
                    bloc.add(
                      OtpVerifyEvent(
                        onError: (){},
                        onSuccess: (){
                          context.go(AppRoutes.home);

                        },
                        phone: widget.phone,
                        otp: _otpController.text,
                        role: 1,
                      ),
                    );
                  },
                ).paddingOnly(
                  left: 16.w,
                  right: 16.w,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                ),
          ),
          body: Column(
            children: [
              Text(
                "${widget.phone.phone2} \n raqamiga kodni SMS tarzda yubordik",
                style: context.theme.textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              32.verticalSpace,
              Center(
                child: Pinput(
                  controller: _otpController,
                  onCompleted: (v) {
                    bloc.add(
                      OtpVerifyEvent(
                        onError: (){},
                        onSuccess: (){
                          context.go(AppRoutes.home);
                        },
                        phone: widget.phone,
                        otp: _otpController.text,
                        role: 1,
                      ),
                    );
                  },
                  length: 6,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  showCursor: true,
                  cursor: Container(
                    height: 30.h,
                    width: 2.w,
                    color: AppColors.primaryColor,
                  ),

                  focusedPinTheme: PinTheme(
                    width: 60.w,
                    height: 60.h,
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
                    width: 60.w,
                    height: 60.h,
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

              state.retryAfter == null || state.retryAfter! <= 0
                  ? Center(
                      child: TextButton(
                        onPressed: () {
                          bloc.add(
                            GetOtpEvent(
                              phone: widget.phone,
                              onSuccess: () {},
                              onError: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      state.getOtpFailure?.messageBuilder(
                                            context,
                                          ) ??
                                          '',
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                        child: Text(
                          S.of(context).resendCode,
                          style: context.theme.textTheme.titleMedium?.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    )
                  : Center(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: S.of(context).resendCode,
                              style: context.theme.textTheme.titleMedium,
                            ),
                            TextSpan(
                              text:
                                  " ${state.retryAfter?.toTimeFormat()} seconds",
                              style: AppTextStyles().body16w6.copyWith(
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

              Spacer(),
            ],
          ).paddingSymmetric(horizontal: 16.w),
        );
      },
    );
  }
}
