import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lorry_dispatcher/core/api/list_api.dart';
import 'package:lorry_dispatcher/core/routes/app_routes.dart';
import 'package:lorry_dispatcher/core/utills/general_functions.dart';
import 'package:lorry_dispatcher/core/utills/helper_widget.dart';
import 'package:lorry_dispatcher/features/common/bloc/settings/settings_cubit.dart';
import 'package:lorry_dispatcher/features/common/widget/custom_network_image.dart';
import 'package:lorry_dispatcher/features/common/widget/custom_yes_no_dialog.dart';
import 'package:lorry_dispatcher/features/profile/data/models/profile_action_model.dart';
import 'package:lorry_dispatcher/features/profile/presentation/pages/profile/widget/language_bottom_sheet.dart';
import 'package:lorry_dispatcher/features/profile/presentation/pages/profile/widget/profile_section.dart';
import 'package:lorry_dispatcher/features/profile/presentation/pages/profile/widget/theme_bottom_sheet.dart';

import '../../../../../../../../export.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isCollapsed = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    const double expandedHeight = 200.0;
    const double collapsedHeight = kToolbarHeight;
    const double collapseThreshold = expandedHeight - collapsedHeight - 50;

    final bool shouldCollapse =
        _scrollController.hasClients &&
            _scrollController.offset > collapseThreshold;

    if (shouldCollapse != _isCollapsed) {
      setState(() {
        _isCollapsed = shouldCollapse;
      });
    }
  }

  Widget _buildCollapsedTitle(BuildContext context) {
    return AnimatedOpacity(
      opacity: _isCollapsed ? 1.0 : 0.0,
      duration: Duration(milliseconds: 200),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Liam Harrison", // Dynamic, not replaced
            style: context.theme.textTheme.titleMedium?.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            "Chevrolet Fura AA123BB", // Dynamic, not replaced
            style: context.theme.textTheme.displayMedium?.copyWith(
              fontSize: 12.sp,
              color: context.theme.textTheme.displayMedium?.color?.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            expandedHeight: 200.h,
            floating: false,
            pinned: true,
            elevation: 0,
            backgroundColor: context.theme.scaffoldBackgroundColor,
            surfaceTintColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 60.h),
                    CustomCachedNetworkImage(
                      width: 100.w,
                      height: 100.h,
                      iconSize: 60.sp,
                      radius: BorderRadius.circular(100.r),
                      fit: BoxFit.cover,
                      imageUrl: profileImage,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      "Liam Harrison", // Dynamic, not replaced
                      style: context.theme.textTheme.titleMedium?.copyWith(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      "Chevrolet Fura AA123BB", // Dynamic, not replaced
                      style: context.theme.textTheme.displayMedium?.copyWith(
                        fontSize: 14.sp,
                        color: context.theme.textTheme.displayMedium?.color?.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
              collapseMode: CollapseMode.parallax,
            ),
            title: _buildCollapsedTitle(context),
            titleSpacing: 16.w,
            actions: [
              TextButton(
                onPressed: () {},
                child: Text(
                  S.of(context).edit, // Replaced "Edit"
                  style: context.theme.textTheme.titleMedium?.copyWith(
                    color: AppColors.brandElectric,
                  ),
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: context.theme.cardColor,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: ProfileSection(
                title: S.of(context).balanceAndRating, // Replaced "Balance and rating"
                actions: [
                  ProfileActionModel(
                    title: "200 000 uzs", // Dynamic, not replaced
                    onTap: () {
                      // context.push(AppRoutes.balance);
                    },
                    icColor: AppColors.white,
                    icon: AppIcons.dollarCircle,
                  ),
                  ProfileActionModel(
                    title: "Rating 5", // Dynamic, not replaced
                    icColor: AppColors.white,
                    icon: AppIcons.creditCard,
                  ),
                ],
              ).paddingAll(12.sp),
            ).paddingSymmetric(horizontal: 16.w, vertical: 8.h),
          ),
          SliverToBoxAdapter(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: context.theme.cardColor,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: BlocBuilder<SettingsCubit, SettingsState>(
                builder: (context, state) {
                  return ProfileSection(
                    title: S.of(context).settings, // Already using S.of(context).settings
                    actions: [
                      ProfileActionModel(
                        title: S.of(context).notification, // Replaced "notification"
                        icColor: AppColors.white,
                        onTap: () async {},
                        tralingWidget: CupertinoSwitch(
                          value: false,
                          onChanged: (v) {},
                        ),
                        icon: AppIcons.notifications,
                      ),
                      ProfileActionModel(
                        title: S.of(context).theme, // Already using S.of(context).theme
                        icColor: AppColors.white,
                        onTap: () async {
                          showThemeBottomSheet(context);
                        },
                        tralingWidget: Row(
                          children: [
                            Text(
                              MyFunctions.themeName(state.themeMode, context),
                              style: context.theme.textTheme.displayMedium?.copyWith(fontSize: 16.sp),
                            ),
                            SvgPicture.asset(
                              AppIcons.arrowRight,
                              colorFilter: AppColors.colorFilter(
                                context.isDarkMode ? AppColors.grey4 : AppColors.black,
                              ),
                            ),
                          ],
                        ),
                        icon: AppIcons.moon,
                      ),
                      ProfileActionModel(
                        title: S.of(context).language, // Replaced "Language"
                        onTap: () {
                          showLanguageSelectionBottomSheet(
                            context: context,
                            selectedLanguage: state.language,
                            onLanguageSelected: (lang) {
                              context.read<SettingsCubit>().saveAppLang(lang);
                            },
                          );
                        },
                        icColor: AppColors.white,
                        icon: AppIcons.languageSquare,
                        tralingWidget: Row(
                          children: [
                            Text(
                              MyFunctions.languageName(state.language, context),
                              style: context.theme.textTheme.displayMedium?.copyWith(fontSize: 16.sp),
                            ),
                            SvgPicture.asset(
                              AppIcons.arrowRight,
                              colorFilter: AppColors.colorFilter(
                                context.isDarkMode ? AppColors.grey4 : AppColors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ).paddingAll(12.sp),
            ).paddingSymmetric(horizontal: 16.w, vertical: 8.h),
          ),
          SliverToBoxAdapter(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: context.theme.cardColor,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: ProfileSection(
                title: S.of(context).additional, // Replaced "Additional"
                actions: [
                  ProfileActionModel(
                    title: S.of(context).privacyPolicy, // Replaced "privacy_policy"
                    icColor: AppColors.white,
                    onTap: () async {
                      await MyFunctions.launchMyUrl(ListAPI.baseUrl);
                    },
                    icon: AppIcons.infoCircle,
                  ),
                  ProfileActionModel(
                    title: S.of(context).licenseAgreement, // Replaced "license_agreement"
                    icColor: AppColors.white,
                    onTap: () async {
                      await MyFunctions.launchMyUrl(ListAPI.baseUrl);
                    },
                    icon: AppIcons.home,
                  ),
                  ProfileActionModel(
                    title: S.of(context).version, // Replaced "Version"
                    icColor: AppColors.white,
                    icon: AppIcons.infoCircle,
                    tralingWidget: Text(
                      "0.0.1+7", // Dynamic, not replaced
                      style: context.theme.textTheme.titleMedium?.copyWith(
                        color: context.theme.textTheme.titleMedium?.color?.withOpacity(0.6),
                      ),
                    ),
                  ),
                ],
              ).paddingAll(12.sp),
            ).paddingSymmetric(horizontal: 16.w, vertical: 8.h),
          ),
          SliverToBoxAdapter(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: context.theme.cardColor,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: ProfileSection(
                title: S.of(context).deleteAndLogout, // Replaced "Delete and logout"
                actions: [
                  ProfileActionModel(
                    title: S.of(context).logout, // Replaced "logout"
                    onTap: () {
                      CustomYesNoDialog(
                        onYes: () {
                          context.pop();
                          context.go(AppRoutes.loginScreen);
                        },
                        onNo: () {
                          context.pop();
                        },
                        title: S.of(context).confirmLogout, // Already using S.of(context).confirmLogout
                      ).show(context);
                    },
                    icColor: AppColors.white,
                    icon: AppIcons.logout,
                  ),
                  ProfileActionModel(
                    title: S.of(context).deleteAllProfiles, // Replaced "delete_all_profiles"
                    icColor: AppColors.white,
                    icon: AppIcons.delete,
                  ),
                ],
              ).paddingAll(12.sp),
            ).paddingSymmetric(horizontal: 16.w, vertical: 8.h),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: Text(
                textAlign: TextAlign.center,
                S.of(context).poweredBy,
                style: context.theme.textTheme.titleSmall,
              ),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: customButtonPadding)),
        ],
      ),
    );
  }
}