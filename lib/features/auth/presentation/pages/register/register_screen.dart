import 'package:lorry_dispatcher/core/routes/app_routes.dart';
import 'package:lorry_dispatcher/core/utills/formatters.dart';
import 'package:lorry_dispatcher/export.dart';
import 'package:lorry_dispatcher/features/common/widget/text_field_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(
        top: false,
        child:
            CustomButton(
              text: "Ro'yxatdan o'tish",
              onTap: () {
                context.go(AppRoutes.home);
              },
            ).paddingOnly(
              left: 16.w,
              right: 16.w,
              bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            ),
      ),
      appBar: CustomAppBar(title: "Ro'yxatdan o'tish"),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [

          12.verticalSpace,
          CustomTextField(
            labelText: "Telefon raqamingiz",
            hintText: "Telefon raqamingiz",
            leadingWidget: Text(
              "+998",
              style: context.theme.textTheme.titleMedium,
            ).paddingOnly(left: 10.w, top: 8.h),
            formatter: [Formatters.phoneFormatter],
          ),
        ],
      ).paddingSymmetric(horizontal: 16.w),
    );
  }
}
