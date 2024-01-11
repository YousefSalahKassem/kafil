part of '../../screens/login_screen.dart';

class _LoginHeader extends StatelessWidget {
  const _LoginHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        16.verticalSpace,
        Center(child: SvgPicture.asset(AppAssets.login)),
        16.verticalSpace,
      ],
    );
  }
}
