import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rentifyui/features/auth/service/auth_provider.dart';
import 'app_background.dart';
import 'app_layout.dart';

class AppShell extends StatefulWidget {
  final StatefulNavigationShell navigationShell;
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  const AppShell({
    super.key,
    required this.navigationShell,
  });

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  @override
  Widget build(BuildContext context) {
    void handleLogout() async {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final userId = await widget.storage.read(key: "userId");
      try {
        await authProvider.logout(userId!);
        if (mounted) {
          context.go('/auth/login');
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: "Oops! Logout Failed",
              message: "$e\nPlease try again",
              contentType: ContentType.failure,
            ),
          ),
        );
      }
    }

    return AppBackground(
      child: AppLayout(
        backgroundColor: Colors.transparent,
        currentIndex: widget.navigationShell.currentIndex,
        onTabSelected: (index) {
          widget.navigationShell.goBranch(
            index,
            initialLocation: index == widget.navigationShell.currentIndex,
          );
        },
        onLogout: handleLogout,
        child: widget.navigationShell,
      ),
    );
  }
}
