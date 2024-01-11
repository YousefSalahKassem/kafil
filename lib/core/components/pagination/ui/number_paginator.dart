import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kafil/core/components/pagination/model/config.dart';
import 'package:kafil/core/components/pagination/model/display_mode.dart';
import 'package:kafil/core/components/pagination/ui/number_paginator_controller.dart';
import 'package:kafil/core/components/pagination/ui/widgets/buttons/paginator_button.dart';
import 'package:kafil/core/components/pagination/ui/widgets/inherited_number_paginator.dart';
import 'package:kafil/core/components/pagination/ui/widgets/paginator_content.dart';
import 'package:kafil/core/themes/app_assets.dart';

typedef NumberPaginatorContentBuilder = Widget Function(int index);

/// The main widget used for creating a [NumberPaginator].
class NumberPaginator extends StatefulWidget {
  /// Total number of pages that should be shown.
  final int numberPages;

  /// Index of initially selected page.
  final int initialPage;

  /// This function is called when the user switches between pages. The received
  /// parameter indicates the selected index, starting from 0.
  final Function(int)? onPageChange;

  /// The UI config for the [NumberPaginator].
  final NumberPaginatorUIConfig config;

  /// A builder for the central content of the paginator. If provided, the
  /// [config] is ignored.
  final NumberPaginatorContentBuilder? contentBuilder;

  /// The controller for the paginator. Can be used to control the paginator from the outside.
  /// If not provided, a new controller is created.
  final NumberPaginatorController? controller;

  /// Whether the "prev" button should be shown.
  ///
  /// Defaults to `true`.
  final bool showPrevButton;

  /// Whether the "next" button should be shown.
  ///
  /// Defaults to `true`.
  final bool showNextButton;

  /// Content of the "previous" button which when pressed goes one page back.
  ///
  /// Defaults to:
  /// ```dart
  /// Icon(Icons.chevron_left),
  /// ```
  final Widget prevButtonContent;

  /// Content of the "next" button which when pressed goes one page forward.
  ///
  /// Defaults to:
  /// ```dart
  /// Icon(Icons.chevron_right),
  /// ```
  final Widget nextButtonContent;

  /// Builder option for providing a custom "previous" button.
  ///
  /// If this is provided, [prevButtonContent] is ignored.
  /// If [showPrevButton] is `false`, this is ignored.
  final WidgetBuilder? prevButtonBuilder;

  /// Builder option for providing a custom "next" button.
  ///
  /// If this is provided, [nextButtonContent] is ignored.
  /// If [showNextButton] is `false`, this is ignored.
  final WidgetBuilder? nextButtonBuilder;

  /// Creates an instance of [NumberPaginator].
  const NumberPaginator({
    Key? key,
    required this.numberPages,
    this.initialPage = 0,
    this.onPageChange,
    this.config = const NumberPaginatorUIConfig(),
    this.contentBuilder,
    this.controller,
    this.showPrevButton = true,
    this.showNextButton = true,
    this.prevButtonContent = const Icon(Icons.chevron_left),
    this.nextButtonContent = const Icon(Icons.chevron_right),
    this.prevButtonBuilder,
    this.nextButtonBuilder,
  })  : assert(initialPage >= 0),
        assert(initialPage <= numberPages - 1),
        super(key: key);

  const NumberPaginator.noPrevNextButtons({
    Key? key,
    required this.numberPages,
    this.initialPage = 0,
    this.onPageChange,
    this.config = const NumberPaginatorUIConfig(),
    this.contentBuilder,
    this.controller,
  })  : showPrevButton = false,
        showNextButton = false,
        prevButtonContent = const SizedBox(),
        nextButtonContent = const SizedBox(),
        prevButtonBuilder = null,
        nextButtonBuilder = null,
        assert(initialPage >= 0),
        assert(initialPage <= numberPages - 1),
        super(key: key);

  @override
  NumberPaginatorState createState() => NumberPaginatorState();
}

class NumberPaginatorState extends State<NumberPaginator> {
  late NumberPaginatorController _controller;

  @override
  void initState() {
    super.initState();

    _controller = widget.controller ??
        NumberPaginatorController(
          numberOfPages: widget.numberPages,
        );
    _controller.currentPage = widget.initialPage;
    _controller.addListener(() {
      widget.onPageChange?.call(_controller.currentPage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return InheritedNumberPaginator(
      numberPages: widget.numberPages,
      initialPage: widget.initialPage,
      onPageChange: _controller.navigateToPage,
      config: widget.config,
      child: SizedBox(
        height: 40.h,
        child: Row(
          children: [
            PaginatorButton(
              onPressed: () {
                _controller.currentPage = 0;
              },
              child: SvgPicture.asset(
                AppAssets.first,
              ),
            ),
            PaginatorButton(
              onPressed: _controller.currentPage > 0 ? _controller.prev : null,
              child: SvgPicture.asset(AppAssets.previous),
            ),
            ..._buildCenterContent(),
            PaginatorButton(
              onPressed: _controller.currentPage < widget.numberPages - 1
                  ? _controller.next
                  : null,
              child: SvgPicture.asset(AppAssets.next),
            ),
            PaginatorButton(
              onPressed: () {
                _controller.currentPage = widget.numberPages - 1;
              },
              child: SvgPicture.asset(AppAssets.last),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildCenterContent() {
    return [
      Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          child: PaginatorContent(
            currentPage: _controller.currentPage,
          ),
        ),
      ),
    ];
  }
}
