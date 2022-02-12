import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:location_platform_interface/location_platform_interface.dart';

import '../../../../core/failure/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repository/d_repo.dart';
import '../datasource/local/d_local.dart';
import '../datasource/remote/d_remote.dart';
import '../model/order.dart';

class DashboardRepositoryImpl extends DashboardRepository {
  DashboardRepositoryImpl({
    required this.localDatasource,
    required this.remoteDatasource,
    required this.networkInfo,
  });

  final DashboardLocalDatasource localDatasource;
  final DashbordRemoteDatasource remoteDatasource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, OrderModel>> assignOrder(Map map) async {
    if (await networkInfo.isConnected()) {
      try {
        var token = await localDatasource.getToken();
        var data = await remoteDatasource.assignOrder(token, map);
        // await localDatasource.saveCurrentOrder(OrderModel.fromJson(data));

        return Right(OrderModel.fromJson(data));
      } on DioError catch (e) {
        if (e.type == DioErrorType.receiveTimeout) return Left(TimeOutError());
        if (e.type == DioErrorType.connectTimeout) return Left(TimeOutError());
        return Left(SomethingWentWrong());
      } catch (e) {
        return Left(UnexpectedError());
      }
    } else {
      return Left(ServerException());
    }
  }

  @override
  Future<Either<Failure, List<OrderModel>>> assignedOrders() async {
    if (await networkInfo.isConnected()) {
      try {
        var token = await localDatasource.getToken();
        var data = await remoteDatasource.assignedOrders(token);

        var _list = <OrderModel>[];

        for (var element in data) {
          _list.add(OrderModel.fromJson(element));
        }

        return Right(_list);
      } on DioError catch (e) {
        print(e.response!.data);
        if (e.type == DioErrorType.receiveTimeout) return Left(TimeOutError());
        if (e.type == DioErrorType.connectTimeout) return Left(TimeOutError());
        return Left(SomethingWentWrong());
      } catch (e) {
        return Left(UnexpectedError());
      }
    } else {
      return Left(ServerException());
    }
  }

  @override
  Future<Either<Failure, List<OrderModel>>> deliveredOrders() async {
    if (await networkInfo.isConnected()) {
      try {
        var token = await localDatasource.getToken();
        var data = await remoteDatasource.deliveredOrders(token);

        var _list = <OrderModel>[];

        for (var element in data) {
          _list.add(OrderModel.fromJson(element));
        }

        return Right(_list);
      } on DioError catch (e) {
        print(e.response!.data);
        if (e.type == DioErrorType.receiveTimeout) return Left(TimeOutError());
        if (e.type == DioErrorType.connectTimeout) return Left(TimeOutError());
        return Left(SomethingWentWrong());
      } catch (e) {
        return Left(UnexpectedError());
      }
    } else {
      return Left(ServerException());
    }
  }

  @override
  Future<Either<Failure, List<OrderModel>>> enroutedOrders() async {
    if (await networkInfo.isConnected()) {
      try {
        var token = await localDatasource.getToken();
        var data = await remoteDatasource.enroutedOrders(token);

        var _list = <OrderModel>[];

        for (var element in data) {
          _list.add(OrderModel.fromJson(element));
        }

        return Right(_list);
      } on DioError catch (e) {
        print(e.response!.data);
        if (e.type == DioErrorType.receiveTimeout) return Left(TimeOutError());
        if (e.type == DioErrorType.connectTimeout) return Left(TimeOutError());
        return Left(SomethingWentWrong());
      } catch (e) {
        return Left(UnexpectedError());
      }
    } else {
      return Left(ServerException());
    }
  }

  @override
  Future<Either<Failure, List<OrderModel>>> orderHistory() async {
    if (await networkInfo.isConnected()) {
      try {
        var token = await localDatasource.getToken();
        var data = await remoteDatasource.orderHistory(token);

        var _list = <OrderModel>[];

        for (var element in data) {
          _list.add(OrderModel.fromJson(element));
        }

        return Right(_list);
      } on DioError catch (e) {
        print(e.response!.data);
        if (e.type == DioErrorType.receiveTimeout) return Left(TimeOutError());
        if (e.type == DioErrorType.connectTimeout) return Left(TimeOutError());
        return Left(SomethingWentWrong());
      } catch (e) {
        return Left(UnexpectedError());
      }
    } else {
      return Left(ServerException());
    }
  }

  @override
  Future<Either<Failure, List<OrderModel>>> pendingOrders() async {
    if (await networkInfo.isConnected()) {
      try {
        var token = await localDatasource.getToken();
        var data = await remoteDatasource.pendingOrders(token);

        var _list = <OrderModel>[];

        for (var element in data) {
          _list.add(OrderModel.fromJson(element));
        }

        return Right(_list);
      } on DioError catch (e) {
        if (e.type == DioErrorType.receiveTimeout) return Left(TimeOutError());
        if (e.type == DioErrorType.connectTimeout) return Left(TimeOutError());
        return Left(SomethingWentWrong());
      } catch (e) {
        print(e);
        return Left(UnexpectedError());
      }
    } else {
      return Left(ServerException());
    }
  }

  @override
  Future<Either<Failure, OrderModel>> setOrderDelivered(Map map) async {
    if (await networkInfo.isConnected()) {
      try {
        var token = await localDatasource.getToken();
        var data = await remoteDatasource.setOrderDelivered(token, map);
        // await localDatasource.deleteCurrentOrder();

        return Right(OrderModel.fromJson(data));
      } on DioError catch (e) {
        if (e.type == DioErrorType.receiveTimeout) return Left(TimeOutError());
        if (e.type == DioErrorType.connectTimeout) return Left(TimeOutError());
        return Left(SomethingWentWrong());
      } catch (e) {
        return Left(UnexpectedError());
      }
    } else {
      return Left(ServerException());
    }
  }

  @override
  Future<Either<Failure, OrderModel>> setOrderEnroute(Map map) async {
    if (await networkInfo.isConnected()) {
      try {
        var token = await localDatasource.getToken();
        var data = await remoteDatasource.setOrderDelivered(token, map);
        // await localDatasource.saveCurrentOrder(OrderModel.fromJson(data));

        return Right(OrderModel.fromJson(data));
      } on DioError catch (e) {
        if (e.type == DioErrorType.receiveTimeout) return Left(TimeOutError());
        if (e.type == DioErrorType.connectTimeout) return Left(TimeOutError());
        return Left(SomethingWentWrong());
      } catch (e) {
        return Left(UnexpectedError());
      }
    } else {
      return Left(ServerException());
    }
  }

  @override
  Future<bool> doesOrderExist() async => await localDatasource.doesOrderExist();

  @override
  Future<OrderModel> getCurrentOrder() async =>
      await localDatasource.getCurrentOrder();

  @override
  Future<LocationData> myLocation() async => await localDatasource.myLocation();
}
