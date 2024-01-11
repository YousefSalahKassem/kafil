import 'package:flutter/material.dart';
import 'package:kafil/core/components/pagination/ui/widgets/inherited_number_paginator.dart';
import 'package:kafil/core/utilities/extensions.dart';

class PaginatorButton extends StatelessWidget {
  /// Callback for button press.
  final VoidCallback? onPressed;

  /// The child of the button.
  final Widget child;

  /// Whether the button is currently selected.
  final bool selected;

  /// Creates an instance of [PaginatorButton].
  const PaginatorButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.selected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          shape: InheritedNumberPaginator.of(context).config.buttonShape ??
              const CircleBorder(),
          side: BorderSide(
            color: context.appTheme.secondaryVariant.withOpacity(0.5),
          ),
          backgroundColor: _backgroundColor(context, selected),
          foregroundColor: _foregroundColor(context, selected),
        ),
        child: child,
      ),
    );
  }

  Color? _backgroundColor(BuildContext context, bool selected) => selected
      ? (InheritedNumberPaginator.of(context)
              .config
              .buttonSelectedBackgroundColor ??
          Theme.of(context).colorScheme.secondary)
      : InheritedNumberPaginator.of(context)
          .config
          .buttonUnselectedBackgroundColor;

  Color? _foregroundColor(BuildContext context, bool selected) => selected
      ? (InheritedNumberPaginator.of(context)
              .config
              .buttonSelectedForegroundColor ??
          Colors.white)
      : InheritedNumberPaginator.of(context)
          .config
          .buttonUnselectedForegroundColor;
}
