
import '../../../export.dart';

class CustomFailureWidget extends StatelessWidget {
  final Function() onTap;
  final String title;

  const CustomFailureWidget(
      {super.key, required this.onTap, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: context.theme.textTheme.titleMedium,
        ),
        16.verticalSpace,
        CustomButton(
          height: 50.h,
          text: "S.of(context).retry",
          onTap: onTap,
        ),
      ],
    );
  }
}
