part of '../../screens/register_screen.dart';

class _RegisterSteps extends ConsumerStatefulWidget {
  const _RegisterSteps();

  @override
  ConsumerState createState() => __RegisterStepsState();
}

class __RegisterStepsState extends ConsumerState<_RegisterSteps> {
  @override
  Widget build(BuildContext context) {
    return FullLinearStepIndicator(
      steps: 2,
      lineHeight: 3.5,
      nodeSize: 0,
      nodeThickness: 0,
      backgroundColor: context.appTheme.white,
      activeNodeColor: context.appTheme.primary,
      inActiveNodeColor: const Color(0xffd1d5d8),
      activeLineColor: context.appTheme.primary,
      inActiveLineColor: const Color(0xffd1d5d8),
      activeBorderColor: context.appTheme.primary,
      inActiveBorderColor: Colors.transparent,
      activeLabelStyle: context.appTextStyles.bodyLarge.copyWith(
        color: context.appTheme.primary,
      ),
      inActiveLabelStyle: context.appTextStyles.bodyMedium.copyWith(
        color: const Color(0xffd1d5d8),
      ),
      currentIndex: ref.watch(RegisterHolder.provider).currentStep,
      labels: [
        LocaleKeys.register_title.tr(),
        LocaleKeys.register_secondPage_complete.tr(),
      ],
    );
  }
}
