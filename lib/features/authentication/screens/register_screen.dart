import 'dart:io';

import 'package:chips_input/chips_input.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kafil/core/components/app_dialog.dart';
import 'package:kafil/core/components/app_text_field.dart';
import 'package:kafil/core/components/custom_app_bar.dart';
import 'package:kafil/core/components/drop_down_field.dart';
import 'package:kafil/core/components/stepper/full_linear_indicator.dart';
import 'package:kafil/core/routes/animation/fade_animation_page.dart';
import 'package:kafil/core/routes/route.dart';
import 'package:kafil/core/themes/app_assets.dart';
import 'package:kafil/core/utilities/enums.dart';
import 'package:kafil/core/utilities/extensions.dart';
import 'package:kafil/core/utilities/ui_helpers.dart';
import 'package:kafil/core/utilities/validations.dart';
import 'package:kafil/features/authentication/models/app_dependencies.dart';
import 'package:kafil/features/authentication/notifiers/auth_notifier.dart';
import 'package:kafil/features/authentication/notifiers/dependencies_notifier.dart';
import 'package:kafil/features/authentication/notifiers/register_holder.dart';
import 'package:kafil/features/authentication/screens/login_screen.dart';
import 'package:kafil/features/home/screens/home_screen.dart';
import 'package:kafil/generated/locale_keys.g.dart';
import 'package:loader_overlay/loader_overlay.dart';

part '../widgets/register/first_page.dart';

part '../widgets/register/second_page.dart';

part '../widgets/register/register_steps.dart';

part '../widgets/register/submit.dart';

class RegisterScreen extends ConsumerWidget {
  static final route = NoArgRoute.page(
    name: "register",
    path: "/register",
    pageBuilder: (context, state) {
      return fadeAnimationPage(
        pageKey: state.pageKey,
        screen: const RegisterScreen(),
      );
    },
  );

  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(AuthNotifier.provider, (previous, next) {
      if (next.isLoading) {
        context.loaderOverlay.show();
      } else if (next.isSuccess) {
        context.loaderOverlay.hide();
        LoginScreen.route.navigate(context);
      } else if (next.isFailed) {
        context.loaderOverlay.hide();
        AppDialog.show(
          message: next.error.toString(),
          type: DialogType.error,
          context: context,
        );
      }
    });
    final currentPage = ref.watch(RegisterHolder.provider).currentStep;
    return Scaffold(
      backgroundColor: context.appTheme.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(
          color: context.appTheme.white,
          title: LocaleKeys.login_register.tr(),
          onBack: () {
            if (currentPage == 0) {
              context.pop();
            } else {
              ref.read(RegisterHolder.provider.notifier).currentStep = 0;
            }
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    16.verticalSpace,
                    const _RegisterSteps(),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      child: currentPage == 0
                          ? const _FirstPage()
                          : const _SecondPage(),
                    ),
                  ],
                ),
              ),
            ),
            20.verticalSpace,
            const _Submit(),
            20.verticalSpace,
          ],
        ),
      ),
    );
  }
}
