//
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:tma_mobie/core/utils/size_config.dart';
// import 'package:tma_mobie/core/values/app_colors.dart';
//
// class BottomTabItem extends StatelessWidget {
//   const BottomTabItem(
//       {super.key,
//       required int currentIndex,
//       required this.onTap,
//       required this.label,
//       required this.icon,
//       required this.index})
//       : _currentIndex = currentIndex;
//
//   final int _currentIndex;
//   final int index;
//   final Function() onTap;
//   final String label;
//   final String icon;
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           SvgPicture.asset(
//             icon,
//             height: he(22),
//             colorFilter:
//                  ColorFilter.mode(index == _currentIndex ? AppColors.primaryColor:AppColors.grey3, BlendMode.srcIn),
//           ),
//           SizedBox(height: he(6)),
//           Text(label,
//               overflow: TextOverflow.ellipsis,
//               maxLines: 1,
//               style: Theme.of(context).textTheme.titleSmall?.copyWith(
//                   color: index == _currentIndex
//                       ? AppColors.primaryColor
//                       : AppColors.grey3,
//                   fontWeight:  FontWeight.w600)),
//           SizedBox(height: he(8))
//         ],
//       ),
//     );
//   }
// }
