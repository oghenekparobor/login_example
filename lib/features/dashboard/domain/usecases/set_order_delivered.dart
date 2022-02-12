import 'package:dartz/dartz.dart';
import 'package:kexze_logistics/core/usecases/usecases.dart';
import 'package:kexze_logistics/features/dashboard/domain/repository/d_repo.dart';

import '../../../../core/failure/failure.dart';
import '../../data/model/order.dart';

class SetOrderDeliveredUsecase extends Usecase<void, Map> {
  SetOrderDeliveredUsecase({
    required this.repository,
  });

  final DashboardRepository repository;

  @override
  Future<Either<Failure, OrderModel>> call(Map params) async =>
      await repository.setOrderEnroute(params);
}
