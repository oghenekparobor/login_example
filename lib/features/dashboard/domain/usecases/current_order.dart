import 'package:kexze_logistics/core/usecases/usecases.dart';
import 'package:kexze_logistics/features/dashboard/domain/repository/d_repo.dart';

import '../../data/model/order.dart';

class GetCurrentOrderUsecase extends Usecase<void, NoParams> {
  GetCurrentOrderUsecase({
    required this.repository,
  });

  final DashboardRepository repository;

  @override
  Future<OrderModel> call(NoParams params) async =>
      await repository.getCurrentOrder();
}
