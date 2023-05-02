class FavoriteModel {
  final String? userId;
  final List<String> productIds;

  FavoriteModel({
    this.userId,
    required this.productIds,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'productIds': productIds,
    };
  }

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> products = json['productIds'];
    final List<String> productIds = products.cast<String>();

    return FavoriteModel(
      userId: json['id'],
      productIds: productIds,
    );
  }
}
