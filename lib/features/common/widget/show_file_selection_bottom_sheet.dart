// import 'dart:io';
//
// import 'package:axy_driver/export.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// /// Reusable modal bottom sheet for picking an image or file.
// ///
// /// Returns a [File] or `null` if nothing is selected.
// /// [showFileOption] controls whether to show the file picker option.
// Future<File?> showFileSelectionSheet({
//   required BuildContext context,
//   bool showFileOption = true,
//   bool showGalleryOption = true,
// }) async {
//   final picker = ImagePicker();
//   File? selectedFile;
//
//   await showModalBottomSheet(
//     context: context,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
//     ),
//     builder: (context) {
//       return SafeArea(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             ListTile(
//               leading: Icon(Icons.camera_alt, color: AppColors.primaryColor),
//               title: Text('Камера', style: context.theme.textTheme.titleMedium),
//               onTap: () async {
//                 final pickedFile = await picker.pickImage(source: ImageSource.camera);
//                 if (pickedFile != null) {
//                   print("Picked file is not null");
//                   selectedFile = File(pickedFile.path);
//                 }
//                 Navigator.pop(context);
//
//               },
//             ),
//             if(showGalleryOption)
//             ListTile(
//               leading: Icon(Icons.photo, color: AppColors.primaryColor),
//               title: Text('Галерея', style: context.theme.textTheme.titleMedium),
//               onTap: () async {
//                 final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//                 if (pickedFile != null) {
//                   print("Picked file is not null");
//                   selectedFile = File(pickedFile.path);
//                 }
//                 Navigator.pop(context);
//               },
//             ),
//             if (showFileOption)
//               ListTile(
//                 leading: Icon(Icons.folder, color: AppColors.primaryColor),
//                 title: Text('Файлы', style: context.theme.textTheme.titleMedium),
//                 onTap: () async {
//                   final status = await Permission.storage.request();
//                   if (status.isGranted) {
//                     final result = await FilePicker.platform.pickFiles(type: FileType.any);
//                     if (result != null && result.files.single.path != null) {
//                       selectedFile = File(result.files.single.path!);
//                     }
//                   } else {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(content: Text('Отказано в доступе к файлу')),
//                     );
//                   }
//                   Navigator.pop(context);
//                 },
//               ),
//             10.verticalSpace,
//           ],
//         ).paddingSymmetric(vertical: 10.h),
//       );
//     },
//   );
//   print(selectedFile);
//   return selectedFile;
// }
