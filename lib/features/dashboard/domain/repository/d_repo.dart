import 'package:dartz/dartz.dart';
import 'package:kexze_logistics/core/failure/failure.dart';
import 'package:kexze_logistics/features/dashboard/data/model/order.dart';
import 'package:location/location.dart';

abstract class DashboardRepository {
  Future<Either<Failure, List<OrderModel>>> pendingOrders();
  Future<Either<Failure, List<OrderModel>>> assignedOrders();
  Future<Either<Failure, List<OrderModel>>> enroutedOrders();
  Future<Either<Failure, List<OrderModel>>> deliveredOrders();
  Future<Either<Failure, List<OrderModel>>> orderHistory();
  Future<Either<Failure, OrderModel>> assignOrder(Map map);
  Future<Either<Failure, OrderModel>> setOrderEnroute(Map map);
  Future<Either<Failure, OrderModel>> setOrderDelivered(Map map);
  Future<bool> doesOrderExist();
  Future<OrderModel> getCurrentOrder();
  Future<LocationData> myLocation();
}
