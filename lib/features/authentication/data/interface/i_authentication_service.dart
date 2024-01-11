import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kafil/core/error/failures.dart';
import 'package:kafil/core/service/remote/dio_consumer.dart';
import 'package:kafil/features/authentication/data/service/authentication_service.dart';
import 'package:kafil/features/authentication/models/app_dependencies.dart';
import 'package:kafil/features/authentication/models/login_request.dart';
import 'package:kafil/features/authentication/models/register_request.dart';

abstract class IAuthenticationService {
  static final provider = Provider(
    (ref) => AuthenticationService(
      ref.watch(DioConsumer.provider),
    ),
  );

  Future<Either<Failure, String>> login(LoginRequest loginRequest);

  Future<Either<Failure, String>> register(RegisterRequest registerRequest);

  Future<Either<Failure, AppDependencies>> getAppDependencies();
}
