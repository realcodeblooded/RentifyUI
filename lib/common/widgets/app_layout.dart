import 'package:flutter/material.dart';
import 'custom_avatar.dart';
import 'custom_nav_bar.dart';

class AppLayout extends StatelessWidget {
  final Widget child;
  final String title;
  final String userName;
  final VoidCallback? onLogout;
  final Color? backgroundColor;
  final int currentIndex;
  final ValueChanged<int>? onTabSelected;

  const AppLayout({
    super.key,
    required this.child,
    this.title = 'Rentify',
    this.userName = 'Thomas',
    this.onLogout,
    this.backgroundColor,
    this.currentIndex = 0,
    this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leadingWidth: 60,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Center(
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.apartment, // Logo placeholder
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          Center(
            child: Text(
              'Hi, $userName',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 12),
          PopupMenuButton<String>(
            icon: const CustomAvatar(
              fallbackText: 'TM',
              size: 36,
            ),
            offset: const Offset(0, 48),
            onSelected: (value) {
              if (value == 'logout' && onLogout != null) {
                onLogout!();
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<String>(
                  value: 'profile',
                  child: Row(
                    children: [
                      Icon(Icons.person, size: 18),
                      SizedBox(width: 8),
                      Text('Profile'),
                    ],
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'settings',
                  child: Row(
                    children: [
                      Icon(Icons.settings, size: 18),
                      SizedBox(width: 8),
                      Text('Settings'),
                    ],
                  ),
                ),
                const PopupMenuDivider(),
                const PopupMenuItem<String>(
                  value: 'logout',
                  onTap: null,
                  child: Row(
                    children: [
                      Icon(Icons.logout, size: 18, color: Colors.red),
                      SizedBox(width: 8),
                      Text('Log out', style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
              ];
            },
          ),
          const SizedBox(width: 16),
        ],
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: Colors.white10,
            height: 1,
          ),
        ),
      ),
      backgroundColor: backgroundColor ?? Colors.white.withOpacity(0.05),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 80), // Space for nav bar
            child: child,
          ),
          if (onTabSelected != null)
            Positioned(
              top: 24,
              left: 24,
              right: 24,
              child: CustomNavBar(
                currentIndex: currentIndex,
                onTabSelected: onTabSelected!,
              ),
            ),
        ],
      ),
    );
  }
}
