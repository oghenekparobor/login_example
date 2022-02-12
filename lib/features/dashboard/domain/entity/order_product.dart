import 'package:kexze_logistics/features/dashboard/data/model/product.dart';

class OrderProductEntity {
  final int productID;
  final int qunatity;
  final int vendorID;
  final ProductModel product;

  OrderProductEntity({
    required this.product,
    required this.productID,
    required this.qunatity,
    required this.vendorID,
  });
}
