import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kafil/core/utilities/extensions.dart';
import 'package:kafil/generated/locale_keys.g.dart';

class AppTextField extends ConsumerWidget {
  final bool isPassword;
  final bool isOptional;
  final bool isTrim;
  final int maxLines;
  final bool showError;
  final bool? readOnly;
  final TextInputType? inputType;
  final String? initialValue;
  final String? label;
  final TextEditingController? fieldController;
  final Widget? prefix;
  final Widget? suffix;
  final Function()? onPrefixTap;
  final Function()? onSuffixTap;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;

  const AppTextField({
    super.key,
    this.initialValue,
    this.fieldController,
    this.prefix,
    this.suffix,
    this.onPrefixTap,
    this.onSuffixTap,
    this.isPassword = false,
    this.isOptional = false,
    this.showError = false,
    this.label,
    this.readOnly,
    this.inputType,
    this.isTrim = true,
    this.maxLines = 1,
    this.onChanged,
    this.validator,
  });

  const AppTextField.name({
    super.key,
    this.initialValue,
    this.fieldController,
    this.onChanged,
    this.validator,
    this.maxLines = 1,
    this.label,
    this.readOnly,
    this.showError = false,
    this.isTrim = false,
    this.inputType,
  })  : isPassword = false,
        isOptional = false,
        prefix = null,
        suffix = null,
        onPrefixTap = null,
        onSuffixTap = null;

  AppTextField.email({
    super.key,
    this.initialValue,
    this.fieldController,
    this.maxLines = 1,
    this.onChanged,
    this.validator,
    this.readOnly,
    this.showError = false,
    this.isTrim = true,
  })  : isPassword = false,
        isOptional = false,
        prefix = null,
        suffix = null,
        label = LocaleKeys.login_email.tr(),
        onPrefixTap = null,
        inputType = TextInputType.emailAddress,
        onSuffixTap = null;

  const AppTextField.password({
    super.key,
    this.initialValue,
    this.fieldController,
    this.maxLines = 1,
    this.onChanged,
    this.isTrim = false,
    this.showError = false,
    this.validator,
    this.readOnly,
    this.label,
    this.inputType,
  })  : isPassword = true,
        isOptional = false,
        prefix = null,
        suffix = null,
        onPrefixTap = null,
        onSuffixTap = null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    final bool isPasswordVisible = ref.watch(_isPasswordVisible);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Text(label!, style: context.appTextStyles.bodyMedium),
        if (label != null) 8.verticalSpace,
        TextFormField(
          controller: fieldController,
          initialValue: initialValue,
          onChanged: onChanged,
          validator: validator,
          cursorColor: context.appTheme.primary,
          readOnly: readOnly ?? false,
          maxLines: maxLines,
          decoration: InputDecoration(
            prefixIcon: prefix,
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      ref.read(_isPasswordVisible.notifier).state =
                          !isPasswordVisible;
                    },
                  )
                : suffix,
            errorStyle: showError
                ? null
                : const TextStyle(
                    height: 0,
                    fontSize: 0,
                  ),
          ),
          scrollPadding: EdgeInsets.only(bottom: bottomInsets + 40.0),
          obscureText: isPassword && !ref.watch(_isPasswordVisible),
        ),
      ],
    );
  }
}

class TrimSpacesFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final trimmedText = newValue.text.trim();

    return TextEditingValue(
      text: trimmedText,
      selection: TextSelection.collapsed(offset: trimmedText.length),
    );
  }
}

final _isPasswordVisible = StateProvider((ref) => false);
