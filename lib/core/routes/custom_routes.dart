import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kafil/core/routes/route.dart';
import 'package:kafil/core/routes/route_observer.dart';
import 'package:kafil/features/authentication/screens/login_screen.dart';
import 'package:kafil/features/authentication/screens/register_screen.dart';
import 'package:kafil/features/home/screens/home_screen.dart';
import 'package:kafil/features/on_boarding/screens/splash_screen.dart';

mixin AppRouter {
  static final observerProvider = Provider((ref) {
    return AppRouteObserver();
  });
  static final navigatorKey = GlobalKey<NavigatorState>();

  static final provider = Provider(
    (ref) {
      final observer = ref.watch(observerProvider);
      return GoRouter(
        initialLocation: SplashScreen.route.path,
        observers: [observer],
        navigatorKey: navigatorKey,
        routes: [
          ...<AppRoute>[
            SplashScreen.route,
            LoginScreen.route,
            RegisterScreen.route,
          ].map(
            (r) => r.toGoRoute(),
          ),
          ...<AppRoute>[
            HomeScreen.route,
          ].map(
            (r) => r.toGoRoute(),
          ),
        ],
      );
    },
  );
}
