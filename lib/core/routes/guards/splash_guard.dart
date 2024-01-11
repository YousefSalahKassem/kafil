import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kafil/core/components/inherited_widget_ref.dart';
import 'package:kafil/core/routes/guards/guard.dart';
import 'package:kafil/core/service/local/interface/i_simple_user_data.dart';
import 'package:kafil/core/utilities/app_secrets_key.dart';
import 'package:kafil/core/utilities/enums.dart';
import 'package:kafil/features/home/screens/home_screen.dart';

class AuthenticationGuard extends RouteGuard {
  const AuthenticationGuard();

  @override
  FutureOr<String?> call(BuildContext context, GoRouterState state) async {
    final ref = InheritedWidgetRef.of(context);
    final userData = ref.watch(ISimpleUserData.provider(LocalDataType.secured));
    final isAuthenticated =
        await userData.readString(AppSecretsKey.accessToken);
    if (isAuthenticated != null) {
      return HomeScreen.route.encodeTemplate();
    }
    return null;
  }
}
