import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kexze_logistics/core/constants/constants.dart';
import 'package:kexze_logistics/features/dashboard/data/model/order.dart';
import 'package:location/location.dart';

abstract class DashboardLocalDatasource {
  Future<String> getToken();
  Future<void> saveCurrentOrder(OrderModel om);
  Future<bool> doesOrderExist();
  Future<OrderModel> getCurrentOrder();
  Future<void> deleteCurrentOrder();
  Future<LocationData> myLocation();
}

class DashboardLocalDatasourceImpl extends DashboardLocalDatasource {
  DashboardLocalDatasourceImpl({
    required this.secureStorage,
    required this.location,
  });

  final FlutterSecureStorage secureStorage;
  final Location location;

  @override
  Future<bool> doesOrderExist() async {
    var data = await secureStorage.read(key: kCURRENTORDER);

    if (data != null) return true;
    return false;
  }

  @override
  Future<OrderModel> getCurrentOrder() async {
    var data = await secureStorage.read(key: kCURRENTORDER);

    return OrderModel.fromJson(json.decode(data!));
  }

  @override
  Future<String> getToken() async {
    var data = await secureStorage.read(key: kTOKEN);

    return data!;
  }

  @override
  Future<void> saveCurrentOrder(OrderModel om) async {
    await secureStorage.write(
      key: kCURRENTORDER,
      value: json.encode(om.toJson()),
    );
  }

  @override
  Future<void> deleteCurrentOrder() async {
    await secureStorage.delete(key: kCURRENTORDER);
  }

  @override
  Future<LocationData> myLocation() async {
    // location.onLocationChanged.listen((event) {
    //   print(event);
    // });

    var loc = await location.getLocation();

    return loc;
  }
}
