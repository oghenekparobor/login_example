import 'package:dartz/dartz.dart';
import 'package:kexze_logistics/core/usecases/usecases.dart';
import 'package:kexze_logistics/features/authentication/domain/repository/auth.dart';

import '../../../../core/failure/failure.dart';

class CreateAccountUsecase extends Usecase<void, Map> {
  CreateAccountUsecase({
    required this.repository,
  });

  final AuthRepository repository;

  @override
  Future<Either<Failure, void>> call(Map params) async =>
      await repository.createAccount(params);
}
