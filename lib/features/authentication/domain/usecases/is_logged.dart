import '../../../../core/usecases/usecases.dart';
import '../repository/auth.dart';

class IsUserLoggedUsecase extends Usecase<void, NoParams> {
  IsUserLoggedUsecase({
    required this.repository,
  });

  final AuthRepository repository;

  @override
  Future<bool> call(NoParams params) async => await repository.isLoggedIn();
}
