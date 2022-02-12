import 'package:dartz/dartz.dart';
import 'package:kexze_logistics/core/usecases/usecases.dart';
import 'package:kexze_logistics/features/dashboard/domain/repository/d_repo.dart';

import '../../../../core/failure/failure.dart';
import '../../data/model/order.dart';

class OrderHistoryUsecase extends Usecase<void, NoParams> {
  OrderHistoryUsecase({
    required this.repository,
  });

  final DashboardRepository repository;

  @override
  Future<Either<Failure, List<OrderModel>>> call(NoParams params) async =>
      await repository.orderHistory();
}
