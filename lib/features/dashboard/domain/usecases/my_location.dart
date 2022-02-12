import 'package:kexze_logistics/core/usecases/usecases.dart';
import 'package:kexze_logistics/features/dashboard/domain/repository/d_repo.dart';
import 'package:location/location.dart';

class MyLocationUsecase extends Usecase<void, NoParams> {
  MyLocationUsecase({
    required this.repository,
  });

  final DashboardRepository repository;

  @override
  Future<LocationData> call(NoParams params) async =>
      await repository.myLocation();
}
