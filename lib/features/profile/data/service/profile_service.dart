import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:kafil/core/error/failures.dart';
import 'package:kafil/core/service/remote/dio_consumer.dart';
import 'package:kafil/core/service/remote/dio_headers.dart';
import 'package:kafil/features/profile/data/interface/i_profile_service.dart';
import 'package:kafil/features/profile/models/profile.dart';

part '../endpoints.dart';

class ProfileService extends IProfileService {
  final DioConsumer _dioConsumer;

  ProfileService(this._dioConsumer);

  @override
  Future<Either<Failure, Profile>> getProfile(String accessToken) async {
    final responseEither = await _dioConsumer.get(
      _EndPoints.profile,
      options: Options(
        headers: DioHeaders.headersWithNewToken(accessToken),
      ),
    );

    return responseEither.fold(
      (failure) => Left(failure),
      (response) {
        final profile = Profile.fromJson(response as Map<String, dynamic>);

        return Right(profile);
      },
    );
  }
}
