// import 'package:flutter/material.dart';
//
//
// class SlideToActWidget extends StatelessWidget {
//   final Future<dynamic> Function() onSubmit;
//   final String? text;
//   final Widget? icon;
//
//   const SlideToActWidget(
//       {super.key, required this.onSubmit, this.text, this.icon});
//
//   @override
//   Widget build(BuildContext context) {
//     return SlideAction(
//         text: text ?? "S.of(context).order_completion",
//         textStyle: context.theme.textTheme.titleMedium?.copyWith(
//           color: AppColors.white,
//         ),
//         innerColor: AppColors.primaryColor,
//         outerColor:
//             context.isDarkMode ? context.theme.canvasColor : AppColors.black,
//         sliderButtonIcon: icon ??
//             const Icon(
//               Icons.arrow_forward,
//               color: Colors.black,
//             ),
//         key: key,
//         onSubmit: () => onSubmit());
//   }
// }
