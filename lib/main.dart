import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'pages/login_screen.dart';

void main() {
  runApp(const BagamCheckApp());
}

class BagamCheckApp extends StatelessWidget {
  const BagamCheckApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BAGAM Check',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme, // ✅ Usando seu tema centralizado
      home: const LoginScreen(),
    );
  }
}

