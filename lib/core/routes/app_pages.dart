import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lorry_dispatcher/core/resources/global_variables.dart';
import 'package:lorry_dispatcher/core/routes/app_routes.dart';
import 'package:lorry_dispatcher/features/auth/presentation/pages/login/login_screen.dart';
import 'package:lorry_dispatcher/features/auth/presentation/pages/otp/otp_screen.dart';
import 'package:lorry_dispatcher/features/auth/presentation/pages/register/register_screen.dart';
import 'package:lorry_dispatcher/features/create_order/presentation/pages/create_order/create_order_screen.dart';
import 'package:lorry_dispatcher/features/create_order/presentation/pages/select_location/select_location_screen.dart';
import 'package:lorry_dispatcher/features/home/presentation/pages/about_driver/about_driver_screen.dart';
import 'package:lorry_dispatcher/features/home/presentation/pages/home/home_screen.dart';
import 'package:lorry_dispatcher/features/home/presentation/pages/offers/offers_screen.dart';
import 'package:lorry_dispatcher/features/main_screen.dart';
import 'package:lorry_dispatcher/features/profile/presentation/pages/profile/profile_screen.dart';
import 'package:lorry_dispatcher/features/status/presentation/pages/driver_profile/driver_profile_screen.dart';
import 'package:lorry_dispatcher/features/status/presentation/pages/status/status_screen.dart';

class AppPages {
  static GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: rootNavigatorKey,
    initialLocation: AppRoutes.home,
    routes: <RouteBase>[
      GoRoute(
        name: AppRoutes.registerScreen,
        path: AppRoutes.registerScreen,
        builder: (BuildContext context, GoRouterState state) {
          return const RegisterScreen();
        },
      ),
      GoRoute(
        name: AppRoutes.otpScreen,
        path: AppRoutes.otpScreen,
        builder: (BuildContext context, GoRouterState state) {
          return const OtpScreen();
        },
      ),
      GoRoute(
        name: AppRoutes.offersScreen,
        path: AppRoutes.offersScreen,
        builder: (BuildContext context, GoRouterState state) {
          return const OffersScreen();
        },
      ),
      GoRoute(
        name: AppRoutes.loginScreen,
        path: AppRoutes.loginScreen,
        builder: (BuildContext context, GoRouterState state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
        name: AppRoutes.aboutDriver,
        path: AppRoutes.aboutDriver,
        builder: (BuildContext context, GoRouterState state) {
          return  AboutDriverScreen(isConfirm: state.extra as bool? ?? true,);
        },
      ),
      GoRoute(
        name: AppRoutes.createOrderScreen,
        path: AppRoutes.createOrderScreen,
        builder: (BuildContext context, GoRouterState state) {
          return const CreateOrderScreen();
        },
      ),
      GoRoute(
        name: AppRoutes.driverProfileScreen,
        path: AppRoutes.driverProfileScreen,
        builder: (BuildContext context, GoRouterState state) {
          return const DriverProfileScreen();
        },
      ),

      GoRoute(
        name: AppRoutes.selectLocationScreen,
        path: AppRoutes.selectLocationScreen,
        builder: (BuildContext context, GoRouterState state) {
          return const SelectLocationFromMapScreen();
        },
      ),

      StatefulShellRoute.indexedStack(
        builder:
            (
              BuildContext context,
              GoRouterState state,
              StatefulNavigationShell navigationShell,
            ) {
              return MainScreen(child: navigationShell);
            },
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutes.home,
                name: AppRoutes.home,
                builder: (BuildContext context, GoRouterState state) {
                  return HomeScreen();
                },
              ),
            ],
          ),

          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                name: AppRoutes.statusScreen,
                path: AppRoutes.statusScreen,
                builder: (BuildContext context, GoRouterState state) {
                  return const StatusScreen();
                },
              ),
            ],
          ),
          // StatefulShellBranch(
          //   routes: <RouteBase>[
          //     GoRoute(
          //       name: AppRoutes.dispatchers,
          //       path: AppRoutes.dispatchers,
          //       builder: (BuildContext context, GoRouterState state) {
          //         return const DispatchersScreen();
          //       },
          //     ),
          //   ],
          // ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                name: AppRoutes.profileScreen,
                path: AppRoutes.profileScreen,
                builder: (BuildContext context, GoRouterState state) {
                  return const ProfileScreen();
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
