import 'package:flutter/material.dart';
import 'package:lorry_dispatcher/core/routes/app_routes.dart';
import 'package:lorry_dispatcher/core/utills/helper_widget.dart';
import 'package:lorry_dispatcher/export.dart';
import 'package:lorry_dispatcher/features/payment/data/models/card_model.dart';
import 'package:lorry_dispatcher/features/payment/presentation/part/crard_bottom_sheeet.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {


  List<CreditCard> cards = [
    CreditCard(
      id: '1',
      holderName: 'KAMOLXONOV JALOLXON',
      cardNumber: '6262 **** **** 3751',
      bankLogo: 'U',
      cardColor: const Color(0xFF2E7D8A),
      isPrimary: true,
      isActive: true,
    ),
    CreditCard(
      id: '2',
      holderName: 'Abduraximov Obidxon'.toUpperCase(),
      cardNumber: '6262 **** **** 3751',
      bankLogo: 'U',
      cardColor: const Color(0xFF2E7D8A),
      isPrimary: false,
      isActive: true,
    ),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Kartaga o'tkazmalar"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          20.verticalSpace,
          DecoratedBox(
            decoration: AppDecoration.cardDecoration(
              context,
            ).copyWith(boxShadow: []),
            child: Row(
              children: [
                SvgPicture.asset(
                  AppIcons.creditCard,
                  color: AppColors.primaryColor,
                  width: 30.w,
                  height: 30.h,
                ),
                10.horizontalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "To'lovga tasdiqlangan",
                      style: context.theme.textTheme.titleMedium,
                    ),
                    RichText(
                      text: TextSpan(
                        style: context.theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                        text: "22.00",
                        children: [
                          TextSpan(
                            text: " so'm",
                            style: context.theme.textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ).paddingSymmetric(horizontal: 16.w, vertical: 20.h),
          ),
          20.verticalSpace,
          Text("Mening kartalarim", style: context.theme.textTheme.titleMedium),
          16.verticalSpace,
          CustomButton(
            text: "Karta qo'shish",
            icon: AppIcons.add,
            onTap: () {

              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                isScrollControlled: true,
                builder: (context) => CreditCardBottomSheet(
                  cards: cards,
                  onCardSelected: (card) {
                    print('Selected card: ${card.holderName}');
                  },
                  onCardDeleted: (cardId) {
                    setState(() {
                      cards.removeWhere((card) => card.id == cardId);
                    });
                  },
                  onCardMadePrimary: (cardId) {
                    setState(() {
                      cards = cards.map((card) {
                        return card.copyWith(isPrimary: card.id == cardId);
                      }).toList();
                    });
                  },
                  onAddCard: () {
                    Navigator.pop(context);
                    context.push(AppRoutes.addCardScreen);
                  },
                ),
              );
            },
          ),
        ],
      ).paddingSymmetric(horizontal: 16.w),
    );
  }
}

