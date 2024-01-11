class ServiceModel {
  final int id;
  final String? image;
  final num price;
  final num? averageRating;
  final num? completedSalesCount;
  final num? priceAfterDiscount;
  final String title;
  final bool recommended;

  ServiceModel({
    required this.id,
    this.image,
    required this.price,
    this.averageRating,
    this.completedSalesCount,
    this.priceAfterDiscount,
    required this.title,
    required this.recommended,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'] as int,
      image: json['main_image'] as String?,
      price: json['price'] as num,
      averageRating: json['average_rating'] as num?,
      completedSalesCount: json['completed_sales_count'] as num?,
      priceAfterDiscount: json['price_after_discount'] as num?,
      title: json['title'] as String,
      recommended: json['recommended'] as bool,
    );
  }
}
