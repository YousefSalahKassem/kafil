import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kafil/core/error/failures.dart';
import 'package:kafil/core/service/remote/api_consumer.dart';

abstract class DioConsumer {
  static final provider = Provider(
    (ref) => ApiConsumer(),
  );

  Future<Either<Failure, dynamic>> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    FormData? formData,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    bool shouldReturnDataOnly = true,
  });

  Future<Either<Failure, dynamic>> post(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    FormData? formData,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    bool shouldReturnDataOnly = true,
  });
}
