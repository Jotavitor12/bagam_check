import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'pages/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Checklist BAGAM',
      theme: AppTheme.theme,
      home: const LoginScreen(),
    );
  }
}
