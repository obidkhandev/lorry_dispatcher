import 'package:lorry_dispatcher/core/utills/helper_widget.dart';
import 'package:lorry_dispatcher/export.dart';
import 'package:lorry_dispatcher/features/home/presentation/pages/home/widget/order_card.dart';

class DriversListview extends StatelessWidget {
  final Widget card;

  const DriversListview({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      clipBehavior: Clip.none,
      padding: EdgeInsets.only(
        bottom: customButtonPadding + 20,
        top: 16.h,
        left: 16.w,
        right: 16.w,
      ),
      itemBuilder: (_, index) {
        return card;
      },
      separatorBuilder: (_, index) {
        return 10.verticalSpace;
      },
      itemCount: 10,
    );
  }
}
