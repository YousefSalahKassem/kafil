import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kafil/core/error/failures.dart';
import 'package:kafil/core/service/remote/dio_consumer.dart';
import 'package:kafil/features/service/data/service/popular_service.dart';
import 'package:kafil/features/service/models/service_model.dart';

abstract class IPopularService {
  static final provider = Provider(
    (ref) => PopularService(
      ref.watch(DioConsumer.provider),
    ),
  );

  Future<Either<Failure, List<ServiceModel>>> getService();

  Future<Either<Failure, List<ServiceModel>>> getPopularService();
}
