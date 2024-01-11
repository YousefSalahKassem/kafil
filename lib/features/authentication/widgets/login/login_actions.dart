part of '../../screens/login_screen.dart';

class _LoginActions extends StatelessWidget {
  const _LoginActions();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          20.verticalSpace,
          GestureDetector(
            onTap: () {
              RegisterScreen.route.push(context);
            },
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: LocaleKeys.login_didNotHaveAccount.tr(),
                    style: context.appTextStyles.bodyMedium,
                  ),
                  TextSpan(
                    text: LocaleKeys.login_register.tr(),
                    style: context.appTextStyles.bodyLarge.copyWith(
                      color: context.appTheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          20.verticalSpace,
        ],
      ),
    );
  }
}
