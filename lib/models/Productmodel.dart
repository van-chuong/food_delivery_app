class ProductModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final String categoryId;
  final String subCategoryId;
  final String created_at;
  final int quantity;
  final double rating;
  final int sales;
  final List<String> images;
  final List<String> ?favorites;
  ProductModel( {
    this.favorites,
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.categoryId,
    required this.subCategoryId,
    required this.created_at,
    required this.quantity,
    required this.rating,
    required this.sales,
    required this.images,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json['id'] as String,
    name: json['name'] as String,
    description: json['description'] as String,
    price: (json['price'] as num).toDouble(),
    categoryId: json['categoryId'] as String,
    subCategoryId: json['subCategoryId'] as String,
    created_at: json['created_at'] as String,
    quantity: (json['quantity'] as num).toInt(),
    rating: (json['rating'] as num).toDouble(),
    sales: (json['sales'] as num).toInt(),
    images: (json['images'] as List<dynamic>).map((e) => e as String).toList(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'price': price,
    'categoryId': categoryId,
    'subCategoryId': subCategoryId,
    'created_at': created_at,
    'quantity': quantity,
    'rating': rating,
    'sales': sales,
    'images': images,
  };
  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      price: (map['price'] as num).toDouble(),
      categoryId: map['categoryId'] as String,
      subCategoryId: map['subCategoryId'] as String,
      created_at: map['created_at'] as String,
      quantity: map['quantity'] as int,
      rating: (map['rating'] as num).toDouble(),
      sales: map['sales'] as int,
      images: (map['images'] as List<dynamic>).map((e) => e as String).toList(),
    );
  }
}
