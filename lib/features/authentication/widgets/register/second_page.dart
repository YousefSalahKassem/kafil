part of '../../screens/register_screen.dart';

class _SecondPage extends ConsumerWidget {
  const _SecondPage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerHolderController = ref.read(RegisterHolder.provider.notifier);
    final dependencyState = ref.watch(DependenciesNotifier.provider);
    final registerHolderState = ref.watch(RegisterHolder.provider);

    return Form(
      key: registerHolderController.secondFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(child: _ImageProfile()),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: registerHolderState.showError
                ? Container(
                    key: UniqueKey(),
                    width: context.width,
                    padding:
                        EdgeInsets.symmetric(horizontal: 19.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: context.appTheme.errorField,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline_rounded,
                          color: context.appTheme.error,
                        ),
                        16.horizontalSpace,
                        Text(
                          LocaleKeys.errors_requiredAll.tr(),
                          style: context.appTextStyles.bodyMedium.copyWith(
                            color: context.appTheme.error,
                          ),
                        )
                      ],
                    ),
                  )
                : const SizedBox(), // Empty SizedBox when not showing the error
          ),
          if (registerHolderState.showError) 16.verticalSpace,
          AppTextField(
            label: LocaleKeys.register_secondPage_about.tr(),
            maxLines: 3,
            fieldController: registerHolderController.aboutController,
            validator: (value) => value!.validate([
              validateRequired,
              validateAbout,
            ]),
          ),
          const _Salary(),
          const _Date(),
          const _Gender(),
          dependencyState.when(
            data: (dependencies) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Skills(
                    skills: dependencies.tags,
                  ),
                  _Social(
                    social: dependencies.socialMedia,
                  ),
                ],
              );
            },
            loading: () => const SizedBox(),
            error: (_) => const SizedBox(),
          )
        ],
      ),
    );
  }
}

class _ImageProfile extends ConsumerWidget {
  const _ImageProfile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerHolderController = ref.read(RegisterHolder.provider.notifier);

    final registerHolderState = ref.watch(RegisterHolder.provider);
    Future<void> _pickImage(ImageSource source) async {
      final picker = ImagePicker();
      final pickedImage = await picker.pickImage(source: source);

      if (pickedImage != null) {
        registerHolderController.file = File(pickedImage.path);
      }
      context.pop();
    }

    return GestureDetector(
      onTap: () {
        UiHelpers.pickImageDialog(
          context,
          onGalleryPick: () {
            _pickImage(ImageSource.gallery);
          },
          onCameraPick: () {
            _pickImage(ImageSource.camera);
          },
        );
      },
      child: Stack(
        children: [
          registerHolderState.file != null
              ? CircleAvatar(
                  radius: 51.r,
                  backgroundColor: context.appTheme.primary,
                  child: CircleAvatar(
                      radius: 50.r,
                      backgroundColor: const Color(0xFFE9FFF5),
                      backgroundImage: FileImage(
                        registerHolderState.file!,
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
      ),
    );
  }
}

class _Salary extends ConsumerWidget {
  const _Salary();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerHolderController = ref.read(RegisterHolder.provider.notifier);
    final salary = ref.watch(RegisterHolder.provider).currentSalary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        16.verticalSpace,
        Text(
          LocaleKeys.register_secondPage_salary.tr(),
          style: context.appTextStyles.bodyMedium,
        ),
        8.verticalSpace,
        Container(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          width: context.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: context.theme.inputDecorationTheme.fillColor),
          child: Row(
            children: [
              40.horizontalSpace,
              GestureDetector(
                onTap: () {
                  registerHolderController.decrementSalary();
                },
                child: Material(
                  elevation: 2,
                  borderRadius: BorderRadius.circular(100.r),
                  surfaceTintColor:
                      context.theme.inputDecorationTheme.fillColor,
                  color: context.theme.inputDecorationTheme.fillColor,
                  child: CircleAvatar(
                    backgroundColor: context.appTheme.white,
                    radius: 16.r,
                    child: Center(
                      child: Icon(
                        Icons.remove,
                        color: context.appTheme.primary,
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Text(
                "SAR $salary",
                style: context.appTextStyles.titleMedium,
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  registerHolderController.incrementSalary();
                },
                child: Material(
                  elevation: 2,
                  borderRadius: BorderRadius.circular(100.r),
                  surfaceTintColor:
                      context.theme.inputDecorationTheme.fillColor,
                  color: context.theme.inputDecorationTheme.fillColor,
                  child: CircleAvatar(
                    backgroundColor: context.appTheme.white,
                    radius: 16.r,
                    child: Center(
                      child: Icon(
                        Icons.add,
                        color: context.appTheme.primary,
                      ),
                    ),
                  ),
                ),
              ),
              40.horizontalSpace
            ],
          ),
        ),
        16.verticalSpace,
      ],
    );
  }
}

class _Date extends ConsumerWidget {
  const _Date();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerHolderController = ref.read(RegisterHolder.provider.notifier);

    return AppTextField(
      fieldController: registerHolderController.dateController,
      label: LocaleKeys.register_secondPage_date.tr(),
      suffix: GestureDetector(
        onTap: () async {
          await showCupertinoModalPopup<void>(
            context: context,
            builder: (_) {
              final size = MediaQuery.of(context).size;
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                height: size.height * 0.27,
                child: CupertinoDatePicker(
                  initialDateTime: DateTime.now(),
                  minimumYear: 2000,
                  maximumYear: 3000,
                  mode: CupertinoDatePickerMode.date,
                  onDateTimeChanged: (value) {
                    registerHolderController.dateController.text =
                        "$value".split(' ')[0];
                  },
                ),
              );
            },
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SvgPicture.asset(
            AppAssets.calendar,
            height: 20,
            width: 20,
          ),
        ),
      ),
      validator: (value) => value!.validate([validateRequired]),
      showError: true,
      readOnly: true,
    );
  }
}

class _Gender extends ConsumerWidget {
  const _Gender();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerHolderController = ref.read(RegisterHolder.provider.notifier);
    final registerHolderState = ref.watch(RegisterHolder.provider);

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
                  fillColor: registerHolderState.currentGender == 0
                      ? null
                      : MaterialStateProperty.all<Color>(
                          context.appTheme.secondaryVariant,
                        ),
                  activeColor: context.appTheme.primary,
                  value: 0,
                  groupValue: registerHolderState.currentGender,
                  onChanged: (index) {
                    registerHolderController.currentGender = index!;
                  },
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
                  fillColor: registerHolderState.currentGender == 1
                      ? null
                      : MaterialStateProperty.all<Color>(
                          context.appTheme.secondaryVariant,
                        ),
                  activeColor: context.appTheme.primary,
                  value: 1,
                  groupValue: registerHolderState.currentGender,
                  onChanged: (index) {
                    registerHolderController.currentGender = index!;
                  },
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
    final registerHolderController = ref.read(RegisterHolder.provider.notifier);
    final registerHolderState = ref.watch(RegisterHolder.provider);

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
          initialValue: skills
              .where((element) =>
                  registerHolderState.skills.contains(element.value))
              .toList(),
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
          onChanged: (options) {
            registerHolderController.skills =
                options.map((e) => e.value).toList();
          },
        )
      ],
    );
  }
}

class _Social extends ConsumerStatefulWidget {
  final List<Social> social;

  const _Social({
    required this.social,
  });

  @override
  ConsumerState<_Social> createState() => _SocialState();
}

class _SocialState extends ConsumerState<_Social> {
  final images = [
    AppAssets.facebook,
    AppAssets.linkedin,
    AppAssets.twitter,
  ];

  @override
  Widget build(BuildContext context) {
    final registerHolderController = ref.read(RegisterHolder.provider.notifier);
    final registerHolderState = ref.watch(RegisterHolder.provider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        16.verticalSpace,
        Text(
          LocaleKeys.register_secondPage_social.tr(),
          style: context.appTextStyles.bodyMedium,
        ),
        8.verticalSpace,
        ListView.builder(
          shrinkWrap: true,
          itemCount: widget.social.length,
          itemBuilder: (_, int index) {
            final item = widget.social[index];
            return GestureDetector(
              child: CheckboxListTile(
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      images[index],
                    ),
                    10.horizontalSpace,
                    Text(
                      item.label == "X" ? "LinkedIn" : item.label,
                      style: context.appTextStyles.bodyMedium,
                    ),
                  ],
                ),
                dense: true,
                contentPadding: EdgeInsets.zero,
                activeColor: context.appTheme.primary,
                value: registerHolderState.social.contains(item.value),
                onChanged: (_) {
                  setState(() {
                    if (registerHolderState.social.contains(item.value)) {
                      registerHolderController.social.removeAt(index);
                    } else {
                      registerHolderController.social.add(item.value);
                    }
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),
            );
          },
        ),
      ],
    );
  }
}
