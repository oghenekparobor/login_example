import 'package:kexze_logistics/core/usecases/usecases.dart';
import 'package:kexze_logistics/features/dashboard/domain/repository/d_repo.dart';

class DoesOrderExistUsecase extends Usecase<void, NoParams> {
  DoesOrderExistUsecase({
    required this.repository,
  });

  final DashboardRepository repository;

  @override
  Future<bool> call(NoParams params) async => await repository.doesOrderExist();
}
