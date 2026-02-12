import 'package:flutter/material.dart';
import 'core/constants/app_constants.dart';
import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';

/// アプリケーションルートウィジェット
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppConstants.appName,
      theme: AppTheme.lightTheme,
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
    );
  }
}
