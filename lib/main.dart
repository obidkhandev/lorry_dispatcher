import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lorry_dispatcher/core/routes/app_pages.dart';
import 'package:lorry_dispatcher/core/utills/enums.dart';
import 'package:lorry_dispatcher/core/values/app_theme.dart';
import 'package:lorry_dispatcher/features/common/bloc/main_tab/main_tab_cubit.dart';
import 'package:lorry_dispatcher/features/common/bloc/settings/settings_cubit.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:lorry_dispatcher/generated/l10n.dart';
import 'core/utills/app_update_version.dart';
import 'di.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppUpdateService.getCloudVersion();

  initDi();

  // await dotenv.load(fileName: "assets/.env");


  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => inject<MainTabCubit>()),
        BlocProvider(create: (context) => inject<SettingsCubit>()..loadAppLang()),
      ],
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return ScreenUtilInit(
              minTextAdapt: true,
              designSize: Size(
                MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height,
              ),
              builder: (context, c) {
                return GestureDetector(
                  onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                  child: MediaQuery(
                    data: MediaQuery.of(context).copyWith(
                      textScaler: const TextScaler.linear(1),
                    ),
                    child: MaterialApp.router(
                      debugShowCheckedModeBanner: false,
                      title: 'Lorry Dispatcher',
                      theme: lightTheme,
                      darkTheme: darkTheme,
                      themeMode: state.themeMode == ThemeModeState.auto
                          ? ThemeMode.system
                          : state.themeMode == ThemeModeState.dark
                          ? ThemeMode.dark
                          : ThemeMode.light,
                      locale: Locale(state.language),
                      localizationsDelegates: const [
                        GlobalMaterialLocalizations.delegate,
                        GlobalWidgetsLocalizations.delegate,
                        GlobalCupertinoLocalizations.delegate,
                        S.delegate
                      ],
                      supportedLocales: const [
                        Locale('en'),
                        Locale('ru'),
                        Locale('uz'),
                      ],
                      routerConfig: AppPages.router,
                      // navigatorKey: navigatorKey,
                      builder: (context, child) {
                        return ScrollConfiguration(
                            behavior: MyBehavior(), child: child!);
                      },
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      const ClampingScrollPhysics();
}

