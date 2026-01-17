import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../common/widgets/app_shell.dart';
import '../features/landing/screens/landing_screen.dart';
import '../features/auth/screens/login_screen.dart';
import '../features/landlord/dashboard/tabs/metrics_tab.dart';
import '../features/landlord/dashboard/tabs/properties_tab.dart';
import '../features/landlord/dashboard/tabs/units_tab.dart';
import '../features/landlord/dashboard/tabs/requests_tab.dart';
import '../features/landlord/dashboard/tabs/vacate_tab.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

final GoRouter routerConfig = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LandingScreen(),
    ),
    GoRoute(
      path: '/auth/login',
      builder: (context, state) => const LoginScreen(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return AppShell(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
                path: '/dashboard', // Defaults to metrics
                builder: (context, state) => const MetricsTab(),
                routes: [
                  GoRoute(
                      path: 'metrics',
                      builder: (context, state) =>
                          const MetricsTab()), // Redundant but explicit? Or usually just /dashboard is metrics
                ]),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/dashboard/properties',
              builder: (context, state) => const PropertiesTab(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/dashboard/units',
              builder: (context, state) => const UnitsTab(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/dashboard/requests',
              builder: (context, state) => const RequestsTab(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/dashboard/vacate',
              builder: (context, state) => const VacateTab(),
            ),
          ],
        ),
      ],
    ),
  ],
);
