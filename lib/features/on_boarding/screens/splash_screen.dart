import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:kafil/core/components/widget_life_cycle_listener.dart';
import 'package:kafil/core/routes/route.dart';
import 'package:kafil/core/themes/app_assets.dart';
import 'package:kafil/core/utilities/extensions.dart';
import 'package:kafil/features/authentication/screens/login_screen.dart';

class SplashScreen extends StatelessWidget {
  static final route = NoArgRoute.screen(
    name: "Splash",
    path: "/splash",
    screenBuilder: (context, _) {
      return const SplashScreen();
    },
  );

  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void navigateToNextScreen(BuildContext context) {
      Future.delayed(const Duration(seconds: 4), () {
        LoginScreen.route.navigate(context);
      });
    }

    return WidgetLifecycleListener(
      onInit: () {
        navigateToNextScreen(context);
      },
      child: Scaffold(
        body: Center(
          child: FadeIn(
            duration: const Duration(seconds: 3),
            child: FadeOut(
              animate: true,
              delay: const Duration(seconds: 3),
              duration: const Duration(seconds: 1),
              child: Image.asset(
                AppAssets.logo,
                height: context.heightR(0.5),
                width: context.widthR(0.5),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
