import 'package:bot_toast/bot_toast.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:kexze_logistics/core/failure/failure.dart';
import 'package:kexze_logistics/core/usecases/usecases.dart';
import 'package:kexze_logistics/features/dashboard/data/model/order.dart';
import 'package:kexze_logistics/features/dashboard/domain/usecases/assign_order.dart';
import 'package:kexze_logistics/features/dashboard/domain/usecases/assigned_orders.dart';
import 'package:kexze_logistics/features/dashboard/domain/usecases/current_order.dart';
import 'package:kexze_logistics/features/dashboard/domain/usecases/delivered_orders.dart';
import 'package:kexze_logistics/features/dashboard/domain/usecases/does_order_exist.dart';
import 'package:kexze_logistics/features/dashboard/domain/usecases/enroute_orders.dart';
import 'package:kexze_logistics/features/dashboard/domain/usecases/my_location.dart';
import 'package:kexze_logistics/features/dashboard/domain/usecases/order_history.dart';
import 'package:kexze_logistics/features/dashboard/domain/usecases/pending_orders.dart';
import 'package:kexze_logistics/features/dashboard/domain/usecases/set_order_delivered.dart';
import 'package:kexze_logistics/features/dashboard/domain/usecases/set_order_enroute.dart';
import 'package:location/location.dart';

class DashboardNotifier with ChangeNotifier {
  DashboardNotifier({
    required this.assignOrderUsecase,
    required this.assignedOrdersUsecase,
    required this.deliveredOrderUsecase,
    required this.doesOrderExistUsecase,
    required this.enrouteOrdersUsecase,
    required this.getCurrentOrderUsecase,
    required this.orderHistoryUsecase,
    required this.pendingorderUsecase,
    required this.setOrderDeliveredUsecase,
    required this.setOrderEnrouteUsecase,
    required this.myLocationUsecase,
  });

  final PendingorderUsecase pendingorderUsecase;
  final AssignedOrdersUsecase assignedOrdersUsecase;
  final EnrouteOrdersUsecase enrouteOrdersUsecase;
  final DeliveredOrderUsecase deliveredOrderUsecase;
  final OrderHistoryUsecase orderHistoryUsecase;
  final AssignOrderUsecase assignOrderUsecase;
  final SetOrderEnrouteUsecase setOrderEnrouteUsecase;
  final SetOrderDeliveredUsecase setOrderDeliveredUsecase;
  final DoesOrderExistUsecase doesOrderExistUsecase;
  final GetCurrentOrderUsecase getCurrentOrderUsecase;
  final MyLocationUsecase myLocationUsecase;

  var _orders = <OrderModel>[];

  List<OrderModel> get orders => _orders;

  Future<void> pendingOrders() async {
    var data = await pendingorderUsecase.call(NoParams());

    return data.fold(
      (l) => Left(BotToast.showSimpleNotification(
          title: 'Oops!', subTitle: FailureToString.mapFailureToMessage(l))),
      (r) {
        _orders.clear();
        _orders = r;

        notifyListeners();
      },
    );
  }

  Future<LocationData> myLocattion() async =>
      await myLocationUsecase.call(NoParams());

  Future<void> assignedOrders() async {
    var data = await assignedOrdersUsecase.call(NoParams());

    return data.fold(
      (l) => Left(BotToast.showSimpleNotification(
          title: 'Oops!', subTitle: FailureToString.mapFailureToMessage(l))),
      (r) {
        _orders.clear();
        _orders = r;

        notifyListeners();
      },
    );
  }

  Future<void> enroutedOrders() async {
    var data = await enrouteOrdersUsecase.call(NoParams());

    return data.fold(
      (l) => Left(BotToast.showSimpleNotification(
          title: 'Oops!', subTitle: FailureToString.mapFailureToMessage(l))),
      (r) {
        _orders.clear();
        _orders = r;

        notifyListeners();
      },
    );
  }

  Future<void> deliveredOrders() async {
    var data = await deliveredOrderUsecase.call(NoParams());

    return data.fold(
      (l) => Left(BotToast.showSimpleNotification(
          title: 'Oops!', subTitle: FailureToString.mapFailureToMessage(l))),
      (r) {
        _orders.clear();
        _orders = r;

        notifyListeners();
      },
    );
  }

  Future<void> orderHistory() async {
    var data = await orderHistoryUsecase.call(NoParams());

    return data.fold(
      (l) => Left(BotToast.showSimpleNotification(
          title: 'Oops!', subTitle: FailureToString.mapFailureToMessage(l))),
      (r) {
        _orders.clear();
        _orders = r;

        notifyListeners();
      },
    );
  }

  final _order = {
    'reference': '',
    'status': '',
  };

  Map get order => _order;

  void setOrder(var key, var value) {
    _order.update(key, (_) => value);
  }

  Future<Either<Function, OrderModel>> assignOrder(OrderModel om) async {
    _order.update('reference', (_) => om.reference);
    _order.update('status', (_) => 'assigned');

    var data = await assignOrderUsecase.call(_order);

    return data.fold(
      (l) => Left(BotToast.showSimpleNotification(
        title: 'Oops!',
        subTitle: FailureToString.mapFailureToMessage(l),
      )),
      (r) {
        _orders.removeWhere((element) => element.id == r.id);

        BotToast.showSimpleNotification(
          title: 'Hooray!',
          subTitle: 'Order has been assinged to you succesffuly',
        );

        notifyListeners();

        return Right(r);
      },
    );
  }

  Future<Either<Function, OrderModel>> setOrderEnroute(OrderModel om) async {
    _order.update('reference', (_) => om.reference);
    _order.update('status', (_) => 'enroute');

    var data = await setOrderEnrouteUsecase.call(_order);

    return data.fold(
      (l) => Left(BotToast.showSimpleNotification(
        title: 'Oops!',
        subTitle: FailureToString.mapFailureToMessage(l),
      )),
      (r) {
        _orders.removeWhere((element) => element.id == r.id);

        BotToast.showSimpleNotification(
          title: 'Hooray!',
          subTitle: 'Order status has been changed to enrouted successfully',
        );

        notifyListeners();

        return Right(r);
      },
    );
  }

  Future<Either<Function, OrderModel>> setOrderDelivered(OrderModel om) async {
    _order.update('reference', (_) => om.reference);
    _order.update('status', (_) => 'delivered');

    var data = await setOrderDeliveredUsecase.call(_order);

    return data.fold(
      (l) => Left(BotToast.showSimpleNotification(
        title: 'Oops!',
        subTitle: FailureToString.mapFailureToMessage(l),
      )),
      (r) {
        _orders.removeWhere((element) => element.id == r.id);

        BotToast.showSimpleNotification(
          title: 'Hooray!',
          subTitle: 'Order has been delivered succesffuly',
        );

        notifyListeners();

        return Right(r);
      },
    );
  }

  Future<bool> doesOrderExist() async =>
      await doesOrderExistUsecase.call(NoParams());

  Future<OrderModel> getCurrentOrder() async =>
      await getCurrentOrderUsecase.call(NoParams());

  void removeOrder(OrderModel om) {
    _orders.removeWhere((element) => element.id == om.id);

    notifyListeners();
  }
}
