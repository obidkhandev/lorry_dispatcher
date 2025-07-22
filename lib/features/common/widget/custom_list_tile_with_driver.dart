
import 'package:lorry_dispatcher/core/utills/helper_widget.dart';
import 'package:lorry_dispatcher/export.dart';


class CustomListTileWithDriver extends StatelessWidget {
  final String? leadingSvg, trailingSvg, title, subtitle;
  final Function()? onTap;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final bool hasDriver;
  final double? leadingHorizontalPadding;
  final double? leadingSize;
  final Color? leadingColor;
  final Color? trailingColor;
  final double horizontalPadding;
  final Widget? trailingWidget;
  final Widget? leadingWidget;

  const CustomListTileWithDriver({
    super.key,
    this.title,
    this.subtitle,
    this.onTap,
    this.leadingSvg,
    this.trailingSvg,
    this.titleStyle,
    this.subtitleStyle,
    this.hasDriver = true,
    this.leadingHorizontalPadding,
    this.leadingSize,
    this.leadingColor,
    this.trailingColor,
    this.trailingWidget,
    this.horizontalPadding = 0,
    this.leadingWidget,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          20.verticalSpace,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (leadingSvg != null) ...[
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: SvgPicture.asset(
                    leadingSvg!,
                    width: leadingSize,
                    height: leadingSize,
                    colorFilter: AppColors.colorFilter(
                      leadingColor ?? context.theme.canvasColor,
                    ),
                  ),
                ),
                SizedBox(
                  width: leadingHorizontalPadding ?? 0,
                ),
              ],
              leadingWidget ?? const SizedBox.shrink(),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (title != null)
                      Text(
                        title!,
                        style:
                            titleStyle ?? context.theme.textTheme.displayMedium,
                      ),
                    if (subtitle != null)
                      Text(
                        subtitle!,
                        style: subtitleStyle ??
                            context.theme.textTheme.titleMedium,
                      ),
                  ],
                ),
              ),
              trailingSvg != null
                  ? Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: SvgPicture.asset(
                        trailingSvg!,
                        color: trailingColor ?? context.theme.iconTheme.color?.withOpacity(0.7),
                      ),
                    )
                  : trailingWidget ?? SizedBox.shrink(),
            ],
          ).paddingSymmetric(horizontal: horizontalPadding),
          if (hasDriver) ...[
            16.verticalSpace,
            customDivider,
          ],
        ],
      ),
    );
  }
}
