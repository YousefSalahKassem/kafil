part of '../../screens/register_screen.dart';

class _Submit extends ConsumerStatefulWidget {
  const _Submit();

  @override
  ConsumerState<_Submit> createState() => _SubmitState();
}

class _SubmitState extends ConsumerState<_Submit> {
  @override
  Widget build(BuildContext context) {
    final isLast = ref.watch(RegisterHolder.provider).currentStep != 0;
    final registerHolderState = ref.read(RegisterHolder.provider.notifier);
    final authNotifier = ref.read(AuthNotifier.provider.notifier);

    return Align(
      alignment: Alignment.topRight,
      child: ElevatedButton(
        onPressed: () {
          if (!isLast) {
            if (registerHolderState.isFirstFormValid()) {
              if (registerHolderState.firstFormKey.currentState!.validate()) {
                registerHolderState.currentStep = 1;
                registerHolderState.showError = false;
              }
            } else {
              registerHolderState.showError = true;
            }
          } else {
            if (registerHolderState.isSecondFormValid()) {
              if (registerHolderState.secondFormKey.currentState!.validate()) {
                registerHolderState.showError = false;
                authNotifier.register();
              }
            } else {
              registerHolderState.showError = true;
            }
          }
          setState(() {});
        },
        child: AnimatedSize(
          curve: Curves.fastOutSlowIn,
          duration: const Duration(milliseconds: 200),
          child: SizedBox(
            width: isLast ? context.width : 160.w,
            child: Center(
              child: Text(
                isLast
                    ? LocaleKeys.register_secondPage_submit.tr()
                    : LocaleKeys.register_firstPage_next.tr(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
