import 'package:chips_input/chips_input.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kafil/core/components/app_text_field.dart';
import 'package:kafil/core/themes/app_assets.dart';
import 'package:kafil/core/utilities/extensions.dart';
import 'package:kafil/features/authentication/models/app_dependencies.dart';
import 'package:kafil/features/profile/notifiers/profile_notifier.dart';
import 'package:kafil/generated/locale_keys.g.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(ProfileNotifier.provider);
    // return profileState.when(
    //     data: (profile) {
    //       return SingleChildScrollView(
    //         child: Column(
    //           children: [],
    //         ),
    //       );
    //     },
    //     loading: () => const Center(
    //           child: CircularProgressIndicator(),
    //         ),
    //     error: (error) => Center(
    //           child: Text(error),
    //         ));
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: SingleChildScrollView(
        child: Column(
          children: [
            16.verticalSpace,
            const _ImageProfile(
              image:
                  "https://images.unsplash.com/photo-1608848461950-0fe51dfc41cb?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8MXx8fGVufDB8fHx8fA%3D%3D",
            ),
            32.verticalSpace,
            Row(
              children: [
                Expanded(
                  child: AppTextField.name(
                    label: LocaleKeys.register_firstPage_firstName.tr(),
                    initialValue: "yousef",
                    readOnly: true,
                  ),
                ),
                10.horizontalSpace,
                Expanded(
                  child: AppTextField.name(
                    label: LocaleKeys.register_firstPage_lastName.tr(),
                    readOnly: true,
                    initialValue: "salah",
                  ),
                ),
              ],
            ),
            16.verticalSpace,
            AppTextField.email(
              showError: true,
              readOnly: true,
              initialValue: "yousef.salah1@yahoo.com",
            ),
            16.verticalSpace,
            AppTextField.password(
              label: LocaleKeys.register_firstPage_password.tr(),
              showError: true,
              readOnly: true,
              initialValue: "no password",
            ),
            16.verticalSpace,
            AppTextField(
              label: LocaleKeys.register_secondPage_about.tr(),
              maxLines: 3,
              readOnly: true,
              initialValue:
                  "Lorem ipsum dolor sit amet consectetur. Odio urna sed velit et sed quis. Enim ut sed. sed quis. Enim ut sed.",
            ),
            16.verticalSpace,
            _UserType(
              type: 0,
            ),
            16.verticalSpace,
            AppTextField(
              label: LocaleKeys.register_secondPage_salary.tr(),
              readOnly: true,
              initialValue: "SAR 2000",
            ),
            16.verticalSpace,
            _Date(
              date: "2000-12-07",
            ),
            16.verticalSpace,
            _Gender(
              gender: 0,
            ),
            16.verticalSpace,
            _Skills(skills: []),
            30.verticalSpace,
          ],
        ),
      ),
    );
  }
}

class _ImageProfile extends ConsumerWidget {
  final String? image;

  const _ImageProfile({this.image});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        image != null
            ? CircleAvatar(
                radius: 51.r,
                backgroundColor: context.appTheme.primary,
                child: CircleAvatar(
                    radius: 50.r,
                    backgroundColor: const Color(0xFFE9FFF5),
                    backgroundImage: NetworkImage(
                      image!,
                    )),
              )
            : CircleAvatar(
                radius: 50.r,
                backgroundColor: const Color(0xFFE9FFF5),
                backgroundImage: const AssetImage(
                  AppAssets.defaultProfile,
                ),
              ),
        Positioned(
          bottom: 0,
          right: 0,
          child: CircleAvatar(
            backgroundColor: context.appTheme.primary,
            radius: 16.r,
            child: const Center(
              child: Icon(
                Icons.add,
              ),
            ),
          ),
        )
      ],
    );
  }
}

class _Date extends ConsumerWidget {
  final String date;

  const _Date({required this.date});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppTextField(
      initialValue: date,
      label: LocaleKeys.register_secondPage_date.tr(),
      suffix: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SvgPicture.asset(
          AppAssets.calendar,
          height: 20,
          width: 20,
        ),
      ),
      readOnly: true,
    );
  }
}

class _Gender extends ConsumerWidget {
  final num? gender;

  const _Gender({this.gender});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        16.verticalSpace,
        Text(
          LocaleKeys.register_secondPage_gender.tr(),
          style: context.appTextStyles.bodyMedium,
        ),
        8.verticalSpace,
        Row(
          children: [
            Row(
              children: [
                Radio(
                  fillColor: gender == 0
                      ? null
                      : MaterialStateProperty.all<Color>(
                          context.appTheme.secondaryVariant,
                        ),
                  activeColor: context.appTheme.primary,
                  value: 0,
                  groupValue: gender,
                  onChanged: (index) {},
                ),
                Text(
                  LocaleKeys.register_secondPage_males.tr(),
                  style: context.appTextStyles.bodyMedium.copyWith(
                    color: context.appTheme.black,
                  ),
                ),
              ],
            ),
            10.horizontalSpace,
            Row(
              children: [
                Radio(
                  fillColor: gender == 1
                      ? null
                      : MaterialStateProperty.all<Color>(
                          context.appTheme.secondaryVariant,
                        ),
                  activeColor: context.appTheme.primary,
                  value: 1,
                  groupValue: gender,
                  onChanged: (index) {},
                ),
                Text(
                  LocaleKeys.register_secondPage_females.tr(),
                  style: context.appTextStyles.bodyMedium.copyWith(
                    color: context.appTheme.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _UserType extends ConsumerWidget {
  final num? type;

  const _UserType({this.type});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        16.verticalSpace,
        Text(
          LocaleKeys.register_firstPage_userType.tr(),
          style: context.appTextStyles.bodyMedium,
        ),
        8.verticalSpace,
        Row(
          children: [
            Row(
              children: [
                Radio(
                  fillColor: type == 0
                      ? null
                      : MaterialStateProperty.all<Color>(
                          context.appTheme.secondaryVariant,
                        ),
                  activeColor: context.appTheme.primary,
                  value: 0,
                  groupValue: type,
                  onChanged: (index) {},
                ),
                Text(
                  LocaleKeys.register_secondPage_males.tr(),
                  style: context.appTextStyles.bodyMedium.copyWith(
                    color: context.appTheme.black,
                  ),
                ),
              ],
            ),
            10.horizontalSpace,
            Row(
              children: [
                Radio(
                  fillColor: type == 1
                      ? null
                      : MaterialStateProperty.all<Color>(
                          context.appTheme.secondaryVariant,
                        ),
                  activeColor: context.appTheme.primary,
                  value: 1,
                  groupValue: type,
                  onChanged: (index) {},
                ),
                Text(
                  LocaleKeys.register_secondPage_females.tr(),
                  style: context.appTextStyles.bodyMedium.copyWith(
                    color: context.appTheme.black,
                  ),
                ),
              ],
            ),
            10.horizontalSpace,
            Row(
              children: [
                Radio(
                  fillColor: type == 2
                      ? null
                      : MaterialStateProperty.all<Color>(
                          context.appTheme.secondaryVariant,
                        ),
                  activeColor: context.appTheme.primary,
                  value: 2,
                  groupValue: type,
                  onChanged: (index) {},
                ),
                Text(
                  LocaleKeys.register_secondPage_females.tr(),
                  style: context.appTextStyles.bodyMedium.copyWith(
                    color: context.appTheme.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _Skills extends ConsumerWidget {
  final List<Dependency> skills;

  const _Skills({
    required this.skills,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        16.verticalSpace,
        Text(
          LocaleKeys.register_secondPage_skills.tr(),
          style: context.appTextStyles.bodyMedium,
        ),
        8.verticalSpace,
        ChipsInput(
          initialValue: skills,
          chipBuilder: (context, state, skill) {
            return InputChip(
              key: ObjectKey(skill),
              label: Text(
                skill.label,
                style: context.appTextStyles.bodyMedium.copyWith(
                  color: context.appTheme.primary,
                ),
              ),
              deleteIconColor: context.appTheme.primary,
              backgroundColor: const Color(0xFFE9F9F1),
              onDeleted: () => state.deleteChip(skill),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            );
          },
          findSuggestions: (String query) {
            if (query.isNotEmpty) {
              final lowercaseQuery = query.toLowerCase();
              final results = skills.where((profile) {
                return profile.label
                        .toLowerCase()
                        .contains(query.toLowerCase()) ||
                    profile.label.toLowerCase().contains(query.toLowerCase());
              }).toList(growable: false)
                ..sort((a, b) => a.label
                    .toLowerCase()
                    .indexOf(lowercaseQuery)
                    .compareTo(b.label.toLowerCase().indexOf(lowercaseQuery)));
              return results;
            }
            return skills;
          },
          suggestionBuilder: (context, skill) {
            return ListTile(
              key: ObjectKey(skill),
              title: Text(
                skill.label,
              ),
            );
          },
          optionsViewBuilder: (context, onSelected, options) {
            return Align(
              alignment: Alignment.topLeft,
              child: Material(
                elevation: 4.0,
                surfaceTintColor: context.appTheme.white,
                color: context.appTheme.white,
                child: ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: options.length,
                  itemBuilder: (BuildContext context, int index) {
                    final option = options.elementAt(index);
                    return GestureDetector(
                      onTap: () {
                        onSelected(option);
                      },
                      child: ListTile(
                        key: ObjectKey(option),
                        title: Text(option.label),
                      ),
                    );
                  },
                ),
              ),
            );
          },
          onChanged: (options) {},
          readOnly: true,
        )
      ],
    );
  }
}

// class _Social extends ConsumerStatefulWidget {
//   final List<Social> social;
//
//   const _Social({
//     required this.social,
//   });
//
//   @override
//   ConsumerState<_Social> createState() => _SocialState();
// }
//
// class _SocialState extends ConsumerState<_Social> {
//   final images = [
//     AppAssets.facebook,
//     AppAssets.linkedin,
//     AppAssets.twitter,
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     final registerHolderController = ref.read(RegisterHolder.provider.notifier);
//     final registerHolderState = ref.watch(RegisterHolder.provider);
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         16.verticalSpace,
//         Text(
//           LocaleKeys.register_secondPage_social.tr(),
//           style: context.appTextStyles.bodyMedium,
//         ),
//         8.verticalSpace,
//         ListView.builder(
//           shrinkWrap: true,
//           itemCount: widget.social.length,
//           itemBuilder: (_, int index) {
//             final item = widget.social[index];
//             return GestureDetector(
//               child: CheckboxListTile(
//                 title: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SvgPicture.asset(
//                       images[index],
//                     ),
//                     10.horizontalSpace,
//                     Text(
//                       item.label == "X" ? "LinkedIn" : item.label,
//                       style: context.appTextStyles.bodyMedium,
//                     ),
//                   ],
//                 ),
//                 dense: true,
//                 contentPadding: EdgeInsets.zero,
//                 activeColor: context.appTheme.primary,
//                 value: registerHolderState.social.contains(item.value),
//                 onChanged: (_) {
//                   setState(() {
//                     if (registerHolderState.social.contains(item.value)) {
//                       registerHolderController.social.removeAt(index);
//                     } else {
//                       registerHolderController.social.add(item.value);
//                     }
//                   });
//                 },
//                 controlAffinity: ListTileControlAffinity.leading,
//               ),
//             );
//           },
//         ),
//       ],
//     );
//   }
// }
