import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:kexze_logistics/core/constants/constants.dart';

abstract class DashbordRemoteDatasource {
  Future<List> pendingOrders(String token);
  Future<List> assignedOrders(String token);
  Future<List> enroutedOrders(String token);
  Future<List> deliveredOrders(String token);
  Future<List> orderHistory(String token);
  Future<Map> assignOrder(String token, Map map);
  Future<Map> setOrderEnroute(String token, Map map);
  Future<Map> setOrderDelivered(String token, Map map);
}

class DashbordRemoteDatasourceImpl extends DashbordRemoteDatasource {
  DashbordRemoteDatasourceImpl({
    required this.dio,
    required this.cLient,
  });

  final Dio dio;
  final http.Client cLient;

  @override
  Future<Map> assignOrder(String token, Map map) async {
    var response = await dio.post(
      '/orderStatus',
      data: map,
      options: Options(headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      }),
    );

    return response.data;
  }

  @override
  Future<List> assignedOrders(String token) async {
    var response = await dio.get(
      '/orders?status=assigned',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    return response.data;
  }

  @override
  Future<List> deliveredOrders(String token) async {
    var response = await dio.get(
      '/orders?status=delivered',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    return response.data;
  }

  @override
  Future<List> enroutedOrders(String token) async {
    var response = await dio.get(
      '/orders?status=enroute',
      options: Options(headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      }),
    );

    return response.data;
  }

  @override
  Future<List> orderHistory(String token) async {
    var response = await dio.get(
      '/orderHistory',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    return response.data;
  }

  @override
  Future<List> pendingOrders(String token) async {
    var response = await dio.get(
      '/orders?status=pending',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    return response.data;
  }

  @override
  Future<Map> setOrderDelivered(String token, Map map) async {
    var response = await dio.post(
      '/orderStatus',
      data: map,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    return response.data;
  }

  @override
  Future<Map> setOrderEnroute(String token, Map map) async {
    var response = await dio.post(
      '/orderStatus',
      data: map,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    return response.data;
  }
}
