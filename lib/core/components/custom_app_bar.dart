import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final bool isBackIconAppear;
  final VoidCallback? onBack;
  final Color? color;

  const CustomAppBar({
    super.key,
    required this.title,
    this.isBackIconAppear = true,
    this.onBack,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: color,
      surfaceTintColor: color,
      title: Text(
        title,
      ),
      titleSpacing: isBackIconAppear ? 0 : 16.h,
      leading: isBackIconAppear
          ? GestureDetector(
              onTap: onBack,
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
              ),
            )
          : null,
    );
  }
}
