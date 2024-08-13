class ProductModel {
  final int id;
  final String name;
  final double cost;

  ProductModel({
    required this.cost,
    required this.id,
    required this.name,
  });

 Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'cost': cost,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'],
      name: map['name'],
      cost: map['cost'],
    );
  }
}
