import 'package:flutter/material.dart';
import 'package:lorry_dispatcher/core/utills/enums.dart';
import 'package:lorry_dispatcher/core/utills/extensions.dart';
import 'package:lorry_dispatcher/core/utills/helper_widget.dart';
import 'package:lorry_dispatcher/core/values/app_colors.dart';
import 'package:lorry_dispatcher/features/common/widget/custom_modal_bottom_sheet.dart';
import 'package:lorry_dispatcher/generated/l10n.dart';

class LanguageSelectionBottomSheet extends StatelessWidget {
  final String selectedLanguage;
  final ValueChanged<String> onLanguageSelected;

  const LanguageSelectionBottomSheet({
    super.key,
    required this.selectedLanguage,
    required this.onLanguageSelected,
  });

  @override
  Widget build(BuildContext context) {
    return CustomModalBottomSheet(
      title: S.of(context).selectLanguage,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...languages.map((lang) => Column(
            children: [
              RadioListTile(
                contentPadding: EdgeInsets.zero,
                hoverColor: AppColors.primaryOpacity,
                activeColor: AppColors.primaryColor,
                controlAffinity: ListTileControlAffinity.trailing,
                fillColor: WidgetStateProperty.resolveWith<Color?>(
                      (Set<WidgetState> states) {
                    if (states.contains(WidgetState.selected)) {
                      return AppColors.primaryColor;
                    }
                    return AppColors.grey600;
                  },
                ),
                title: Text(
                  lang['name']!,
                  style: context.theme.textTheme.titleMedium,
                ),
                value: lang['code'],
                groupValue: selectedLanguage,
                onChanged: (value) {
                  onLanguageSelected(value as String);
                  Navigator.pop(context);
                },
              ),
              customDivider,
            ],
          )),
        ],
      ),
    );
  }
}

showLanguageSelectionBottomSheet({
  required BuildContext context,
  required String selectedLanguage,
  required ValueChanged<String> onLanguageSelected,
}) {
  showModalBottomSheet(
    context: context,
    builder: (context) => LanguageSelectionBottomSheet(
      selectedLanguage: selectedLanguage,
      onLanguageSelected: onLanguageSelected,
    ),
  );
}
