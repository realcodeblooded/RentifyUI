import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'app_background.dart';
import 'app_layout.dart';

class AppShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const AppShell({
    super.key,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: AppLayout(
        backgroundColor: Colors.transparent,
        currentIndex: navigationShell.currentIndex,
        onTabSelected: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        child: navigationShell,
        onLogout: () {
          context.go('/auth/login');
        },
      ),
    );
  }
}
