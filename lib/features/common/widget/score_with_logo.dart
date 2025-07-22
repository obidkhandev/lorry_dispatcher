// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:lorry_driver/core/resources/assets/icons/app_icons.dart';
//
// class ScoreWithLogo extends StatelessWidget {
//   final bool isDisable;
//   final String score;
//
//   const ScoreWithLogo(
//       {super.key, required this.isDisable, required this.score});
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         SvgPicture.asset(
//           isDisable ? AppIcons.logoMarkBlack2 : AppIcons.logoMarkDisable,
//         ),
//         10.horizontalSpace,
//         Text(
//           "$score баллов",
//           style: context.theme.textTheme.titleMedium?.copyWith(
//             fontSize: 24.sp,
//           ),
//         ),
//       ],
//     );
//   }
// }
