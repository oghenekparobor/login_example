import 'package:dartz/dartz.dart';
import 'package:kexze_logistics/core/usecases/usecases.dart';
import 'package:kexze_logistics/features/dashboard/domain/repository/d_repo.dart';

import '../../../../core/failure/failure.dart';
import '../../data/model/order.dart';

class AssignOrderUsecase extends Usecase<void, Map> {
  AssignOrderUsecase({
    required this.repository,
  });

  final DashboardRepository repository;

  @override
  Future<Either<Failure, OrderModel>> call(Map params) async =>
      await repository.assignOrder(params);
}
