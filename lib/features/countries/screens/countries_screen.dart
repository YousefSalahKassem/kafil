import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kafil/core/components/pagination/model/config.dart';
import 'package:kafil/core/components/pagination/ui/number_paginator.dart';
import 'package:kafil/core/utilities/extensions.dart';
import 'package:kafil/core/utilities/query_parameters.dart';
import 'package:kafil/features/countries/notifiers/country_notifiers.dart';
import 'package:kafil/features/countries/notifiers/pages_notifier.dart';
import 'package:kafil/generated/locale_keys.g.dart';

part '../widgets/country_pages.dart';

part '../widgets/country_table.dart';

class CountriesScreen extends ConsumerWidget {
  const CountriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        20.verticalSpace,
        const _CountryTable(),
        10.verticalSpace,
        const _CountryPages(),
      ],
    );
  }
}
