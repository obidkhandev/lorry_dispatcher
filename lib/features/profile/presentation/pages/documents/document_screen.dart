import 'package:flutter/material.dart';
import 'package:lorry_dispatcher/export.dart';
import 'package:lorry_dispatcher/features/profile/presentation/pages/documents/widget/id_card_overlay.dart';

class DocumentScreen extends StatelessWidget {
  const DocumentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Documents",
      ),
      body: Column(
        children: [
          20.verticalSpace,
          IDCardOverlay().paddingSymmetric(horizontal: 16.w),
        ],
      ),
    );
  }
}
