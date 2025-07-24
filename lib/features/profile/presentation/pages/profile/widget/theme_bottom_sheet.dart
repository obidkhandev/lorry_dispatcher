import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lorry_dispatcher/core/utills/enums.dart';
import 'package:lorry_dispatcher/core/utills/helper_widget.dart';
import 'package:lorry_dispatcher/features/common/bloc/settings/settings_cubit.dart';
import 'package:lorry_dispatcher/features/common/widget/custom_modal_bottom_sheet.dart';

import '../../../../../../export.dart';

class ThemeBottomSheet extends StatelessWidget {
  const ThemeBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SettingsCubit>();

    return CustomModalBottomSheet(
      title: S.of(context).night_mode, // Already localized
      content: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          ThemeModeState selectedMode = state.themeMode;

          return Column(
            children: [
              RadioListTile<ThemeModeState>(
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.trailing,
                value: ThemeModeState.auto,
                groupValue: selectedMode,
                onChanged: (mode) {
                  if (mode != null) {
                    cubit.setThemeMode(mode);
                    Navigator.pop(context);
                  }
                },
                activeColor: AppColors.primaryColor,
                title: Text(
                  S.of(context).auto, // Already localized
                  style: context.theme.textTheme.titleMedium,
                ),
              ),
              customDivider,
              RadioListTile<ThemeModeState>(
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.trailing,
                value: ThemeModeState.light,
                groupValue: selectedMode,
                onChanged: (mode) {
                  if (mode != null) {
                    cubit.setThemeMode(mode);
                    Navigator.pop(context);
                  }
                },
                activeColor: AppColors.primaryColor,
                title: Text(
                  S.of(context).light, // Already localized
                  style: context.theme.textTheme.titleMedium,
                ),
              ),
              customDivider,
              RadioListTile<ThemeModeState>(
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.trailing,
                value: ThemeModeState.dark,
                groupValue: selectedMode,
                onChanged: (mode) {
                  if (mode != null) {
                    // context.read<MapBloc>().add(SetMapTheme(true));
                    cubit.setThemeMode(mode);
                    Navigator.pop(context);
                  }
                },
                activeColor: AppColors.primaryColor,
                title: Text(
                  S.of(context).dark, // Already localized
                  style: context.theme.textTheme.titleMedium,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

showThemeBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) => const ThemeBottomSheet(),
  );
}