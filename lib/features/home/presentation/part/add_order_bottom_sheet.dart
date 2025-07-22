import 'package:lorry_dispatcher/core/utills/helper_widget.dart';
import 'package:lorry_dispatcher/export.dart';
import 'package:lorry_dispatcher/features/common/widget/custom_drop_down_widget.dart';
import 'package:lorry_dispatcher/features/common/widget/text_field_widget.dart';

class AddOrderBottomSheet extends StatefulWidget {
  const AddOrderBottomSheet({super.key});

  @override
  State<AddOrderBottomSheet> createState() => _AddOrderBottomSheetState();
}

class _AddOrderBottomSheetState extends State<AddOrderBottomSheet> {
  late TextEditingController priceController;
  late TextEditingController phoneController;
  late TextEditingController commentController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
      ).copyWith(top: 20.h, bottom: customButtonPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                "Buyurtma qo'shish",
                style: context.theme.textTheme.titleLarge?.copyWith(
                  // fontSize: 16.sp,
                ),
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  context.pop();
                },
                child: SvgPicture.asset(AppIcons.cancel),
              ),
            ],
          ),
          20.verticalSpace,
          CustomSearchableDropDownWidget(
            label: "Qayerdan",
            hintText: "Qayerdan",
            items: ["Hello world", "Salom"],

          ),
          CustomSearchableDropDownWidget(
            label: "Qayerga",
            hintText: "Qayerga",
            items: ["Namangan", "Samarqand"],
          ),
          12.verticalSpace,
          CustomSearchableDropDownWidget(
            label: "Tirkama turi",
            hintText: "Tirkama turi",
            borderColor: AppColors.hintColor,
            backgroundColor: context.theme.cardColor,
            items: ["Namangan", "Samarqand"],
          ),
          12.verticalSpace,
          CustomTextField(
            labelText: "Narx",
            hintText: "Narx",
            borderColor: AppColors.hintColor,
          ),
          12.verticalSpace,
          CustomTextField(
            labelText: "Telefon raqam",
            hintText: "Telefon raqam",
            borderColor: AppColors.hintColor,
          ),
          12.verticalSpace,
          CustomTextField(
            labelText: "Izoh",
            hintText: "Izoh",
            borderColor: AppColors.hintColor,
          ),
          // Spacer(),
          16.verticalSpace,
          CustomButton(height: 50.h, text: "Saqlash"),
        ],
      ),
    );
  }
}

showAddOrderBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    constraints: BoxConstraints(
      minHeight: MediaQuery.of(context).size.height * 0.4,
      maxHeight: MediaQuery.of(context).size.height * 0.8,
    ),
    isScrollControlled: true,
    builder: (_) {
      return AddOrderBottomSheet();
    },
  );
}
