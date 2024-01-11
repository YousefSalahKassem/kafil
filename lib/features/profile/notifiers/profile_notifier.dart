import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kafil/core/notifiers/global_state.dart';
import 'package:kafil/core/service/local/interface/i_simple_user_data.dart';
import 'package:kafil/core/utilities/app_secrets_key.dart';
import 'package:kafil/core/utilities/enums.dart';
import 'package:kafil/features/profile/data/interface/i_profile_service.dart';
import 'package:kafil/features/profile/models/profile.dart';

class ProfileNotifier extends StateNotifier<GlobalStates<Profile>> {
  static final provider =
      StateNotifierProvider<ProfileNotifier, GlobalStates<Profile>>(
    (
      ref,
    ) =>
        ProfileNotifier(
      ref.watch(IProfileService.provider),
      ref.watch(
        ISimpleUserData.provider(LocalDataType.secured),
      ),
    ),
  );

  final IProfileService _service;
  final ISimpleUserData _userData;

  ProfileNotifier(
    this._service,
    this._userData,
  ) : super(GlobalStates.initial()) {
    _getCurrentProfile();
  }

  Future<void> _getCurrentProfile() async {
    state = GlobalStates.loading();
    final result = await _service.getProfile(await _getAccessToken());

    result.fold(
      (l) => state = GlobalStates.fail(l.toString()),
      (r) => state = GlobalStates.success(r),
    );
  }

  Future<String> _getAccessToken() async {
    final accessToken = await _userData.readString(AppSecretsKey.accessToken);
    return accessToken!;
  }
}
