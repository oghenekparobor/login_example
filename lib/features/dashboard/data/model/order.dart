import 'package:kexze_logistics/features/dashboard/data/model/order_product.dart';
import 'package:kexze_logistics/features/dashboard/domain/entity/order.dart';

class OrderModel extends OrderEntity {
  OrderModel({
    required int id,
    required String reference,
    required String amount,
    required int customerID,
    required int billingAddressID,
    required String status,
    required dynamic logisticsID,
    required customerRate,
    required List<OrderProductModel> orderProducts,
    required DateTime created,
    required DateTime updated,
  }) : super(
          id: id,
          reference: reference,
          amount: amount,
          customerID: customerID,
          billingAddressID: billingAddressID,
          status: status,
          logisticsID: logisticsID,
          customerRate: customerRate,
          orderProducts: orderProducts,
          created: created,
          updated: updated,
        );

  factory OrderModel.fromJson(Map map) {
    var _list = <OrderProductModel>[];

    if (map['OrderProducts'] != null) {
      for (var e in (map['OrderProducts'] as List)) {
        _list.add(OrderProductModel.fromJson(e));
      }
    }

    return OrderModel(
      id: map['id'],
      reference: map['reference'],
      amount: map['amount'],
      customerID: map['CustomerId'],
      billingAddressID: map['BillingAddressId'],
      status: map['status'],
      logisticsID: map['logisticsId'],
      customerRate: map['customerRating'],
      orderProducts: _list,
      created: DateTime.parse(map['createdAt']),
      updated: DateTime.parse(map['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    var _list = <dynamic>[];

    for (var element in orderProducts) {
      _list.add(element.toJson());
    }

    return {
      'id': id,
      'reference': reference,
      'amount': amount,
      'CustomerId': customerID,
      'BillingAddressId': billingAddressID,
      'status': status,
      'logisticsId': logisticsID,
      'customerRating': customerRate,
      'OrderProducts': _list,
      'createdAt': created.toIso8601String(),
      'updatedAt': updated.toIso8601String(),
    };
  }
}
