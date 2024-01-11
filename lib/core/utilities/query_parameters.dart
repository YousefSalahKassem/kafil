class QueryParameters {
  final int? offset;
  QueryParameters({
    this.offset,
  });

  Map<String, dynamic> toJson() {
    return {
      if (offset != null) "page": offset,
    };
  }

  QueryParameters.empty() : offset = null;

  QueryParameters copyWith({
    int? offset,
  }) {
    return QueryParameters(
      offset: offset ?? this.offset,
    );
  }
}
