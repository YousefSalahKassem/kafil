import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kafil/core/notifiers/global_state.dart';
import 'package:kafil/core/utilities/pagination.dart';
import 'package:kafil/core/utilities/query_parameters.dart';
import 'package:kafil/features/countries/data/interface/i_country_service.dart';
import 'package:kafil/features/countries/models/country.dart';

class CountryNotifiers extends StateNotifier<GlobalStates<List<Country>>>
    with Pagination<Country> {
  static final provider =
      StateNotifierProvider<CountryNotifiers, GlobalStates<List<Country>>>(
    (ref) => CountryNotifiers(
      ref.watch(ICountryService.provider),
    ),
  );

  final ICountryService _service;

  CountryNotifiers(this._service) : super(GlobalStates.initial()) {
    fetchCountries();
  }

  Future<void> fetchCountries({QueryParameters? params}) async {
    state = GlobalStates.loading();

    final result = await _service.getCountries(params ?? queryParameters);

    result.fold((failure) {
      state = GlobalStates.fail(failure.toString());
    }, (countries) {
      state = GlobalStates.success(countries);
    });
  }
}
