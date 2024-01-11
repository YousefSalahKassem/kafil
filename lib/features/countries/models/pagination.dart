class Pagination {
  final int totalPages;

  Pagination({required this.totalPages});

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      totalPages: json['totalPages'] as int,
    );
  }
}
