import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud_visitante/firebase_options.dart';
import 'package:flutter_crud_visitante/presentation/router/main_router.dart';
import 'package:flutter_crud_visitante/presentation/style/main_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
