import 'package:flutter/cupertino.dart';
import 'package:lorry_dispatcher/core/values/app_text_sytle.dart';

class RowTextValue extends StatelessWidget {
  final String title, value;

  const RowTextValue({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: AppTextStyles().body16w5,
        ),
        const Spacer(),
        Text(
          value,
          style: AppTextStyles().body16w5,
        ),
      ],
    );
  }
}
