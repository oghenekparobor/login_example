import 'package:kexze_logistics/core/usecases/usecases.dart';
import 'package:kexze_logistics/features/authentication/domain/repository/auth.dart';

class LogoutUsecase extends Usecase<void, NoParams> {
  LogoutUsecase({
    required this.repository,
  });

  final AuthRepository repository;
  @override
  Future<void> call(NoParams params) async => await repository.logOut();
}
