import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kafil/core/notifiers/global_state.dart';
import 'package:kafil/core/service/local/interface/i_simple_user_data.dart';
import 'package:kafil/core/utilities/app_secrets_key.dart';
import 'package:kafil/core/utilities/enums.dart';
import 'package:kafil/features/authentication/data/interface/i_authentication_service.dart';
import 'package:kafil/features/authentication/models/login_request.dart';
import 'package:kafil/features/authentication/models/register_request.dart';
import 'package:kafil/features/authentication/notifiers/login_holder.dart';
import 'package:kafil/features/authentication/notifiers/register_holder.dart';

class AuthNotifier extends StateNotifier<GlobalStates<String>> {
  static final provider =
      StateNotifierProvider<AuthNotifier, GlobalStates<String>>(
    (ref) => AuthNotifier(
      ref.watch(IAuthenticationService.provider),
      ref.read(LoginHolder.provider),
      ref.read(RegisterHolder.provider),
      ref.watch(
        ISimpleUserData.provider(LocalDataType.secured),
      ),
    ),
  );

  final IAuthenticationService _service;
  final LoginHolder _loginHolder;
  final RegisterHolder _registerHolder;
  final ISimpleUserData _userData;

  AuthNotifier(
    this._service,
    this._loginHolder,
    this._registerHolder,
    this._userData,
  ) : super(GlobalStates.initial());

  Future<void> login() async {
    if (_loginHolder.formKey.currentState!.validate()) {
      state = GlobalStates.loading();

      final result = await _service.login(
        LoginRequest(
            email: _loginHolder.emailController.text,
            password: _loginHolder.passwordController.text),
      );

      result.fold(
        (failure) => state = GlobalStates.fail(
          failure.toString(),
        ),
        (accessToken) async {
          state = GlobalStates.success(accessToken);
          if (_loginHolder.shouldRememberMe) {
            await _userData.writeString(AppSecretsKey.accessToken, accessToken);
          }
        },
      );
    }
  }

  Future<void> register() async {
    state = GlobalStates.loading();

    final result = await _service.register(
      RegisterRequest(
        firstName: _registerHolder.firstNameController.text,
        lastName: _registerHolder.lastNameController.text,
        email: _registerHolder.emailController.text,
        password: _registerHolder.passwordController.text,
        confirmPassword: _registerHolder.confirmPasswordController.text,
        about: _registerHolder.aboutController.text,
        tags: _registerHolder.skills,
        favouriteSocialMedia: _registerHolder.social,
        salary: _registerHolder.currentSalary,
        date: _registerHolder.dateController.text,
        type: _registerHolder.userType,
        gender: _registerHolder.isMale,
        avatar: _registerHolder.file!,
      ),
    );

    result.fold(
      (failure) => state = GlobalStates.fail(
        failure.toString(),
      ),
      (accessToken) async {
        state = GlobalStates.success(accessToken);
      },
    );
  }
}
