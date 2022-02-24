import 'package:dartz/dartz.dart';

import '../../../../core/failure/failure.dart';
import '../../data/model/state.dart';

abstract class AuthRepository {
  Future<Either<Failure, void>> login(Map map);
  Future<Either<Failure, void>> createAccount(Map map);
  Future<Either<Failure, List<StateModel>>> getState();
  Future<void> logOut();
  Future<bool> isLoggedIn();
  Future<void> location();
}
