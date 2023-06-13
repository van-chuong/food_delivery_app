class CartItemModel {
  String id;
  String name;
  String image;
  double price;
  int quantity;
  String description;

  CartItemModel(
      {required this.id,
      required this.name,
      required this.image,
      required this.price,
      required this.quantity,
      required this.description});

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      price: json['price'] is int ? (json['price'] as int).toDouble() : json['price'],
      quantity: json['quantity'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['description'] = this.description;
    return data;
  }
}
