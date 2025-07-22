// import 'package:axy_driver/core/extension/for_context.dart';
// import 'package:axy_driver/core/values/app_colors.dart';
// import 'package:axy_driver/core/values/app_text_sytle.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// class CustomAnimatedButton extends StatefulWidget {
//   final VoidCallback? onClicked;
//   final String subtitle;
//   final Duration? animatedDuration;
//
//   const CustomAnimatedButton({
//     super.key,
//     this.onClicked,
//     required this.subtitle,
//     this.animatedDuration,
//   });
//
//   @override
//   _AnimatedButtonState createState() => _AnimatedButtonState();
// }
//
// class _AnimatedButtonState extends State<CustomAnimatedButton>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: widget.animatedDuration,
//     )..repeat(reverse: true);
//
//     _animation = Tween<double>(begin: 1.0, end: 0.0).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: Curves.easeInOut,
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: widget.onClicked,
//       child: Stack(
//         children: [
//           Container(
//             height: 60.h,
//             decoration: BoxDecoration(
//               color: context.isDarkMode ? AppColors.c0F1A07 : AppColors.black,
//               borderRadius: BorderRadius.circular(10.r),
//             ),
//           ),
//           AnimatedBuilder(
//             animation: _animation,
//             builder: (context, child) {
//               return FractionallySizedBox(
//                 widthFactor: _animation.value,
//                 child: Container(
//                   height: 60.h,
//                   decoration: BoxDecoration(
//                     color: AppColors.primaryColor,
//                     borderRadius: BorderRadius.circular(10.r),
//                   ),
//                 ),
//               );
//             },
//           ),
//           Positioned.fill(
//             child: Center(
//               child: Text.rich(
//                 TextSpan(
//                     text: "Принять\n",
//                     style: AppTextStyles().body18w6.copyWith(
//                       color: AppColors.white,
//                     ),
//                     children: [
//                       TextSpan(
//                         text: widget.subtitle,
//                         style: AppTextStyles().body14w4.copyWith(
//                           color: AppColors.white,
//                         ),
//                       ),
//                     ]),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }