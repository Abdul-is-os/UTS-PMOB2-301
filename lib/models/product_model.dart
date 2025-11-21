class ProductModel {
  final String id;
  final String name;
  final int price;
  final String image; // Asumsi ini adalah URL atau path aset

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
  });

  // Metode untuk mengkonversi ProductModel ke Map
  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'price': price, 'image': image};
  }

  // Metode static untuk membuat ProductModel dari Map
  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] as String,
      name: map['name'] as String,
      price: map['price'] as int,
      image: map['image'] as String,
    );
  }
}
