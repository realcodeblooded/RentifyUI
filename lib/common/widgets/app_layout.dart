import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'custom_avatar.dart';
import 'custom_nav_bar.dart';

class AppLayout extends StatefulWidget {
  final Widget child;
  final String title;
  final VoidCallback? onLogout;
  final Color? backgroundColor;
  final int currentIndex;
  final ValueChanged<int>? onTabSelected;
  final FlutterSecureStorage storage;

  const AppLayout({
    super.key,
    required this.child,
    this.title = 'Rentify',
    this.onLogout,
    this.backgroundColor,
    this.currentIndex = 0,
    this.onTabSelected,
    this.storage = const FlutterSecureStorage(),
  });

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  String _avatarText = '';
  String _userName = '';

  @override
  void initState() {
    super.initState();
    _loadAvatarText();
  }

  Future<void> _loadAvatarText() async {
    final String firstName = await widget.storage.read(key: "firstName") ?? '';
    final String lastName = await widget.storage.read(key: "lastName") ?? '';
    final String avatarText = [firstName, lastName]
        .where((s) => s.isNotEmpty)
        .map((s) => s[0].toUpperCase())
        .join();

    setState(() {
      _avatarText = avatarText;
      _userName = '$firstName $lastName';
    });
  }

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
                Icons.apartment,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
        title: Text(
          widget.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          Center(
            child: Text(
              'Hi, $_userName',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 12),
          PopupMenuButton<String>(
            icon: CustomAvatar(
              fallbackText:
                  _avatarText, // fixed typo too (avartText → _avatarText)
              size: 36,
            ),
            offset: const Offset(0, 48),
            onSelected: (value) {
              if (value == 'logout' && widget.onLogout != null) {
                widget.onLogout!();
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
      backgroundColor: widget.backgroundColor ?? Colors.white.withOpacity(0.05),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 80),
            child: widget.child,
          ),
          if (widget.onTabSelected != null)
            Positioned(
              top: 24,
              left: 24,
              right: 24,
              child: CustomNavBar(
                currentIndex: widget.currentIndex,
                onTabSelected: widget.onTabSelected!,
              ),
            ),
        ],
      ),
    );
  }
}
