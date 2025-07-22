import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lorry_dispatcher/core/values/app_text_sytle.dart';

enum CustomSnackbarType { success, error }

class _AnimatedSnackbar extends StatefulWidget {
  final String message;
  final IconData icon;
  final Color iconColor;
  final Color bgColor;
  final VoidCallback onDismissed;
  final bool isTop;

  const _AnimatedSnackbar({
    required this.message,
    required this.icon,
    required this.iconColor,
    required this.bgColor,
    required this.onDismissed,
    this.isTop = false,
  });

  @override
  State<_AnimatedSnackbar> createState() => _AnimatedSnackbarState();
}

class _AnimatedSnackbarState extends State<_AnimatedSnackbar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);

    _offsetAnimation = Tween<Offset>(
      begin: widget.isTop ? Offset(0.0, -1.0) : Offset(0.0, 1.0),
      end: Offset(0.0, 0.0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    _controller.forward();

    // Auto dismiss
    Future.delayed(Duration(seconds: 2)).then((_) {
      _controller.reverse().then((_) => widget.onDismissed());
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.isTop ? 50.h : null,
      bottom: widget.isTop ? null : 50.h,
      right: 16.w,
      left: 16.w,
      child: SlideTransition(
        position: _offsetAnimation,
        child: Material(
          color: Colors.transparent,
          child: Container(
            constraints: BoxConstraints(maxWidth: 400),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: widget.bgColor,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10.r,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(widget.icon, color: widget.iconColor),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    widget.message,
                    style: AppTextStyles().body16w5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


void showCustomSnackbar(
    BuildContext context, {
      required String message,
      required CustomSnackbarType type,
      bool isTop = true,
    }) {
  final overlay = Overlay.of(context);
  final icon =
  type == CustomSnackbarType.success ? Icons.check_circle : Icons.error;

  const bgColor = Colors.white;
  final iconColor =
  type == CustomSnackbarType.success ? Colors.green : Colors.red;

  late OverlayEntry overlayEntry;

  overlayEntry = OverlayEntry(
    builder: (context) {
      return _AnimatedSnackbar(
        message: message,
        icon: icon,
        iconColor: iconColor,
        bgColor: bgColor,
        onDismissed: () => overlayEntry.remove(),
        isTop: isTop,
      );
    },
  );

  overlay.insert(overlayEntry);
}
