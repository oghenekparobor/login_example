import 'package:kexze_logistics/features/dashboard/data/model/order_product.dart';

class OrderEntity {
  final int id;
  final String reference;
  final String amount;
  final int customerID;
  final int billingAddressID;
  final String status;
  final dynamic logisticsID;
  dynamic customerRate;
  final List<OrderProductModel> orderProducts;
  final DateTime created;
  final DateTime updated;

  OrderEntity({
    required this.id,
    required this.reference,
    required this.amount,
    required this.customerID,
    required this.billingAddressID,
    required this.status,
    required this.logisticsID,
    required this.customerRate,
    required this.orderProducts,
    required this.created,
    required this.updated,
  });
}
