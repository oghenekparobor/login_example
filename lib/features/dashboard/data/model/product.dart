import 'package:kexze_logistics/features/dashboard/domain/entity/product.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    required String currentPrice,
    required String name,
  }) : super(currentPrice: currentPrice, name: name);

  factory ProductModel.fromJson(Map map) {
    return ProductModel(
      currentPrice: map['name'],
      name: map['currentPrice'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'currentPrice': currentPrice,
      };
}
