import 'package:flutter/material.dart';
import 'package:kafil/core/components/pagination/ui/widgets/paginator_content/number_content.dart';

class PaginatorContent extends StatelessWidget {
  final int currentPage;

  const PaginatorContent({
    Key? key,
    required this.currentPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NumberContent(
      currentPage: currentPage,
    );
  }
}
