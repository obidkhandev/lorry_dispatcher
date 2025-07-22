// import 'package:animate_do/animate_do.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart' show SvgPicture;
// import 'package:go_router/go_router.dart';
// import 'package:lorry_dispatcher/core/values/app_colors.dart' show AppColors;
// import 'package:lorry_dispatcher/core/values/app_icons.dart';
// import 'package:lorry_dispatcher/features/common/widget/custom_button.dart';
// import 'package:lorry_dispatcher/features/common/widget/text_field_widget.dart';
//
//
// class OfferPriceDialog extends StatelessWidget {
//   const OfferPriceDialog({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return FadeIn(
//       child: Dialog(
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12.r)
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Row(
//               children: [
//                 Text(
//                   "Narx taklif qilish",
//                   style: context.theme.textTheme.titleLarge?.copyWith(
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 Spacer(),
//                 InkWell(
//                   onTap: () {
//                     context.pop();
//                   },
//                   child: SvgPicture.asset(AppIcons.cancel),
//                 ),
//               ],
//             ),
//             10.verticalSpace,
//             CustomTextField(
//               hintText: "Summa",
//               borderColor: AppColors.grey500,
//               formatter: [Formatters.priceFormatter],
//             ),
//             10.verticalSpace,
//             CustomButton(
//               text: "Taklif yuborish",
//               onTap: () {
//                 context.pop();
//               },
//             ),
//           ],
//         ).paddingAll(16.sp),
//       ),
//     );
//   }
// }
//
// showOfferPriceDialog(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (_) {
//       return OfferPriceDialog();
//     },
//   );
// }
