import 'package:flutter/material.dart';
import 'theme.dart';
import 'router.dart';

class RentifyApp extends StatelessWidget {
  const RentifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Rentify',
      theme: AppTheme.lightTheme,
      routerConfig: routerConfig,
      debugShowCheckedModeBanner: false,
    );
  }
}
