import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kafil/core/error/failures.dart';
import 'package:kafil/core/service/remote/dio_consumer.dart';
import 'package:kafil/features/profile/data/service/profile_service.dart';
import 'package:kafil/features/profile/models/profile.dart';

abstract class IProfileService {
  static final provider = Provider(
    (ref) => ProfileService(
      ref.watch(DioConsumer.provider),
    ),
  );

  Future<Either<Failure, Profile>> getProfile(String accessToken);
}
