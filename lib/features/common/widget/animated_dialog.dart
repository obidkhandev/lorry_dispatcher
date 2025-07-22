import 'package:flutter/material.dart';

class AnimatedAlertDialog extends StatefulWidget {
  final String title;
  final String message;
  final AlertType type;
  final VoidCallback? onConfirm;
  final String confirmText;

  const AnimatedAlertDialog({
    super.key,
    required this.title,
    required this.message,
    required this.type,
    this.onConfirm,
    this.confirmText = 'OK',
  });

  @override
  State<AnimatedAlertDialog> createState() => _AnimatedAlertDialogState();
}

enum AlertType { success, error }

class _AnimatedAlertDialogState extends State<AnimatedAlertDialog>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _iconController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _iconAnimation;

  @override
  void initState() {
    super.initState();

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _iconController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _scaleAnimation = CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    );

    _iconAnimation = CurvedAnimation(
      parent: _iconController,
      curve: Curves.bounceIn,
    );

    // Start animations
    _scaleController.forward();
    Future.delayed(const Duration(milliseconds: 100), () {
      _iconController.forward();
    });
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _iconController.dispose();
    super.dispose();
  }

  Color get _primaryColor {
    switch (widget.type) {
      case AlertType.success:
        return Colors.green;
      case AlertType.error:
        return Colors.red;
    }
  }

  IconData get _iconData {
    switch (widget.type) {
      case AlertType.success:
        return Icons.check_circle;
      case AlertType.error:
        return Icons.error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: const EdgeInsets.all(24),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Animated Icon
            ScaleTransition(
              scale: _iconAnimation,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: _primaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _iconData,
                  color: _primaryColor,
                  size: 48,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Title
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),

            // Message
            Text(
              widget.message,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),

            // Confirm Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  widget.onConfirm?.call();
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  widget.confirmText,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Helper methods to show the dialogs
class AlertDialogHelper {
  static Future<void> showSuccessDialog(
      BuildContext context, {
        required String title,
        required String message,
        VoidCallback? onConfirm,
        String confirmText = 'OK',
      }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AnimatedAlertDialog(
        title: title,
        message: message,
        type: AlertType.success,
        onConfirm: onConfirm,
        confirmText: confirmText,
      ),
    );
  }

  static Future<void> showErrorDialog(
      BuildContext context, {
        required String title,
        required String message,
        VoidCallback? onConfirm,
        String confirmText = 'OK',
      }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AnimatedAlertDialog(
        title: title,
        message: message,
        type: AlertType.error,
        onConfirm: onConfirm,
        confirmText: confirmText,
      ),
    );
  }
}


//  AlertDialogHelper.showSuccessDialog(
//                   context,
//                   title: 'Success!',
//                   message: 'Your operation was completed successfully.',
//                   onConfirm: () {
//                     print('Success dialog confirmed');
//                   },
//                 );