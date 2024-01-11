import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kafil/core/error/failures.dart';
import 'package:kafil/core/service/remote/dio_consumer.dart';
import 'package:kafil/core/utilities/query_parameters.dart';
import 'package:kafil/features/countries/data/service/country_service.dart';
import 'package:kafil/features/countries/models/country.dart';
import 'package:kafil/features/countries/models/pagination.dart';

abstract class ICountryService {
  static final provider = Provider(
    (ref) => CountryService(
      ref.watch(DioConsumer.provider),
    ),
  );

  Future<Either<Failure, List<Country>>> getCountries(
      QueryParameters queryParameters);

  Future<Either<Failure, Pagination>> getPages();
}
