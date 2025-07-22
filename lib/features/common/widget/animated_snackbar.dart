import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:lorry_dispatcher/core/utills/extensions.dart';
import 'package:lorry_dispatcher/core/values/app_colors.dart';


class AnimatedSnackbar extends StatefulWidget {
  final String message;
  final Duration duration;
  final SnackbarType type;
  final VoidCallback? onDismiss;
  final String? actionLabel;
  final VoidCallback? onAction;
  final IconData? customIcon;
  final bool showProgressBar;

  const AnimatedSnackbar({
    super.key,
    required this.message,
    this.duration = const Duration(seconds: 3),
    this.type = SnackbarType.info,
    this.onDismiss,
    this.actionLabel,
    this.onAction,
    this.customIcon,
    this.showProgressBar = true,
  });

  static void show(
      BuildContext context, {
        required String message,
        Duration duration = const Duration(seconds: 3),
        SnackbarType type = SnackbarType.info,
        VoidCallback? onDismiss,
        String? actionLabel,
        VoidCallback? onAction,
        IconData? customIcon,
        bool showProgressBar = true,
      }) {
    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: MediaQuery.of(context).padding.bottom + 20,
        left: 0,
        right: 0,
        child: _AnimatedSnackbarWidget(
          message: message,
          duration: duration,
          type: type,
          onDismiss: () {
            overlayEntry.remove();
            onDismiss?.call();
          },
          actionLabel: actionLabel,
          onAction: onAction,
          customIcon: customIcon,
          showProgressBar: showProgressBar,
        ),
      ),
    );

    overlay.insert(overlayEntry);
  }

  @override
  State<AnimatedSnackbar> createState() => _AnimatedSnackbarState();
}

class _AnimatedSnackbarState extends State<AnimatedSnackbar> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _AnimatedSnackbarWidget extends StatefulWidget {
  final String message;
  final Duration duration;
  final SnackbarType type;
  final VoidCallback onDismiss;
  final String? actionLabel;
  final VoidCallback? onAction;
  final IconData? customIcon;
  final bool showProgressBar;

  const _AnimatedSnackbarWidget({
    required this.message,
    required this.duration,
    required this.type,
    required this.onDismiss,
    this.actionLabel,
    this.onAction,
    this.customIcon,
    this.showProgressBar = true,
  });

  @override
  State<_AnimatedSnackbarWidget> createState() => _AnimatedSnackbarWidgetState();
}

class _AnimatedSnackbarWidgetState extends State<_AnimatedSnackbarWidget>
    with TickerProviderStateMixin {
  late AnimationController _entryController;
  late AnimationController _exitController;
  late AnimationController _progressController;
  late AnimationController _iconRotationController;
  late AnimationController _pulseController;

  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _progressAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _blurAnimation;

  bool _isExiting = false;
  double _dragOffset = 0;

  @override
  void initState() {
    super.initState();

    // Entry controller for combined entrance animations
    _entryController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    // Exit controller for dismiss animations
    _exitController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    // Progress bar controller
    _progressController = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    // Icon rotation controller
    _iconRotationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Pulse animation controller
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Setup animations
    _slideAnimation = Tween<double>(
      begin: 100,
      end: 0,
    ).animate(CurvedAnimation(
      parent: _entryController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOutCubic),
    ));

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _entryController,
      curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.7,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _entryController,
      curve: const Interval(0.2, 1.0, curve: Curves.elasticOut),
    ));

    _rotationAnimation = Tween<double>(
      begin: -0.5,
      end: 0,
    ).animate(CurvedAnimation(
      parent: _iconRotationController,
      curve: Curves.elasticOut,
    ));

    _progressAnimation = Tween<double>(
      begin: 1,
      end: 0,
    ).animate(_progressController);

    _pulseAnimation = Tween<double>(
      begin: 1,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    _blurAnimation = Tween<double>(
      begin: 10,
      end: 0,
    ).animate(CurvedAnimation(
      parent: _entryController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    ));

    // Start animations
    _entryController.forward();
    _iconRotationController.forward();
    if (widget.showProgressBar) {
      _progressController.forward();
    }
    _pulseController.repeat(reverse: true);

    // Auto dismiss
    if (widget.showProgressBar) {
      _progressController.addStatusListener((status) {
        if (status == AnimationStatus.completed && mounted && !_isExiting) {
          _dismiss();
        }
      });
    } else {
      Future.delayed(widget.duration, () {
        if (mounted && !_isExiting) {
          _dismiss();
        }
      });
    }
  }

  void _dismiss() async {
    if (_isExiting) return;
    _isExiting = true;

    await _exitController.forward();
    widget.onDismiss();
  }

  @override
  void dispose() {
    _entryController.dispose();
    _exitController.dispose();
    _progressController.dispose();
    _iconRotationController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  SnackbarStyle _getStyle() {
    switch (widget.type) {
      case SnackbarType.success:
        return SnackbarStyle(
          backgroundColor: AppColors.primaryColor,
          accentColor: const Color(0xFF059669),
          iconColor: Colors.white,
          textColor: Colors.white,
          icon: widget.customIcon ?? Icons.check_circle_rounded,
        );
      case SnackbarType.error:
        return SnackbarStyle(
          backgroundColor: const Color(0xFFEF4444),
          accentColor: const Color(0xFFDC2626),
          iconColor: Colors.white,
          textColor: Colors.white,
          icon: widget.customIcon ?? Icons.error_rounded,
        );
      case SnackbarType.warning:
        return SnackbarStyle(
          backgroundColor: const Color(0xFFF59E0B),
          accentColor: const Color(0xFFD97706),
          iconColor: Colors.white,
          textColor: Colors.white,
          icon: widget.customIcon ?? Icons.warning_rounded,
        );
      case SnackbarType.info:
        return SnackbarStyle(
          backgroundColor: const Color(0xFF3B82F6),
          accentColor: const Color(0xFF2563EB),
          iconColor: Colors.white,
          textColor: Colors.white,
          icon: widget.customIcon ?? Icons.info_rounded,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = _getStyle();

    return AnimatedBuilder(
      animation: Listenable.merge([
        _entryController,
        _exitController,
        _progressController,
        _iconRotationController,
        _pulseController,
      ]),
      builder: (context, child) {
        final exitSlide = _isExiting
            ? Tween<double>(begin: 0, end: 100).evaluate(
            CurvedAnimation(parent: _exitController, curve: Curves.easeInCubic))
            : 0.0;

        final exitFade = _isExiting
            ? Tween<double>(begin: 1, end: 0).evaluate(_exitController)
            : 1.0;

        return Transform.translate(
          offset: Offset(0, _slideAnimation.value + exitSlide + _dragOffset),
          child: Opacity(
            opacity: _fadeAnimation.value * exitFade,
            child: Transform.scale(
              scale: _scaleAnimation.value,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: BackdropFilter(
                    filter: ColorFilter.mode(
                      Colors.black.withOpacity(0.1),
                      BlendMode.darken,
                    ),
                    child: GestureDetector(
                      onVerticalDragUpdate: (details) {
                        setState(() {
                          _dragOffset = math.max(0, details.localPosition.dy - 30);
                        });
                      },
                      onVerticalDragEnd: (details) {
                        if (_dragOffset > 50 ||
                            details.velocity.pixelsPerSecond.dy > 200) {
                          _dismiss();
                        } else {
                          setState(() {
                            _dragOffset = 0;
                          });
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              style.backgroundColor,
                              style.backgroundColor.withOpacity(0.9),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: style.backgroundColor.withOpacity(0.3),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                              spreadRadius: -5,
                            ),
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 20,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            // Animated background pattern
                            Positioned.fill(
                              child: CustomPaint(
                                painter: _BackgroundPatternPainter(
                                  color: style.accentColor.withOpacity(0.1),
                                  animation: _entryController,
                                ),
                              ),
                            ),

                            // Main content
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  // Animated icon with pulse
                                  Transform.scale(
                                    scale: _pulseAnimation.value,
                                    child: Transform.rotate(
                                      angle: _rotationAnimation.value,
                                      child: Container(
                                        width: 48,
                                        height: 48,
                                        decoration: BoxDecoration(
                                          color: style.accentColor.withOpacity(0.2),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          style.icon,
                                          color: style.iconColor,
                                          size: 28,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),

                                  // Message
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                            widget.message,
                                            style: context.theme.textTheme.titleMedium
                                        ),
                                        if (widget.actionLabel != null) ...[
                                          const SizedBox(height: 8),
                                          Material(
                                            color: Colors.transparent,
                                            child: InkWell(
                                              onTap: () {
                                                widget.onAction?.call();
                                                _dismiss();
                                              },
                                              borderRadius: BorderRadius.circular(8),
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(
                                                  horizontal: 12,
                                                  vertical: 6,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: style.iconColor.withOpacity(0.2),
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                                child: Text(
                                                  widget.actionLabel!,
                                                  style: TextStyle(
                                                    color: style.textColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),

                                  // Close button
                                  Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: _dismiss,
                                      borderRadius: BorderRadius.circular(20),
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        child: Icon(
                                          Icons.close_rounded,
                                          color: style.iconColor.withOpacity(0.7),
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Progress bar
                            if (widget.showProgressBar)
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: AnimatedBuilder(
                                  animation: _progressAnimation,
                                  builder: (context, child) {
                                    return Container(
                                      height: 3,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(16),
                                          bottomRight: Radius.circular(16),
                                        ),
                                        gradient: LinearGradient(
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                          colors: [
                                            style.accentColor,
                                            style.accentColor.withOpacity(0.5),
                                          ],
                                        ),
                                      ),
                                      child: FractionallySizedBox(
                                        alignment: Alignment.centerLeft,
                                        widthFactor: _progressAnimation.value,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: style.iconColor,
                                            borderRadius: const BorderRadius.only(
                                              bottomLeft: Radius.circular(16),
                                              bottomRight: Radius.circular(16),
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: style.iconColor.withOpacity(0.5),
                                                blurRadius: 8,
                                                offset: const Offset(0, 0),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class SnackbarStyle {
  final Color backgroundColor;
  final Color accentColor;
  final Color iconColor;
  final Color textColor;
  final IconData icon;

  const SnackbarStyle({
    required this.backgroundColor,
    required this.accentColor,
    required this.iconColor,
    required this.textColor,
    required this.icon,
  });
}

class _BackgroundPatternPainter extends CustomPainter {
  final Color color;
  final Animation<double> animation;

  _BackgroundPatternPainter({
    required this.color,
    required this.animation,
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final progress = animation.value;

    // Draw animated circles
    for (int i = 0; i < 3; i++) {
      final offset = Offset(
        size.width * (0.2 + i * 0.3),
        size.height * 0.5,
      );
      final radius = (20 + i * 10) * progress;

      canvas.drawCircle(offset, radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

enum SnackbarType {
  success,
  error,
  warning,
  info,
}

