import '../../../../../../export.dart';

class SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> tiles;

  const SettingsSection({
    super.key,
    required this.title,
    required this.tiles,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        20.verticalSpace,
        Text(
          title,
          style: context.theme.textTheme.displayMedium?.copyWith(
            fontSize: 20.sp,
          ),
        ),
        ...tiles,
      ],
    );
  }
}
