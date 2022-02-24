import 'package:dartz/dartz.dart';

import '../../../../core/failure/failure.dart';
import '../../../../core/usecases/usecases.dart';
import '../repository/auth.dart';

class CreateAccountUsecase extends Usecase<void, Map> {
  CreateAccountUsecase({
    required this.repository,
  });

  final AuthRepository repository;

  @override
  Future<Either<Failure, void>> call(Map params) async =>
      await repository.createAccount(params);
}
