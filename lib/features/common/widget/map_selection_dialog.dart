// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// class MapSelectionDialog extends StatelessWidget {
//   final double latitude;
//   final double longitude;
//
//   const MapSelectionDialog(
//       {super.key, required this.latitude, required this.longitude});
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       backgroundColor: AppColors.white,
//       title: Text(
//         'Select Map App',
//         style: Theme.of(context).textTheme.headlineLarge,
//       ),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           ListTile(
//             leading: SvgPicture.asset(AppIcons.icLocation),
//             title: Text('Google Maps',style: Theme.of(context).textTheme.bodyLarge,),
//             onTap: () => _launchMapApp('google', context),
//           ),
//           ListTile(
//             leading: SvgPicture.asset(AppIcons.icLocation),
//             title: Text('Apple Maps',style: Theme.of(context).textTheme.bodyLarge,),
//             onTap: () => _launchMapApp('apple', context),
//           ),
//           ListTile(
//             leading: SvgPicture.asset(AppIcons.icLocation),
//             title: Text('Waze Maps',style: Theme.of(context).textTheme.bodyLarge,),
//             onTap: () => _launchMapApp('waze', context),
//           ),
//           ListTile(
//             leading: SvgPicture.asset(AppIcons.icLocation),
//             title: Text('Yandex Maps',style: Theme.of(context).textTheme.bodyLarge,),
//
//             onTap: () => _launchMapApp('yandex', context),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _launchMapApp(String app, BuildContext context) async {
//     Navigator.of(context).pop(); // Close the dialog
//     String url;
//
//     switch (app) {
//       case 'google':
//         url =
//             'https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude';
//         break;
//       case 'apple':
//         url = 'https://maps.apple.com/?daddr=$latitude,$longitude';
//         break;
//       case 'waze':
//         url = 'https://waze.com/ul?ll=$latitude,$longitude&navigate=yes';
//         break;
//       case 'yandex':
//         url = 'yandexmaps://maps.yandex.com/?pt=$latitude,$longitude&z=<zoom>&l=map';
//         break;
//       default:
//         url = '';
//     }
//
//     Uri uri = Uri.parse(url);
//
//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri);
//     } else {
//       // Handle error
//       debugPrint('Could not launch $url');
//     }
//   }
// }
