import 'package:lorry_dispatcher/core/routes/app_routes.dart';
import 'package:lorry_dispatcher/export.dart';
import 'package:lorry_dispatcher/features/common/widget/custom_icon_widget.dart';
import 'package:lorry_dispatcher/features/home/presentation/pages/home/widget/title_with_icon.dart';

class OrderCard extends StatefulWidget {
  const OrderCard({super.key});

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _animationController;
  late Animation<double> _animation;

  final List<Map<String, dynamic>> suggestions = [
    {'name': 'FURA', 'rating': 4.5, 'price': '2 000 000'},
    {'name': 'FURA', 'rating': 4.5, 'price': '2 200 000'},
    {'name': 'ISUZU', 'rating': 4.5, 'price': '2 500 000'},
    {'name': 'FURA', 'rating': 4.5, 'price': '3 000 000'},
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text('Arnasoy', style: context.theme.textTheme.titleLarge),
              const Spacer(),
              SvgPicture.asset(AppIcons.arrowRight),
              const Spacer(),
              Text('Qarshi', style: context.theme.textTheme.titleLarge),
            ],
          ),
          const SizedBox(height: 20),

          // Truck type
          TitleWithIcon(title: "Ref fura", icon: AppIcons.truckFast),
          8.verticalSpace,
          TitleWithIcon(
            title: "Kafel bor, ertaga yuklanadi Kafel bor, ertaga yuklanadi",
            icon: AppIcons.messageText,
          ),
          8.verticalSpace,
          TitleWithIcon(title: "2 000 000", icon: AppIcons.creditCard),
          16.verticalSpace,

          // Suggestions button
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: _toggleExpansion,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: AppColors.primaryOpacity,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Spacer(),
                        Text(
                          'Takliflar',
                          style: context.theme.textTheme.titleMedium?.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                        const SizedBox(width: 8),
                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '12',
                            style: context.theme.textTheme.titleMedium
                                ?.copyWith(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.sp,
                                ),
                          ).paddingAll(6.sp),
                        ),
                        Spacer(),
                        AnimatedRotation(
                          turns: _isExpanded ? 0 : 0.5,
                          duration: const Duration(milliseconds: 300),
                          child: SvgPicture.asset(
                            AppIcons.arrowTop,
                            width: 20.w,
                          ),
                        ),
                      ],
                    ).paddingSymmetric(vertical: 8.h, horizontal: 10.w),
                  ),
                ),
              ),
              const SizedBox(width: 12),

              CustomIconWidget(
                icon: AppIcons.editSquare,
                color: AppColors.primaryOpacity,
                onTap: () {},
              ),
              6.horizontalSpace,
              CustomIconWidget(
                icon: AppIcons.delete,
                color: AppColors.primaryOpacity,
                onTap: () {},
              ),
            ],
          ),

          12.verticalSpace,
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return ClipRect(
                child: Align(
                  alignment: Alignment.topCenter,
                  heightFactor: _animation.value,
                  child: child,
                ),
              );
            },
            child: Center(
              child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (_, index) {
                  final suggestion = suggestions[index];
                  return InkWell(
                    onTap: (){
                      context.push(AppRoutes.aboutDriver);
                    },
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            suggestion['name'],
                            style: context.theme.textTheme.titleMedium,
                          ),
                        ),
                        const Spacer(),
                        Expanded(
                          flex: 1,
                          child: TitleWithIcon(title: "4.5", icon: AppIcons.star,icColor: AppColors.orange,),
                        ),
                        Spacer(),
                        Expanded(
                          flex: 2,
                          child: TitleWithIcon(
                            title: "2 000 000",
                            icon: AppIcons.creditCard,
                          ),
                        ),
                        const SizedBox(width: 8),
                        CustomIconWidget(
                          color: AppColors.primaryOpacity,
                          icon: AppIcons.chervonRight,
                          onTap: () {},
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (_, index) {
                  return 6.verticalSpace;
                },
                itemCount: 4,
              ),
            ),
          ),
          10.verticalSpace,
          Row(
            children: [
              Text('#95SDA', style: context.theme.textTheme.titleSmall),
              const Spacer(),
              Text('18:25', style: context.theme.textTheme.titleSmall),
            ],
          ),
        ],
      ).paddingSymmetric(horizontal: 16.h, vertical: 14.h),
    );
  }
}
