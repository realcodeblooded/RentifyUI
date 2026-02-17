import 'package:flutter/material.dart';
import 'package:rentifyui/features/auth/service/auth_provider.dart';
import 'package:provider/provider.dart';
import 'router.dart';
import 'theme.dart';

class RentifyApp extends StatelessWidget {
  const RentifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp.router(
        title: 'Rentify',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        routerConfig: routerConfig,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
