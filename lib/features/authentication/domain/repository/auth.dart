import 'package:dartz/dartz.dart';
import 'package:kexze_logistics/core/failure/failure.dart';
import 'package:kexze_logistics/features/authentication/data/model/state.dart';

abstract class AuthRepository {
  Future<Either<Failure, void>> login(Map map);
  Future<Either<Failure, void>> createAccount(Map map);
  Future<Either<Failure, List<StateModel>>> getState();
  Future<void> logOut();
  Future<bool> isLoggedIn();
  Future<void> location();
}
