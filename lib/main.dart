import 'package:flutter/material.dart';
import 'core/constants/app_theme.dart';
import 'routes/app_routes.dart';

void main() {
  runApp(const VotingApp());
}

class VotingApp extends StatelessWidget {
  const VotingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Online Voting App',
      theme: AppTheme.theme,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.register,
      routes: AppRoutes.routes,
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}