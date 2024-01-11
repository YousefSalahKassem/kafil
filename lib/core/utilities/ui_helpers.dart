import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kafil/core/utilities/extensions.dart';
import 'package:kafil/generated/locale_keys.g.dart';

mixin UiHelpers {
  static void postBuildCallback(void Function(Duration) callback) {
    WidgetsBinding.instance.addPostFrameCallback(callback);
  }

  static void pickImageDialog(
    BuildContext context, {
    required void Function()? onGalleryPick,
    required void Function()? onCameraPick,
  }) {
    showCupertinoDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(
            LocaleKeys.common_title.tr(),
          ),
          content: Text(
            LocaleKeys.common_chooseDescription.tr(),
          ),
          actions: [
            TextButton(
              onPressed: onCameraPick,
              child: Text(
                LocaleKeys.common_camera.tr(),
                style: context.appTextStyles.subheadMedium,
              ),
            ),
            TextButton(
              onPressed: onGalleryPick,
              child: Text(
                LocaleKeys.common_gallery.tr(),
                style: context.appTextStyles.subheadMedium,
              ),
            ),
          ],
        );
      },
    );
  }
}
