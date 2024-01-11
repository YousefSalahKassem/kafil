import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:kafil/core/error/failures.dart';
import 'package:kafil/core/service/remote/dio_consumer.dart';
import 'package:kafil/core/service/remote/dio_headers.dart';

import 'package:kafil/features/service/data/interface/i_popular_service.dart';
import 'package:kafil/features/service/models/service_model.dart';

part '../endpoints.dart';

class PopularService extends IPopularService {
  final DioConsumer _dioConsumer;

  PopularService(this._dioConsumer);

  @override
  Future<Either<Failure, List<ServiceModel>>> getPopularService() async {
    final responseEither = await _dioConsumer.get(
      _EndPoints.popularService,
      options: Options(
        headers: DioHeaders.headersWithLanguage('en'),
      ),
    );

    return responseEither.fold(
      (failure) => Left(failure),
      (response) {
        final List<dynamic> jsonList = response as List<dynamic>;

        final List<ServiceModel> popularList = jsonList
            .map((json) => ServiceModel.fromJson(json as Map<String, dynamic>))
            .toList();

        return Right(popularList);
      },
    );
  }

  @override
  Future<Either<Failure, List<ServiceModel>>> getService() async {
    final responseEither = await _dioConsumer.get(
      _EndPoints.service,
      options: Options(
        headers: DioHeaders.headersWithLanguage('en'),
      ),
      shouldReturnDataOnly: true,
    );

    return responseEither.fold(
      (failure) => Left(failure),
      (response) {
        final jsonList = response as List<dynamic>;

        final List<ServiceModel> popularList = jsonList
            .map((json) => ServiceModel.fromJson(json as Map<String, dynamic>))
            .toList();

        return Right(popularList);
      },
    );
  }
}
