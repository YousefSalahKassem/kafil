import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kafil/core/notifiers/global_state.dart';
import 'package:kafil/features/countries/data/interface/i_country_service.dart';
import 'package:kafil/features/countries/models/pagination.dart';

class PagesNotifier extends StateNotifier<GlobalStates<Pagination>> {
  static final provider =
      StateNotifierProvider<PagesNotifier, GlobalStates<Pagination>>(
    (
      ref,
    ) =>
        PagesNotifier(
      ref.watch(ICountryService.provider),
    ),
  );

  final ICountryService _service;

  PagesNotifier(
    this._service,
  ) : super(GlobalStates.initial()) {
    getService();
  }

  Future<void> getService() async {
    state = GlobalStates.loading();
    final result = await _service.getPages();

    result.fold(
      (l) => state = GlobalStates.fail(l.toString()),
      (r) => state = GlobalStates.success(r),
    );
  }
}
