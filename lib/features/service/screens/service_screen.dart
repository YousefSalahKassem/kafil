import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kafil/core/components/widget_life_cycle_listener.dart';
import 'package:kafil/core/themes/app_assets.dart';
import 'package:kafil/core/utilities/extensions.dart';
import 'package:kafil/core/utilities/ui_helpers.dart';
import 'package:kafil/features/service/models/service_model.dart';
import 'package:kafil/features/service/notifiers/service_notifiers.dart';
import 'package:kafil/generated/locale_keys.g.dart';

part '../widgets/service_widget.dart';

part '../widgets/service_card.dart';

part '../widgets/popular_service_widget.dart';

class ServiceScreen extends StatelessWidget {
  const ServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          16.verticalSpace,
          const _ServiceWidget(),
          20.verticalSpace,
          const _PopularServiceWidget(),
        ],
      ),
    );
  }
}
