import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lorry_dispatcher/core/routes/app_routes.dart';
import 'package:lorry_dispatcher/core/utills/formatters.dart';
import 'package:lorry_dispatcher/core/utills/helper_widget.dart';
import 'package:lorry_dispatcher/core/values/app_strings.dart';
import 'package:lorry_dispatcher/di.dart';
import 'package:lorry_dispatcher/export.dart';
import 'package:lorry_dispatcher/features/common/bloc/auth/auth_bloc.dart';
import 'package:lorry_dispatcher/features/common/widget/custom_yes_no_dialog.dart';
import 'package:lorry_dispatcher/features/common/widget/text_field_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController phoneController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    phoneController = TextEditingController();
  }

  // Format phone for API (add country code 998)
  String _formatPhoneForApi(String phone) {
    String cleanPhone = phone.replaceAll(RegExp(r'[^\d]'), '');
    return '998$cleanPhone';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          final bloc = context.read<AuthBloc>();
          return Form(
            key: _formKey,
            child: Column(
              children: [
                100.verticalSpace,
                SvgPicture.asset(AppIcons.logo),
                30.verticalSpace,
                CustomTextField(
                  validator: (v) {
                    if (v == null || v == "" || v.length <= 13) {
                      return "Iltimos telefon raqamni kiriting";
                    }else{
                      return null;
                    }
                  },
                  textEditingController: phoneController,
                  labelText: "Telefon raqamingiz",
                  hintText: "Telefon raqamingiz",
                  leadingWidget: Text(
                    "+998",
                    style: context.theme.textTheme.titleMedium,
                  ).paddingOnly(left: 10.w, top: 8.h),
                  formatter: [Formatters.phoneFormatter],
                ),
                Spacer(),
                CustomButton(
                  text: "Kirish",
                  isLoading: state.getOtpSt == Status.LOADING,
                  onTap: () {
                    if (_formKey.currentState!.validate() == true) {
                      String formattedPhone = _formatPhoneForApi(
                        phoneController.text,
                      );

                      bloc.add(
                        GetOtpEvent(
                          phone: formattedPhone,
                          onSuccess: () {
                            context.pushNamed(
                              AppRoutes.otpScreen,
                              extra: {"phone": formattedPhone},
                            );
                          },
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
                    }
                  },
                ),
                customButtonPadding.verticalSpace,
              ],
            ),
          );
        },
      ).paddingSymmetric(horizontal: 16.w),
    );
  }
}
