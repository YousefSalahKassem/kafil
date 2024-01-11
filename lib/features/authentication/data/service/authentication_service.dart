import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:kafil/core/error/failures.dart';
import 'package:kafil/core/service/remote/dio_consumer.dart';
import 'package:kafil/core/service/remote/dio_headers.dart';
import 'package:kafil/features/authentication/data/interface/i_authentication_service.dart';
import 'package:kafil/features/authentication/models/app_dependencies.dart';
import 'package:kafil/features/authentication/models/login_request.dart';
import 'package:kafil/features/authentication/models/register_request.dart';

part '../endpoints.dart';

class AuthenticationService extends IAuthenticationService {
  final DioConsumer _dioConsumer;

  AuthenticationService(this._dioConsumer);

  @override
  Future<Either<Failure, String>> login(LoginRequest loginRequest) async {
    final responseEither = await _dioConsumer.post(
      _EndPoints.login,
      options: Options(
        headers: DioHeaders.headersWithLanguage('ar'),
      ),
      shouldReturnDataOnly: false,
      data: loginRequest.toJson(),
    );

    return responseEither.fold(
      (failure) => Left(failure),
      (response) {
        final accessToken = response['access_token'] as String;
        return Right(accessToken);
      },
    );
  }

  @override
  Future<Either<Failure, AppDependencies>> getAppDependencies() async {
    final responseEither = await _dioConsumer.get(
      _EndPoints.dependencies,
      shouldReturnDataOnly: true,
      options: Options(
        headers: DioHeaders.headersWithLanguage('en'),
      ),
    );

    return responseEither.fold(
      (failure) => Left(failure),
      (response) {
        final appDependencies =
            AppDependencies.fromJson(response as Map<String, dynamic>);

        return Right(appDependencies);
      },
    );
  }

  @override
  Future<Either<Failure, String>> register(
      RegisterRequest registerRequest) async {
    print(registerRequest.toJson());
    final responseEither = await _dioConsumer.post(
      _EndPoints.register,
      options: Options(
        headers: DioHeaders.multipartHeaders(),
      ),
      shouldReturnDataOnly: false,
      formData: FormData.fromMap(
        await registerRequest.toJson(),
      ),
    );

    return responseEither.fold(
      (failure) => Left(failure),
      (response) {
        return const Right("accessToken");
      },
    );
  }
}
