import 'package:kafil/core/utilities/query_parameters.dart';

const kDefaultPaginationLimit = 10;

mixin Pagination<T> {
  // Pagination Variables
  int page = 1;
  QueryParameters queryParameters = QueryParameters(offset: 1);

  void nextOffset() {
    page += 1;
  }

  void previousOffset() {
    page -= 1;
  }

  void resetPagination() {
    page = 1;
    queryParameters = QueryParameters(offset: page);
  }
}
