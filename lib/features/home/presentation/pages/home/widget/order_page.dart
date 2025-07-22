import 'package:lorry_dispatcher/core/utills/helper_widget.dart';
import 'package:lorry_dispatcher/export.dart';
import 'package:lorry_dispatcher/features/home/presentation/pages/home/widget/order_card.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
      ).copyWith(top: 20.h, bottom: customButtonPadding + 20),
      itemBuilder: (_, index) {
        return OrderCard();
      },
      separatorBuilder: (_, index) {
        return 12.verticalSpace;
      },
      itemCount: 10,
    );
  }
}
