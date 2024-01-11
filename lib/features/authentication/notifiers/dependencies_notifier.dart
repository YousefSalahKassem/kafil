import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kafil/core/notifiers/global_state.dart';
import 'package:kafil/features/authentication/data/interface/i_authentication_service.dart';
import 'package:kafil/features/authentication/models/app_dependencies.dart';

class DependenciesNotifier
    extends StateNotifier<GlobalStates<AppDependencies>> {
  static final provider = StateNotifierProvider<DependenciesNotifier,
      GlobalStates<AppDependencies>>(
    (
      ref,
    ) =>
        DependenciesNotifier(
      ref.watch(IAuthenticationService.provider),
    ),
  );

  final IAuthenticationService _service;

  DependenciesNotifier(
    this._service,
  ) : super(GlobalStates.initial()) {
    getDependencies();
  }

  Future<void> getDependencies() async {
    state = GlobalStates.loading();
    final result = await _service.getAppDependencies();

    result.fold(
      (l) => state = GlobalStates.fail(l.toString()),
      (r) => state = GlobalStates.success(r),
    );
  }
}
