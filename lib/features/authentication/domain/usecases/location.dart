import '../../../../core/usecases/usecases.dart';
import '../repository/auth.dart';
class LocationUsecase extends Usecase<void, NoParams> {
  LocationUsecase({
    required this.repository,
  });

  final AuthRepository repository;

  @override
  Future<void> call(NoParams params) async => await repository.location();
}
