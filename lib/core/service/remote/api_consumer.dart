import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:kafil/core/error/failures.dart';
import 'package:kafil/core/service/remote/api_interceptor.dart';
import 'package:kafil/core/service/remote/dio_consumer.dart';
import 'package:kafil/core/service/remote/end_points.dart';

class ApiConsumer extends DioConsumer {
  factory ApiConsumer() => _instance;

  static final ApiConsumer _instance = ApiConsumer._internal();

  ApiConsumer._internal() {
    _dio = Dio();
    _dio.options.baseUrl = EndPoints.baseUrl;

    _dio.interceptors.add(
      ApiInterceptor(),
    );
    if (kDebugMode) {
      _dio.interceptors.add(
        LogInterceptor(
          responseBody: true,
          requestBody: true,
          logPrint: (Object? object) => log(object.toString(), name: 'HTTP'),
        ),
      );
    }
  }

  late final Dio _dio;

  @override
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
  }) async {
    try {
      final response = await _instance._dio.get(
        uri,
        data: data ?? formData,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      final responseData = response.data;

      if (!shouldReturnDataOnly) {
        return Right(responseData);
      } else {
        const responseDataKey = 'data';
        final data = responseData[responseDataKey];

        if (data != null) {
          return Right(data);
        } else {
          return Left(ServerFailure('No data key found in the response.'));
        }
      }
    } on DioException catch (exception) {
      return Left(
        ServerFailure(
          exception.message,
        ),
      );
    }
  }

  @override
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
  }) async {
    try {
      final response = await _instance._dio.post(
        uri,
        queryParameters: queryParameters,
        data: data ?? formData,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
        onSendProgress: onSendProgress,
      );
      final responseData = response.data;

      if (!shouldReturnDataOnly) {
        return Right(responseData);
      } else {
        const responseDataKey = 'data';
        final data = responseData[responseDataKey];

        if (data != null) {
          return Right(data);
        } else {
          return Left(ServerFailure('No data key found in the response.'));
        }
      }
    } on DioException catch (exception) {
      print(exception.response?.data);
      return Left(
        ServerFailure(
          exception.response?.data['message'] ??
              exception.response?.data['error']['message'],
        ),
      );
    }
  }
}
