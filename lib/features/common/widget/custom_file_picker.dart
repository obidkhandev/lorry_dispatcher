// import 'package:flutter/material.dart';
//
// class CustomFilePicker extends StatefulWidget {
//   const CustomFilePicker({super.key});
//
//   @override
//   _CustomFilePickerState createState() => _CustomFilePickerState();
// }
//
// class _CustomFilePickerState extends State<CustomFilePicker> {
//   List<PlatformFile> _selectedFiles = [];
//
//   Future<void> pickFiles() async {
//     final result = await FilePicker.platform.pickFiles(
//       allowMultiple: true,
//       type: FileType.custom,
//       allowedExtensions: ['jpg', 'png', 'pdf', 'doc', 'docx', 'txt', 'xlsx'],
//     );
//
//     if (result != null) {
//       setState(() {
//         _selectedFiles = result.files;
//       });
//     }
//   }
//
//   Widget buildFileItem(PlatformFile file) {
//     final isImage = file.extension == 'jpg' || file.extension == 'png';
//
//     return ListTile(
//       leading: isImage
//           ? Image.memory(file.bytes!, width: 50, height: 50, fit: BoxFit.cover)
//           : Icon(Icons.insert_drive_file),
//       title: Text(file.name),
//       subtitle: Text('${(file.size / 1024).toStringAsFixed(2)} KB'),
//       trailing: IconButton(
//         icon: Icon(Icons.clear),
//         onPressed: () {
//           setState(() {
//             _selectedFiles.remove(file);
//           });
//         },
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Custom File Picker')),
//       body: Column(
//         children: [
//           ElevatedButton.icon(
//             onPressed: pickFiles,
//             icon: Icon(Icons.attach_file),
//             label: Text('Select Files'),
//           ),
//           Expanded(
//             child: _selectedFiles.isEmpty
//                 ? Center(child: Text('No files selected'))
//                 : ListView(
//               children: _selectedFiles.map(buildFileItem).toList(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
