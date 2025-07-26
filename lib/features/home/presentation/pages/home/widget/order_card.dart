import 'package:lorry_dispatcher/core/routes/app_routes.dart';
import 'package:lorry_dispatcher/export.dart';

class OrderCard extends StatefulWidget {
  const OrderCard({super.key});

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> with TickerProviderStateMixin {
  // Separate states for each button
  bool _isOffersExpanded = false;
  bool _isEmptyTrucksExpanded = false;

  // Separate animation controllers for each button
  late AnimationController _offersAnimationController;
  late AnimationController _emptyTrucksAnimationController;
  late Animation<double> _offersAnimation;
  late Animation<double> _emptyTrucksAnimation;

  final List<Map<String, dynamic>> suggestions = [
    {'name': 'FURA', 'rating': 4.5, 'price': '2 000 000'},
    {'name': 'FURA', 'rating': 4.5, 'price': '2 200 000'},
    {'name': 'ISUZU', 'rating': 4.5, 'price': '2 500 000'},
    {'name': 'FURA', 'rating': 4.5, 'price': '3 000 000'},
  ];

  final List<Map<String, dynamic>> emptyTrucks = [
    {'name': 'Xumoyunmirzo Y.', 'rating': 4.2, 'location': '3.3 km'},
    {'name': 'Alisher A.', 'rating': 4.7, 'location': '3.5 km'},
    {'name': 'Ozodbek B.', 'rating': 4.3, 'location': '2.3 km'},
  ];

  @override
  void initState() {
    super.initState();

    // Initialize first animation controller (Offers)
    _offersAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _offersAnimation = CurvedAnimation(
      parent: _offersAnimationController,
      curve: Curves.easeInOut,
    );

    // Initialize second animation controller (Empty Trucks)
    _emptyTrucksAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _emptyTrucksAnimation = CurvedAnimation(
      parent: _emptyTrucksAnimationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _offersAnimationController.dispose();
    _emptyTrucksAnimationController.dispose();
    super.dispose();
  }

  void _toggleOffersExpansion() {
    setState(() {
      _isOffersExpanded = !_isOffersExpanded;
      if (_isOffersExpanded) {
        _offersAnimationController.forward();
      } else {
        _offersAnimationController.reverse();
      }
    });
  }

  void _toggleEmptyTrucksExpansion() {
    setState(() {
      _isEmptyTrucksExpanded = !_isEmptyTrucksExpanded;
      if (_isEmptyTrucksExpanded) {
        _emptyTrucksAnimationController.forward();
      } else {
        _emptyTrucksAnimationController.reverse();
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
              10.horizontalSpace,
              PopupMenuButton<String>(
                color: context.theme.cardColor,
                padding: EdgeInsets.zero,
                onSelected: (String value) {
                  // Handle menu item selection
                  switch (value) {
                    case 'edit':
                      break;
                    case 'delete':
                      break;
                    case 'share':
                      break;
                  }
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    value: 'share',
                    child: ListTile(
                      leading: SvgPicture.asset(
                        AppIcons.share,
                        width: 18.w,
                        color: context.theme.iconTheme.color,
                      ),
                      title: Text(
                        'Ulashish',
                        style: context.theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 8),
                      visualDensity: VisualDensity.compact,
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'edit',
                    child: ListTile(
                      leading: SvgPicture.asset(
                        AppIcons.edit2,
                        width: 18.w,
                        color: context.theme.iconTheme.color
                      ),
                      title: Text(
                        'O\'zgartirish',
                        style: context.theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 8),
                      visualDensity: VisualDensity.compact,
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'delete',
                    child: ListTile(
                      leading: SvgPicture.asset(AppIcons.delete, width: 18.w),
                      title: Text(
                        'O\'chirish',
                        style: context.theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                          color: AppColors.red,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 8),
                      visualDensity: VisualDensity.compact,
                    ),
                  ),
                ],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 3,
                offset: Offset(0, 40),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SvgPicture.asset(AppIcons.moreIc, height: 20.h),
                ),
              ),
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

          // Buttons row
          Row(
            children: [
              // Offers button
              Expanded(
                child: SizedBox(
                  height: 45.h,
                  child: GestureDetector(
                    onTap: _toggleOffersExpansion,
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
                            S.of(context).offers,
                            style: context.theme.textTheme.titleMedium
                                ?.copyWith(
                                  color: AppColors.primaryColor,
                                  fontSize: 14.sp,
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
                            turns: _isOffersExpanded ? 0 : 0.5,
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
              ),
              const SizedBox(width: 12),
              // Empty trucks button
              Expanded(
                child: SizedBox(
                  height: 45.h,
                  child: GestureDetector(
                    onTap: _toggleEmptyTrucksExpansion,
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
                            "Bo'sh mashinalar",
                            style: context.theme.textTheme.titleMedium
                                ?.copyWith(
                                  color: AppColors.primaryColor,
                                  fontSize: 14.sp,
                                ),
                          ),
                          Spacer(),
                          AnimatedRotation(
                            turns: _isEmptyTrucksExpanded ? 0 : 0.5,
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
              ),
            ],
          ),

          12.verticalSpace,

          // Offers list
          AnimatedBuilder(
            animation: _offersAnimation,
            builder: (context, child) {
              return ClipRect(
                child: Align(
                  alignment: Alignment.topCenter,
                  heightFactor: _offersAnimation.value,
                  child: child,
                ),
              );
            },
            child: _isOffersExpanded
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Takliflar',
                        style: context.theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      8.verticalSpace,
                      ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (_, index) {
                          final suggestion = suggestions[index];
                          return InkWell(
                            onTap: () {
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
                                  child: TitleWithIcon(
                                    title: "4.5",
                                    icon: AppIcons.star,
                                    icColor: AppColors.orange,
                                  ),
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
                                  onTap: () {
                                    context.push(AppRoutes.aboutDriver);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (_, index) {
                          return 6.verticalSpace;
                        },
                        itemCount: suggestions.length,
                      ),
                      16.verticalSpace,
                    ],
                  )
                : SizedBox.shrink(),
          ),

          // Empty trucks list
          AnimatedBuilder(
            animation: _emptyTrucksAnimation,
            builder: (context, child) {
              return ClipRect(
                child: Align(
                  alignment: Alignment.topCenter,
                  heightFactor: _emptyTrucksAnimation.value,
                  child: child,
                ),
              );
            },
            child: _isEmptyTrucksExpanded
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Bo'sh mashinalar",
                        style: context.theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      8.verticalSpace,
                      ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (_, index) {
                          final truck = emptyTrucks[index];
                          return InkWell(
                            onTap: () {
                              context.push(AppRoutes.aboutDriver, extra: false);
                            },
                            child: Row(
                              // crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    truck['name'],
                                    maxLines: 1,
                                    overflow: TextOverflow.visible,
                                    style: context.theme.textTheme.titleMedium,
                                  ),
                                ),
                                const Spacer(),
                                Expanded(
                                  flex: 2,
                                  child: TitleWithIcon(
                                    title: truck['rating'].toString(),
                                    icon: AppIcons.star,
                                    icColor: AppColors.orange,
                                  ),
                                ),
                                // Spacer(),
                                Expanded(
                                  flex: 2,
                                  child: TitleWithIcon(
                                    title: truck['location'],
                                    icon: AppIcons.location,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                CustomIconWidget(
                                  color: AppColors.primaryOpacity,
                                  icon: AppIcons.chervonRight,
                                  onTap: () {
                                    context.push(
                                      AppRoutes.aboutDriver,
                                      extra: false,
                                    );
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (_, index) {
                          return 6.verticalSpace;
                        },
                        itemCount: emptyTrucks.length,
                      ),
                      16.verticalSpace,
                    ],
                  )
                : SizedBox.shrink(),
          ),

          10.verticalSpace,
          Row(
            children: [
              Text('#95SDA', style: context.theme.textTheme.titleSmall),
              const Spacer(),
              Text(DateTime.now().toDateAndTimeFormat(), style: context.theme.textTheme.titleSmall),
            ],
          ),
        ],
      ).paddingSymmetric(horizontal: 16.h, vertical: 14.h),
    );
  }
}
