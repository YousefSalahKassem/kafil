part of '../../screens/register_screen.dart';

class _FirstPage extends ConsumerWidget {
  const _FirstPage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerHolderController = ref.read(RegisterHolder.provider.notifier);
    final registerHolderState = ref.watch(RegisterHolder.provider);
    final dependencyState = ref.watch(DependenciesNotifier.provider);
    return Form(
      key: registerHolderController.firstFormKey,
      child: Column(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: registerHolderState.showError
                ? Container(
                    key: UniqueKey(),
                    width: context.width,
                    padding:
                        EdgeInsets.symmetric(horizontal: 19.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: context.appTheme.errorField,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline_rounded,
                          color: context.appTheme.error,
                        ),
                        16.horizontalSpace,
                        Text(
                          LocaleKeys.errors_requiredAll.tr(),
                          style: context.appTextStyles.bodyMedium.copyWith(
                            color: context.appTheme.error,
                          ),
                        )
                      ],
                    ),
                  )
                : const SizedBox(), // Empty SizedBox when not showing the error
          ),
          if (registerHolderState.showError) 16.verticalSpace,
          Row(
            children: [
              Expanded(
                child: AppTextField.name(
                  label: LocaleKeys.register_firstPage_firstName.tr(),
                  fieldController: registerHolderController.firstNameController,
                  showError: true,
                  validator: (value) => value!.validate([
                    validateName,
                  ]),
                ),
              ),
              10.horizontalSpace,
              Expanded(
                child: AppTextField.name(
                  label: LocaleKeys.register_firstPage_lastName.tr(),
                  fieldController: registerHolderController.lastNameController,
                  showError: true,
                  validator: (value) => value!.validate([
                    validateName,
                  ]),
                ),
              ),
            ],
          ),
          16.verticalSpace,
          AppTextField.email(
            fieldController: registerHolderController.emailController,
            showError: true,
            validator: (value) => value!.validate([
              validateEmail,
            ]),
          ),
          16.verticalSpace,
          AppTextField.password(
            label: LocaleKeys.register_firstPage_password.tr(),
            fieldController: registerHolderController.passwordController,
            showError: true,
            validator: (value) => value!.validate([
              validatePassword,
            ]),
          ),
          16.verticalSpace,
          AppTextField.password(
            label: LocaleKeys.register_firstPage_confirmPassword.tr(),
            fieldController: registerHolderController.confirmPasswordController,
            showError: true,
            validator: (value) => value!.validate([
              validateRequired,
              (confirmPassword) => matchesPasswords(
                    registerHolderController.passwordController.text,
                    confirmPassword,
                  ),
            ]),
          ),
          16.verticalSpace,
          dependencyState.when(
            data: (value) {
              return DropDownField<Dependency>(
                onChanged: (value) {
                  registerHolderController.userType = value!.value;
                  registerHolderController.dependency = value;
                },
                label: LocaleKeys.register_firstPage_userType.tr(),
                customItems: value.types
                    .map(
                      (e) => DropdownMenuItem<Dependency>(
                        value: e,
                        child: Text(e.label),
                      ),
                    )
                    .toList(),
                hint: '',
                value: registerHolderState.dependency,
                validator: (value) => value!.label.validate([
                  validateRequired,
                ]),
              );
            },
            loading: () => const SizedBox(),
            error: (_) => const SizedBox(),
          )
        ],
      ),
    );
  }
}
