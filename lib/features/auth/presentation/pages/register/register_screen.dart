import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:lorry_dispatcher/core/routes/app_routes.dart';
import 'package:lorry_dispatcher/core/utills/formatters.dart';
import 'package:lorry_dispatcher/core/values/app_text_sytle.dart';
import 'package:lorry_dispatcher/export.dart';
import 'package:lorry_dispatcher/features/common/widget/text_field_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController _nameController;
  late TextEditingController _lastNameController;
  late TextEditingController _phoneController;



  @override
  void initState() {
    // TODO: implement initState
    _nameController = TextEditingController();
    _lastNameController = TextEditingController();
    _phoneController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(
        top: false,
        child:
            CustomButton(
              text: "Keyingi",
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
          20.verticalSpace,

          16.verticalSpace,
          CustomTextField(
            textEditingController: _nameController,
            labelText: "Ism",
            hintText: "Ism",
          ),


          16.verticalSpace,
          CustomTextField(
            textEditingController: _lastNameController,
            labelText: "Familiya",
            hintText: "Familiya",
          ),
          16.verticalSpace,
          CustomTextField(
            labelText: "Telefon raqami",
            hintText: "Telefon raqami",
            readOnly: true,
          ),
          24.verticalSpace,
          SwitchListTile(
            hoverColor: AppColors.transparent,
            overlayColor: WidgetStateProperty.resolveWith<Color?>(
                  (Set<WidgetState> states) {
                return AppColors.transparent;
              },
            ),
            activeTrackColor: AppColors.primaryColor,
            inactiveTrackColor: AppColors.grey600,
            title: RichText(
              text: TextSpan(
                style: context.theme.textTheme.titleMedium,
                children: [
                  TextSpan(text: "Men shartlarni qabul qilaman "),
                  TextSpan(
                    text: "Foydalanuvchi kelishuvi ",
                    style: context.theme.textTheme.titleMedium?.copyWith(
                      color: AppColors.brandElectric,
                    ),
                  ),
                  TextSpan(text: "va "),
                  TextSpan(
                    text: "Maxfiylik siyosati",
                    style: context.theme.textTheme.titleMedium?.copyWith(
                      color: AppColors.brandElectric,
                    ),
                  ),
                ],
              ),
            ),
            contentPadding: EdgeInsets.zero,
            value: false,
            onChanged: (v) {},
          ),
        ],
      ).paddingSymmetric(horizontal: 16.w),
    );
  }
}
