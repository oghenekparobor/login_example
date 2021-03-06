import 'package:dartz/dartz.dart';
import '../../../../core/usecases/usecases.dart';
import '../repository/auth.dart';
import '../../../../core/failure/failure.dart';
import '../../data/model/state.dart';

class GetStateUsecase extends Usecase<void, NoParams> {
  GetStateUsecase({
    required this.repository,
  });

  final AuthRepository repository;

  @override
  Future<Either<Failure, List<StateModel>>> call(NoParams params) async =>
      await repository.getState();
}
