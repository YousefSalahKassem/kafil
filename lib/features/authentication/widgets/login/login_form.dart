part of '../../screens/login_screen.dart';

class _LoginForm extends ConsumerWidget {
  const _LoginForm();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginHolderState = ref.watch(LoginHolder.provider);
    final loginHolderController = ref.read(LoginHolder.provider.notifier);
    final loginNotifier = ref.read(AuthNotifier.provider.notifier);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      child: Form(
        key: loginHolderState.formKey,
        child: Column(
          children: [
            AppTextField.email(
              fieldController: loginHolderController.emailController,
              showError: true,
              validator: (value) => value!.validate([
                validateRequired,
                validateEmail,
              ]),
            ),
            16.verticalSpace,
            AppTextField.password(
              label: LocaleKeys.login_password.tr(),
              showError: true,
              fieldController: loginHolderController.passwordController,
              validator: (value) => value!.validate([
                validatePassword,
              ]),
            ),
            16.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const _RememberMe(),
                Text(
                  LocaleKeys.login_forgot.tr(),
                  style: context.appTextStyles.bodyMedium,
                )
              ],
            ),
            24.verticalSpace,
            SizedBox(
              width: context.width,
              child: ElevatedButton(
                onPressed: () {
                  loginNotifier.login();
                },
                child: Text(
                  LocaleKeys.login_submit.tr(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _RememberMe extends ConsumerStatefulWidget {
  const _RememberMe();

  @override
  ConsumerState createState() => __RememberMeState();
}

class __RememberMeState extends ConsumerState<_RememberMe> {
  late bool _isChecked;

  @override
  void initState() {
    super.initState();
    _isChecked = true;
  }

  @override
  Widget build(BuildContext context) {
    final loginHolderController = ref.read(LoginHolder.provider.notifier);
    return Row(
      children: [
        Checkbox(
          fillColor: MaterialStateProperty.all(
              _isChecked ? context.appTheme.primary : context.appTheme.white),
          value: _isChecked,
          onChanged: (value) {
            loginHolderController.shouldRememberMe = value ?? true;
            setState(
              () {
                _isChecked = value ?? true;
              },
            );
          },
        ),
        Text(
          LocaleKeys.login_remember.tr(),
          style: context.appTextStyles.bodyMedium,
        ),
      ],
    );
  }
}
