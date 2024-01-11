import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kafil/core/components/app_dialog.dart';
import 'package:kafil/core/components/app_text_field.dart';
import 'package:kafil/core/components/custom_app_bar.dart';
import 'package:kafil/core/routes/animation/fade_animation_page.dart';
import 'package:kafil/core/routes/guards/guard_group.dart';
import 'package:kafil/core/routes/guards/splash_guard.dart';
import 'package:kafil/core/routes/route.dart';
import 'package:kafil/core/themes/app_assets.dart';
import 'package:kafil/core/utilities/enums.dart';
import 'package:kafil/core/utilities/extensions.dart';
import 'package:kafil/core/utilities/validations.dart';
import 'package:kafil/features/authentication/notifiers/auth_notifier.dart';
import 'package:kafil/features/authentication/notifiers/login_holder.dart';
import 'package:kafil/features/authentication/screens/register_screen.dart';
import 'package:kafil/features/home/screens/home_screen.dart';
import 'package:kafil/generated/locale_keys.g.dart';
import 'package:loader_overlay/loader_overlay.dart';

part '../widgets/login/login_header.dart';

part '../widgets/login/login_form.dart';

part '../widgets/login/login_actions.dart';

class LoginScreen extends ConsumerWidget {
  static final route = NoArgRoute.page(
    name: "login",
    path: "/login",
    guard: const RouteGuardGroup([AuthenticationGuard()]),
    pageBuilder: (context, state) {
      return fadeAnimationPage(
        pageKey: state.pageKey,
        screen: const LoginScreen(),
      );
    },
  );

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(AuthNotifier.provider, (previous, next) {
      if (next.isLoading) {
        context.loaderOverlay.show();
      } else if (next.isSuccess) {
        context.loaderOverlay.hide();
        HomeScreen.route.push(context);
      } else if (next.isFailed) {
        context.loaderOverlay.hide();
        AppDialog.show(
          message: next.error.toString(),
          type: DialogType.error,
          context: context,
        );
      }
    });
    return Scaffold(
      backgroundColor: context.appTheme.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(
          title: LocaleKeys.login_title.tr(),
          color: context.appTheme.white,
        ),
      ),
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _LoginHeader(),
            _LoginForm(),
            _LoginActions(),
          ],
        ),
      ),
    );
  }
}
