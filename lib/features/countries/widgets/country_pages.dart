part of '../screens/countries_screen.dart';

class _CountryPages extends ConsumerStatefulWidget {
  const _CountryPages();

  @override
  ConsumerState createState() => __CountryPagesState();
}

class __CountryPagesState extends ConsumerState<_CountryPages> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(PagesNotifier.provider);
    final countriesController = ref.read(CountryNotifiers.provider.notifier);
    return state.when(
      data: (pages) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: NumberPaginator(
            numberPages: pages.totalPages,
            onPageChange: (page) {
              setState(() {});
              countriesController.fetchCountries(
                params: QueryParameters(offset: page + 1),
              );
            },
            config: NumberPaginatorUIConfig(
              buttonShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              buttonSelectedBackgroundColor: context.appTheme.primary,
              buttonSelectedForegroundColor: context.appTheme.white,
              buttonUnselectedForegroundColor: context.appTheme.black,
            ),
          ),
        );
      },
      loading: () => const SizedBox(),
      error: (_) => const SizedBox(),
    );
  }
}
