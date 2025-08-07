import 'package:lorry_dispatcher/core/routes/app_routes.dart';
import 'package:lorry_dispatcher/export.dart';

class MyCardsBottomsheet extends StatelessWidget {
  const MyCardsBottomsheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomButton(
          text: "Add new card",
          onTap: () {
            context.push(AppRoutes.addCardScreen);
          },
        ),
      ],
    );
  }
}

showMyCardsBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (_) {
      return MyCardsBottomsheet();
    },
  );
}
