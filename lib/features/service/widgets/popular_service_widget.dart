part of '../screens/service_screen.dart';

class _PopularServiceWidget extends ConsumerWidget {
  const _PopularServiceWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(ServiceNotifier.provider(true));

    return WidgetLifecycleListener(
      onInit: () {
        UiHelpers.postBuildCallback((_) {
          ref.watch(ServiceNotifier.provider(true).notifier).getService();
        });
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              LocaleKeys.service_popular.tr(),
              style: context.appTextStyles.subheadLarge.copyWith(
                color: context.appTheme.black,
              ),
            ),
          ),
          20.verticalSpace,
          state.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            data: (services) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: services
                      .map(
                        (item) => _ServiceCard(service: item),
                      )
                      .toList(),
                ),
              );
            },
            error: (error) => Text(error),
          ),
        ],
      ),
    );
  }
}
