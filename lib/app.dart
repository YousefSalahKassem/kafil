import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:kafil/core/components/inherited_widget_ref.dart';
import 'package:kafil/core/routes/custom_routes.dart';
import 'package:kafil/core/themes/app_theme.dart';
import 'package:kafil/generated/locale_keys.g.dart';

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  late final _appRouter = ref.watch(AppRouter.provider);

  @override
  Widget build(BuildContext context) {
    return InheritedWidgetRef(
      child: ScreenUtilInit(
        designSize: const Size(360, 762),
        minTextAdapt: true,
        splitScreenMode: true,
        useInheritedMediaQuery: true,
        builder: (context, child) {
          return AppTheme(
            builder: (theme) {
              return GestureDetector(
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                child: GlobalLoaderOverlay(
                  overlayColor: Colors.black54,
                  child: MaterialApp.router(
                    onGenerateTitle: (context) {
                      return LocaleKeys.appName.tr();
                    },
                    debugShowCheckedModeBanner: false,
                    localizationsDelegates: context.localizationDelegates,
                    supportedLocales: context.supportedLocales,
                    locale: context.locale,
                    routeInformationProvider:
                        _appRouter.routeInformationProvider,
                    routerDelegate: _appRouter.routerDelegate,
                    routeInformationParser: _appRouter.routeInformationParser,
                    theme: theme,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
