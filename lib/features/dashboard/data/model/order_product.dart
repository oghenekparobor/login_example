import 'package:kexze_logistics/features/dashboard/data/model/product.dart';
import 'package:kexze_logistics/features/dashboard/domain/entity/order_product.dart';

class OrderProductModel extends OrderProductEntity {
  OrderProductModel({
    required ProductModel product,
    required int productID,
    required int qunatity,
    required int vendorID,
  }) : super(
          product: product,
          productID: productID,
          qunatity: qunatity,
          vendorID: vendorID,
        );

  factory OrderProductModel.fromJson(Map map) {
    return OrderProductModel(
      product: ProductModel.fromJson(map['Product']),
      productID: map['ProductId'],
      qunatity: map['quantity'],
      vendorID: map['VendorId'],
    );
  }

  Map<String, dynamic> toJson() => {
        'Product': product.toJson(),
        'ProductId': productID,
        'quantity': qunatity,
        'VendorId': vendorID,
      };
}
