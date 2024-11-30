

import 'package:flutter_crud_visitante/presentation/screen/index.dart';
import 'package:go_router/go_router.dart';

final mainRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage()
    ),
  ]
);