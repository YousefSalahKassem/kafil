part of '../screens/service_screen.dart';

class _ServiceWidget extends ConsumerWidget {
  const _ServiceWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(ServiceNotifier.provider(false));
    return WidgetLifecycleListener(
      onInit: () {
        UiHelpers.postBuildCallback((_) {
          ref.watch(ServiceNotifier.provider(false).notifier).getService();
        });
      },
      child: state.when(
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
    );
  }
}
