import 'package:kexze_logistics/core/usecases/usecases.dart';
import 'package:kexze_logistics/features/authentication/domain/repository/auth.dart';

class IsUserLoggedUsecase extends Usecase<void, NoParams> {
  IsUserLoggedUsecase({
    required this.repository,
  });

  final AuthRepository repository;

  @override
  Future<bool> call(NoParams params) async => await repository.isLoggedIn();
}
