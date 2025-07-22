// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
//
// class CustomIconWidget extends StatelessWidget {
//   final String icon;
//   final Function() onTap;
//   final double? width;
//   final double? height;
//   final Color? color;
//   final double? radius;
//   final bool? hasTitle;
//   final String? title;
//   final Color? textColor;
//   final Color? iconColor;
//
//   const CustomIconWidget({
//     super.key,
//     required this.icon,
//     required this.onTap,
//     this.width,
//     this.height,
//     this.color,
//     this.radius,
//     this.hasTitle,
//     this.title,
//     this.textColor,
//     this.iconColor,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return hasTitle != null
//         ? DecoratedBox(
//             decoration: BoxDecoration(
//               color: color,
//               borderRadius: BorderRadius.circular(radius ?? 8),
//             ),
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: wi(8), vertical: he(4)),
//               child: Row(
//                 children: [
//                   SvgPicture.asset(
//                     icon,
//                     colorFilter: ColorFilter.mode(
//                       iconColor ?? AppColors.white,
//                       BlendMode.srcIn,
//                     ),
//                     width: wi(12),
//                     height: he(12),
//                   ),
//                   SizedBox(width: wi(3)),
//                   Text(
//                     title ?? '',
//                     style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                         fontSize: he(10),
//                         fontWeight: FontWeight.w600,
//                         color: textColor),
//                   ),
//                 ],
//               ),
//             ),
//           )
//         : IconButton.filled(
//             style: IconButton.styleFrom(
//                 maximumSize: Size(width ?? 30, height ?? 30),
//                 minimumSize: Size(width ?? 30, height ?? 30),
//                 // padding: EdgeInsets.zero,
//                 backgroundColor: color ?? AppColors.primaryColor,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(radius ?? 8),
//                 )),
//             onPressed: onTap,
//             icon: SvgPicture.asset(
//               icon,
//               colorFilter:
//                    ColorFilter.mode(iconColor ?? AppColors.white, BlendMode.srcIn),
//             ),
//           );
//   }
// }
