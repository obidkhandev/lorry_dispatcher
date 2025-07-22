// ignore_for_file: library_private_types_in_public_api



import '../../../export.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final String? leftIcon;
  final bool isDivider;
  final List<Widget>? action;
  final Widget? bottom;
  final double? toolbarHeight;
  final String? rightIcon;
  final Function()? leftOnTap;
  final Function()? rightOnTap;
  final bool hasAutoLeading;

  const CustomAppBar({
    super.key,
    this.title,
    this.leftIcon,
    this.rightIcon,
    this.leftOnTap,
    this.rightOnTap,
    this.isDivider = true,
    this.action,
    this.bottom,
    this.toolbarHeight,
    this.hasAutoLeading = true,
  });

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight ?? kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0.0,
      centerTitle: true,
      title: Text(
        title ?? "",
        style: context.theme.textTheme.titleMedium?.copyWith(fontSize: 18.sp),
      ),
      bottom: bottom != null
          ? PreferredSize(preferredSize: preferredSize, child: bottom!)
          : null,
      leading: hasAutoLeading == true
          ? IconButton.filled(
              style: IconButton.styleFrom(
                backgroundColor: context.theme.cardColor,
              ),
              onPressed: leftOnTap ?? () => Navigator.pop(context),
              icon: Icon(
                Platform.isIOS
                    ? Icons.arrow_back_ios_new_rounded
                    : Icons.arrow_back_rounded,
              ),
            )
          : const SizedBox.shrink(),
      actions:
          action ??
          [
            rightIcon != null
                ? ScaleButton(
                    bound: 0.040,
                    onTap: rightOnTap,
                    child: SvgPicture.asset(rightIcon ?? ''),
                  ).paddingOnly(right:16.w)
                : const SizedBox.shrink(),
          ],
    );
  }
}
