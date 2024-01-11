part of '../screens/countries_screen.dart';

class _CountryTable extends ConsumerWidget {
  const _CountryTable();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(CountryNotifiers.provider);
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      child: SizedBox(
        width: context.width,
        height: context.heightR(0.5),
        child: Column(
          children: [
            Container(
              width: context.width,
              padding: EdgeInsets.symmetric(vertical: 14.h),
              margin: EdgeInsets.symmetric(horizontal: 6.w, vertical: 14.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: context.appTheme.successField,
              ),
              child: Row(
                children: [
                  const Spacer(
                    flex: 3,
                  ),
                  Text(
                    LocaleKeys.countries_country.tr(),
                    style: context.appTextStyles.bodyLarge,
                  ),
                  const Spacer(
                    flex: 10,
                  ),
                  Text(
                    LocaleKeys.countries_capital.tr(),
                    style: context.appTextStyles.bodyLarge,
                  ),
                  const Spacer(
                    flex: 6,
                  ),
                ],
              ),
            ),
            Expanded(
              child: state.when(
                data: (countries) {
                  return SingleChildScrollView(
                    child: Center(
                      child: DataTable(
                        border: const TableBorder(
                          horizontalInside:
                              BorderSide(color: Color(0xFFF2F2F2), width: 1),
                        ),
                        headingRowHeight: 0,
                        columns: const [
                          DataColumn(
                            label: Center(
                              child: Text(
                                '',
                                style: TextStyle(fontSize: 0),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Center(
                              child: Text(
                                '',
                                style: TextStyle(fontSize: 0),
                              ),
                            ),
                          ),
                        ],
                        rows: countries
                            .map(
                              (item) => DataRow(
                                cells: [
                                  DataCell(
                                    Center(
                                      child: FadeInUp(
                                        child: Text(
                                          item.name,
                                          style: context
                                              .appTextStyles.bodyMedium
                                              .copyWith(
                                            color: context.appTheme.black,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Center(
                                      child: FadeInUp(
                                        child: Text(
                                          item.capital,
                                          style: context
                                              .appTextStyles.bodyMedium
                                              .copyWith(
                                            color: context.appTheme.black,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  );
                },
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                error: (message) => Text(message),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
