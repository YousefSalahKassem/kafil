import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:kafil/core/error/failures.dart';
import 'package:kafil/core/service/remote/dio_consumer.dart';
import 'package:kafil/core/service/remote/dio_headers.dart';
import 'package:kafil/core/utilities/query_parameters.dart';
import 'package:kafil/features/countries/data/interface/i_country_service.dart';
import 'package:kafil/features/countries/models/country.dart';
import 'package:kafil/features/countries/models/pagination.dart';

part '../endpoints.dart';

class CountryService extends ICountryService {
  final DioConsumer _dioConsumer;

  CountryService(this._dioConsumer);

  @override
  Future<Either<Failure, List<Country>>> getCountries(
    QueryParameters queryParameters,
  ) async {
    final responseEither = await _dioConsumer.get(
      _EndPoints.country,
      queryParameters: queryParameters.toJson(),
      shouldReturnDataOnly: true,
      options: Options(
        headers: DioHeaders.headersWithLanguage('en'),
      ),
    );

    return responseEither.fold(
      (failure) => Left(failure),
      (response) {
        final List<dynamic> jsonList = response as List<dynamic>;

        final List<Country> countryList = jsonList
            .map((json) => Country.fromJson(json as Map<String, dynamic>))
            .toList();

        return Right(countryList);
      },
    );
  }

  @override
  Future<Either<Failure, Pagination>> getPages() async {
    final responseEither = await _dioConsumer.get(
      _EndPoints.country,
      shouldReturnDataOnly: false,
      options: Options(
        headers: DioHeaders.headersWithLanguage('en'),
      ),
    );

    return responseEither.fold(
      (failure) => Left(failure),
      (response) {
        final pagination =
            Pagination.fromJson(response['pagination'] as Map<String, dynamic>);

        return Right(pagination);
      },
    );
  }
}
