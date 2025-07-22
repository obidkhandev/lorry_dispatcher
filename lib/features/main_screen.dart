import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:lorry_dispatcher/core/utills/extensions.dart';
import 'package:lorry_dispatcher/core/values/app_colors.dart';
import 'package:lorry_dispatcher/core/values/app_icons.dart';
import 'package:lorry_dispatcher/generated/l10n.dart';

class MainScreen extends StatefulWidget {
  final StatefulNavigationShell child;

  const MainScreen({super.key, required this.child});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  void onTap(BuildContext context, int index) {
    if (index == widget.child.currentIndex) return;

    widget.child.goBranch(index, initialLocation: false);
  }

  @override
  Widget build(BuildContext context) {
    List<String> icons = [
      AppIcons.home,
      // AppIcons.document,
      AppIcons.profile,
    ];

    List<String> labels = [
     S.of(context).home,
      // "yuk_qidirish",
      S.of(context).profile,
    ];

    return RepaintBoundary(
      child: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          if (didPop) return;

          // Simply check if Navigator can pop (bottom sheet, dialog, etc.)
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          } else {
            // Go to home tab instead of exiting
            if (widget.child.currentIndex != 0) {
              widget.child.goBranch(0, initialLocation: false);
            } else {
              // If already on home tab, exit the app
              SystemNavigator.pop();
            }
          }
        },
        child: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: context.theme.scaffoldBackgroundColor,
            currentIndex: widget.child.currentIndex,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: context.theme.textTheme.titleMedium?.color,
            selectedIconTheme: const IconThemeData(color: AppColors.primaryColor),
            unselectedIconTheme: const IconThemeData(color: AppColors.grey600),
            onTap: (i) => onTap(context, i),
            items: List.generate(
              icons.length,
                  (index) => BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  icons[index],
                  colorFilter: ColorFilter.mode(
                    widget.child.currentIndex == index
                        ? AppColors.primaryColor
                        : AppColors.grey600,
                    BlendMode.srcIn,
                  ),
                ),
                label: labels[index],
              ),
            ),
          ),
          body: widget.child,
        ),
      ),
    );
  }
}