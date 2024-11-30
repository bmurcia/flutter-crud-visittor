import 'package:flutter/material.dart';
import 'package:flutter_crud_visitante/presentation/router/main_router.dart';
import 'package:flutter_crud_visitante/presentation/style/main_theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: buidlMainTheme(context),
      routerConfig: mainRouter,
    );
  }
}
