

import 'package:flutter/cupertino.dart';

import '../../../export.dart';

class CustomYesNoDialog extends StatelessWidget {
  final Function() onYes, onNo;
  final bool isLoadingYes;
  final String? titleYes, titleNo;
  final String title;

  const CustomYesNoDialog({
    super.key,
    required this.onYes,
    required this.onNo,
    this.isLoadingYes = false,
    this.titleYes,
    this.titleNo,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoActionSheet(
        title: Text(
          title,
          style: context.theme.textTheme.titleLarge,
        ),
        actions: [
          CupertinoActionSheetAction(
            onPressed: isLoadingYes ? () {} : onYes,
            isDefaultAction: true,
            child: Text(
              titleYes ?? S.of(context).confirm,
              style: TextStyle(
                color: isLoadingYes
                    ? CupertinoColors.inactiveGray
                    : CupertinoColors.activeBlue,
                fontSize: 20,
              ),
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: onNo,
            isDestructiveAction: true,
            child: Text(
              titleNo ?? S.of(context).cancel,
              style: TextStyle(
                color: CupertinoColors.destructiveRed,
                fontSize: 20,
              ),
            ),
          ),
        ],
      );
    }

    return Dialog(
      backgroundColor: context.theme.cardColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
// mainAxisAlignment: MainAxisAlignment.,
        children: [
          Text(
            title,
            style: context.theme.textTheme.titleMedium,
          ),
          Row(
            spacing: 16.w,
            children: [
              Expanded(
                child: CustomButton(
                  onTap: onNo,
                  height: 50.h,
                  textColor: AppColors.primaryColor,
                  borderColor: AppColors.primaryColor,
                  bgColor: AppColors.transparent,
                  text: titleNo ?? S.of(context).cancel,
                ),
              ),
              Expanded(
                child: CustomButton(
                  height: 50.h,
                  onTap: isLoadingYes ? () {} : onYes,
                  text: titleYes ?? S.of(context).confirm,
                ),
              ),
            ],
          ),
        ],
      ).paddingAll(10.sp),
    );
  }

// show
  void show(BuildContext context) {
    if (Platform.isIOS) {
      showCupertinoModalPopup(
        context: context,
        builder: (context) => this,
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => this,
      );
    }
  }
}
