import 'package:lorry_dispatcher/export.dart';
import 'package:lorry_dispatcher/features/home/presentation/pages/home/widget/order_offer_card.dart';

class SendOfferBottomSheet extends StatefulWidget {
  const SendOfferBottomSheet({super.key});

  @override
  State<SendOfferBottomSheet> createState() => _SendOfferBottomSheetState();
}

class _SendOfferBottomSheetState extends State<SendOfferBottomSheet> {
  Set<int> selectedIndices = {};

  void toggleSelection(int index) {
    setState(() {
      if (selectedIndices.contains(index)) {
        selectedIndices.remove(index);
      } else {
        selectedIndices.add(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Header with selection count
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 16.h,
          ).copyWith(top: 30.h),
          child: Row(
            children: [
              Text(
                'Takliflar',
                style: context.theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  context.pop();
                },
                child: SvgPicture.asset(AppIcons.cancel),
              ),
            ],
          ),
        ),
        Flexible(
          child: ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 20.h),
            itemBuilder: (_, index) {
              return OrderOfferCard(
                isSelected: selectedIndices.contains(index),
                onTap: () => toggleSelection(index),
              );
            },
            separatorBuilder: (_, index) {
              return 12.verticalSpace;
            },
            itemCount: 5,
          ),
        ),
        20.verticalSpace,
        CustomButton(
          text: selectedIndices.isEmpty
              ? "Taklif tanlang"
              : "Taklif yuborish (${selectedIndices.length})",
          icon: AppIcons.send2,

          onTap: selectedIndices.isNotEmpty
              ? () {
                  // Handle send offer logic here
                  Navigator.pop(context);
                  // You can pass selectedIndices to your API call
                }
              : null,
        ).paddingOnly(left: 16.w, right: 16.w, bottom: 20.h),
      ],
    );
  }
}

showSendOfferBottomSheet(BuildContext context) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    constraints: BoxConstraints(
      maxHeight: MediaQuery.of(context).size.height * 0.8,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
    ),
    builder: (_) {
      return SendOfferBottomSheet();
    },
  );
}
