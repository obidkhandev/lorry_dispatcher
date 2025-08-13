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
  final TextEditingController _passportController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  bool _isJshshir = true; // true for JSHSHIR, false for ID card

  @override
  void dispose() {
    _passportController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  void _selectDate() async {
    DateTime initialDate = DateTime.now().subtract(
      const Duration(days: 6570),
    ); // 18 years ago

    // Try to parse existing date if available
    if (_dobController.text.isNotEmpty) {
      try {
        final parts = _dobController.text.split('.');
        if (parts.length == 3) {
          initialDate = DateTime(
            int.parse(parts[2]), // year
            int.parse(parts[1]), // month
            int.parse(parts[0]), // day
          );
        }
      } catch (e) {
        // If parsing fails, use default initial date
        initialDate = DateTime.now().subtract(const Duration(days: 6570));
      }
    }

    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: 350,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          children: [
            // Header
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey[200]!, width: 1),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "Bekor qilish",
                      style: TextStyle(color: Colors.red, fontSize: 16.sp),
                    ),
                  ),
                  Text(
                    "Tug'ilgan kun",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Tayyor",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Date Picker
            Expanded(
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: initialDate,
                minimumDate: DateTime(1900),
                maximumDate: DateTime.now(),
                onDateTimeChanged: (DateTime newDate) {
                  setState(() {
                    _dobController.text =
                        "${newDate.day.toString().padLeft(2, '0')}.${newDate.month.toString().padLeft(2, '0')}.${newDate.year}";
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
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
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => setState(() => _isJshshir = true),
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(8.r),
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      decoration: BoxDecoration(
                        color: _isJshshir
                            ? Theme.of(context).primaryColor
                            : Colors.transparent,
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(7.r),
                        ),
                      ),
                      child: Text(
                        "ID karta",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: _isJshshir ? Colors.white : Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () => setState(() => _isJshshir = false),
                    borderRadius: BorderRadius.horizontal(
                      right: Radius.circular(8.r),
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      decoration: BoxDecoration(
                        color: !_isJshshir
                            ? Theme.of(context).primaryColor
                            : Colors.transparent,
                        borderRadius: BorderRadius.horizontal(
                          right: Radius.circular(7.r),
                        ),
                      ),
                      child: Text(
                        "JSHSHIR",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: !_isJshshir ? Colors.white : Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          16.verticalSpace,

          // Passport/ID Input
          CustomTextField(
            textEditingController: _passportController,
            labelText: _isJshshir ? "ID karta raqami" : "JSHSHIR",
            hintText: _isJshshir ? "AA1234567" : "12345678901234",
            textInputType: _isJshshir
                ? TextInputType.text
                : TextInputType.number,
            // : _isJshshir ? TextCapitalization.characters : TextCapitalization.none,
            formatter: _isJshshir
                ? [
                    FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9]')),
                    LengthLimitingTextInputFormatter(9),
                  ]
                : [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(14),
                  ],
          ),

          16.verticalSpace,

          // Date of Birth Input
          CustomTextField(
            textEditingController: _dobController,
            labelText: "Tug'ilgan kun",
            hintText: "kk.oo.yyyy",
            readOnly: true,
            onTap: _selectDate,
            suffixIcon: IconButton(
              onPressed: _selectDate,
              icon: Icon(Icons.arrow_drop_down, color: Colors.grey[600]),
            ),
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
