import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lorry_dispatcher/core/resources/global_variables.dart';
import 'package:lorry_dispatcher/core/routes/app_routes.dart';
import 'package:lorry_dispatcher/features/home/presentation/pages/home/home_screen.dart';
import 'package:lorry_dispatcher/features/main_screen.dart';
import 'package:lorry_dispatcher/features/profile/presentation/pages/profile/profile_screen.dart';

class AppPages {
  static GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: rootNavigatorKey,
    initialLocation: AppRoutes.home,
    routes: <RouteBase>[

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
          // if (di<SharedPreferences>().getBool(SharedModel.isLegal) == true)
          //   StatefulShellBranch(
          //     routes: <RouteBase>[
          //       GoRoute(
          //         name: AppRoutes.legalCars,
          //         path: AppRoutes.legalCars,
          //         pageBuilder: (BuildContext context, GoRouterState state) {
          //           return buildPageWithDefaultTransition<void>(
          //               context: context,
          //               state: state,
          //               child: const LegalMyCarsScreen());
          //         },
          //       ),
          //     ],
          //   )
          // else
          // StatefulShellBranch(
          //   routes: <RouteBase>[
          //     GoRoute(
          //       name: AppRoutes.cars,
          //       path: AppRoutes.cars,
          //       builder: (BuildContext context, GoRouterState state) {
          //         return const CarsPage();
          //       },
          //     ),
          //   ],
          // ),
          // StatefulShellBranch(
          //   routes: <RouteBase>[
          //     GoRoute(
          //       name: AppRoutes.facilitiesPage,
          //       path: AppRoutes.facilitiesPage,
          //       builder: (BuildContext context, GoRouterState state) {
          //         return const FacilitiesPage();
          //       },
          //     ),
          //   ],
          // ),
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
