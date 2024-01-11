import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kafil/core/error/failures.dart';
import 'package:kafil/core/notifiers/global_state.dart';
import 'package:kafil/features/service/data/interface/i_popular_service.dart';
import 'package:kafil/features/service/models/service_model.dart';

class ServiceNotifier extends StateNotifier<GlobalStates<List<ServiceModel>>> {
  static final provider = StateNotifierProvider.family<ServiceNotifier,
      GlobalStates<List<ServiceModel>>, bool>(
    (ref, bool isPopular) => ServiceNotifier(
      ref.watch(IPopularService.provider),
      isPopular,
    ),
  );

  final IPopularService _service;
  final bool isPopular;

  ServiceNotifier(
    this._service,
    this.isPopular,
  ) : super(GlobalStates.initial());

  Future<void> getService() async {
    state = GlobalStates.loading();
    Either<Failure, List<ServiceModel>> result;
    if (isPopular) {
      result = await _service.getPopularService();
    } else {
      result = await _service.getService();
    }
    result.fold(
      (l) => state = GlobalStates.fail(l.toString()),
      (r) => state = GlobalStates.success(r),
    );
  }
}
