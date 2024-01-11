import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kafil/core/components/custom_app_bar.dart';
import 'package:kafil/core/components/fade_indexed_stack.dart';
import 'package:kafil/core/routes/animation/fade_animation_page.dart';
import 'package:kafil/core/routes/guards/guard_group.dart';
import 'package:kafil/core/routes/guards/splash_guard.dart';
import 'package:kafil/core/routes/route.dart';
import 'package:kafil/core/themes/app_assets.dart';
import 'package:kafil/core/utilities/extensions.dart';
import 'package:kafil/features/countries/screens/countries_screen.dart';
import 'package:kafil/features/profile/screens/profile_page.dart';
import 'package:kafil/features/service/screens/service_screen.dart';
import 'package:kafil/generated/locale_keys.g.dart';

class HomeScreen extends ConsumerWidget {
  static final route = NoArgRoute.page(
    name: "home",
    path: "/",
    guard: const RouteGuardGroup([AuthenticationGuard()]),
    pageBuilder: (context, state) {
      return fadeAnimationPage(
        pageKey: state.pageKey,
        screen: const HomeScreen(),
      );
    },
  );

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(_currentIndex);
    final bottomNavItems = [
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          AppAssets.profile,
          color: currentIndex == 0 ? context.appTheme.primary : null,
        ),
        label: LocaleKeys.tabs_profile.tr(),
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          AppAssets.countries,
          color: currentIndex == 1 ? context.appTheme.primary : null,
        ),
        label: LocaleKeys.tabs_countries.tr(),
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          AppAssets.cart,
          color: currentIndex == 2 ? context.appTheme.primary : null,
        ),
        label: LocaleKeys.tabs_services.tr(),
      ),
    ];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(
          title: bottomNavItems[currentIndex].label ?? '',
          isBackIconAppear: false,
        ),
      ),
      body: FadeIndexedStack(
        index: currentIndex,
        children: const [
          ProfilePage(),
          CountriesScreen(),
          ServiceScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: bottomNavItems,
        currentIndex: currentIndex,
        onTap: (index) {
          ref.read(_currentIndex.notifier).state = index;
        },
      ),
    );
  }
}

final _currentIndex = StateProvider.autoDispose((ref) => 0);
