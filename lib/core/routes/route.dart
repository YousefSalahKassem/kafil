import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kafil/core/routes/guards/guard_group.dart';
import 'package:kafil/core/utilities/defs.dart';
import 'package:kafil/core/utilities/extensions.dart';

abstract class RouteArg {
  const RouteArg();

  JsonMap encodeQueryParams() => {};

  JsonMap encodePathParams() => {};

  Object? getExtra() => null;
}

// Represents a route argument with no data, indicating that no parameters
class NoArg extends RouteArg {
  const NoArg();

  @override
  JsonMap encodePathParams() => {};
}

// Represents a route argument for passing a single query parameter of type `T`.
class SimpleQueryArg<T> extends RouteArg {
  final T arg;

  const SimpleQueryArg(this.arg);

  @override
  JsonMap encodePathParams() => {"arg": arg};
}

/*
Represents a route argument that allows including an extra argument of any type `T` along with a route.
For example: www.example.com/{id}
 */
class SimpleExtraArg<T> extends RouteArg {
  final T arg;

  const SimpleExtraArg(this.arg);

  @override
  Object? getExtra() => arg;
}

class Params {
  final JsonMap queryParams;
  final JsonMap<String> pathParams;

  const Params(this.queryParams, this.pathParams);
}

class AppRoute<Arg extends RouteArg> {
  final String? title;
  final String? name;
  final String? path;
  final List<String> pathParams;
  final List<String> queryParams;
  final RouteGuardGroup? guard;
  final GoRouterPageBuilder? pageBuilder;
  final GoRouterWidgetBuilder? screenBuilder;
  final List<AppRoute> nestedRoutes;

  const AppRoute._({
    this.title,
    this.name,
    this.path,
    this.screenBuilder,
    this.pageBuilder,
    this.pathParams = const [],
    this.queryParams = const [],
    this.nestedRoutes = const [],
    this.guard,
  }) : assert(name != null || path != null);

  const AppRoute.screen({
    this.title,
    this.name,
    this.path,
    required GoRouterWidgetBuilder this.screenBuilder,
    this.pathParams = const [],
    this.queryParams = const [],
    this.guard,
  })  : pageBuilder = null,
        nestedRoutes = const [],
        assert(name != null || path != null);

  const AppRoute.page({
    this.title,
    this.name,
    this.path,
    required GoRouterPageBuilder this.pageBuilder,
    this.pathParams = const [],
    this.queryParams = const [],
    this.guard,
  })  : screenBuilder = null,
        nestedRoutes = const [],
        assert(name != null || path != null);

  AppRoute<Arg> nested() {
    return AppRoute._(
      path: path ?? _nameToPath(),
      pathParams: pathParams,
      queryParams: queryParams,
      guard: guard,
      pageBuilder: pageBuilder,
      screenBuilder: screenBuilder,
      nestedRoutes: nestedRoutes,
    );
  }

  AppRoute<Arg> nest({
    RouteGuardGroup? guard,
    GoRouterPageBuilder? pageBuilder,
    GoRouterWidgetBuilder? screenBuilder,
    List<AppRoute>? nestedRoutes,
  }) {
    return AppRoute._(
      title: title,
      name: name,
      path: path,
      pathParams: pathParams,
      queryParams: queryParams,
      guard: guard ?? this.guard,
      pageBuilder: pageBuilder ?? this.pageBuilder,
      screenBuilder: screenBuilder ?? this.screenBuilder,
      nestedRoutes: nestedRoutes ?? this.nestedRoutes,
    );
  }

  String _nameToPath() {
    final name = this.name ?? title;
    final buffer = StringBuffer();
    if (name!.isNotEmpty) {
      buffer.write(name.substring(0, 1).toLowerCase());
      for (final char in name.characters.skip(1)) {
        final lower = char.toLowerCase();
        if (lower != char) {
          buffer.write("_$lower");
        } else {
          buffer.write(char);
        }
      }
    }
    return buffer.toString();
  }

  @protected
  dynamic encodeQueryParam(dynamic param) {
    if (param == null) return null;
    if (param is String) return param;
    if (param is num || param is bool) {
      return jsonEncode(param);
    }
    if (param is Iterable) {
      return param.map(encodeQueryParam).whereNotNull().toList();
    }
    return jsonEncode(param);
  }

  @protected
  String? encodePathParam(dynamic param) {
    if (param == null) return null;
    if (param is String) return param;
    if (param is num || param is bool) {
      return jsonEncode(param);
    }
    return jsonEncode(param);
  }

  String encodeTemplate() {
    String path = this.path ?? _nameToPath();
    if (pathParams.isNotEmpty) {
      path += "/";
    }
    return path += pathParams.map((e) => ":$e").join("/");
  }

  Params encodeParams({required Arg arg}) {
    return Params(
      encodeParamsMap(arg.encodeQueryParams(), queryParams, encodeQueryParam),
      encodeParamsMap(arg.encodePathParams(), pathParams, encodePathParam),
    );
  }

  JsonMap<T> encodeParamsMap<T>(
    JsonMap args,
    List<String> names,
    T? Function(dynamic param) encodeParam,
  ) {
    final JsonMap<T> params = {};
    for (final paramName in names) {
      final param = args[paramName];
      final encodedParam = encodeParam(param);
      if (encodedParam != null) {
        params[paramName] = encodedParam;
      }
    }
    return params;
  }

  GoRoute toGoRoute() {
    return GoRoute(
      name: name ?? title,
      path: encodeTemplate(),
      redirect: guard?.call,
      pageBuilder: pageBuilder,
      builder: screenBuilder,
      routes: nestedRoutes.map((r) => r.toGoRoute()).toList(),
    );
  }

  String goToLocation(
    GoRouter router, {
    required Arg arg,
    bool preferAbsolute = true,
  }) {
    final params = encodeParams(arg: arg);
    final name = this.name;
    final path = this.path;
    if (name != null && (path != null || preferAbsolute)) {
      return router.namedLocation(
        name,
        queryParameters: params.queryParams,
        pathParameters: params.pathParams,
      );
    } else {
      List<String> locations = Uri.parse(router.location).pathSegments.toList();
      locations.addAll(encodeTemplate().split('/'));
      locations = locations.map((path) {
        if (path.contains(':')) {
          return params.pathParams[path.substring(1)]!;
        } else {
          return path;
        }
      }).toList();
      return Uri(
        pathSegments: [''].followedBy(locations).toList(),
        queryParameters:
            params.queryParams.isNotEmpty ? params.queryParams : null,
      ).toString();
    }
  }

  String toLocation(
    BuildContext context, {
    required Arg arg,
    bool preferAbsolute = true,
  }) {
    return goToLocation(
      GoRouter.of(context),
      arg: arg,
      preferAbsolute: preferAbsolute,
    );
  }
}

class NoArgRoute extends AppRoute<NoArg> {
  const NoArgRoute._({
    super.title,
    super.name,
    super.screenBuilder,
    super.pageBuilder,
    super.guard,
    super.path,
    super.nestedRoutes,
  }) : super._();

  const NoArgRoute.screen({
    super.title,
    super.name,
    required super.screenBuilder,
    super.guard,
    super.path,
  }) : super.screen();

  const NoArgRoute.page({
    super.title,
    super.name,
    required super.pageBuilder,
    super.guard,
    super.path,
  }) : super.page();

  @override
  NoArgRoute nested() {
    return NoArgRoute._(
      path: path ?? _nameToPath(),
      guard: guard,
      pageBuilder: pageBuilder,
      screenBuilder: screenBuilder,
      nestedRoutes: nestedRoutes,
    );
  }

  @override
  NoArgRoute nest({
    RouteGuardGroup? guard,
    GoRouterPageBuilder? pageBuilder,
    GoRouterWidgetBuilder? screenBuilder,
    List<AppRoute>? nestedRoutes,
  }) {
    return NoArgRoute._(
      title: title,
      name: name,
      path: path,
      guard: guard ?? this.guard,
      pageBuilder: pageBuilder ?? this.pageBuilder,
      screenBuilder: screenBuilder ?? this.screenBuilder,
      nestedRoutes: nestedRoutes ?? this.nestedRoutes,
    );
  }

  @override
  Params encodeParams({NoArg arg = const NoArg()}) {
    return super.encodeParams(arg: arg);
  }

  @override
  String goToLocation(
    GoRouter router, {
    NoArg arg = const NoArg(),
    bool preferAbsolute = true,
  }) {
    return super.goToLocation(router, arg: arg, preferAbsolute: preferAbsolute);
  }

  @override
  String toLocation(
    BuildContext context, {
    NoArg arg = const NoArg(),
    bool preferAbsolute = true,
  }) {
    return super.toLocation(context, arg: arg, preferAbsolute: preferAbsolute);
  }
}
