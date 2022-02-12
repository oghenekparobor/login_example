import 'package:dio/dio.dart';
import 'package:kexze_logistics/core/failure/failure.dart';

import 'package:dartz/dartz.dart';
import 'package:kexze_logistics/core/network/network_info.dart';
import 'package:kexze_logistics/features/authentication/data/datasource/local/auth_local.dart';
import 'package:kexze_logistics/features/authentication/data/datasource/remote/auth_remote.dart';
import 'package:kexze_logistics/features/authentication/data/model/state.dart';

import '../../domain/repository/auth.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required this.localDatasource,
    required this.remoteDatasource,
    required this.networkInfo,
  });

  final AuthLocalDatasource localDatasource;
  final AuthRemoteDatasource remoteDatasource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, void>> createAccount(Map map) async {
    if (await networkInfo.isConnected()) {
      try {
        var data = await remoteDatasource.createAccount(map);
        await localDatasource.saveToken(data['token']);
        await localDatasource.saveUser(data['Logistics']);

        return const Right(null);
      } on DioError catch (e) {
        print(e.response!.data);
        print(e.response!.statusCode);
        if (e.response!.statusCode == 422) return Left(UserFound());
        if (e.type == DioErrorType.receiveTimeout) return Left(TimeOutError());
        if (e.type == DioErrorType.connectTimeout) return Left(TimeOutError());
        return Left(SomethingWentWrong());
      } catch (e) {
        print(e);
        return Left(UnexpectedError());
      }
    } else {
      return Left(ServerException());
    }
  }

  @override
  Future<Either<Failure, void>> login(Map map) async {
    if (await networkInfo.isConnected()) {
      try {
        var data = await remoteDatasource.login(map);
        await localDatasource.saveToken(data);
        await localDatasource.saveUser(data);

        return const Right(null);
      } on DioError catch (e) {
        print(e.response!.data);
        print(e.response!.statusCode);
        if (e.response!.statusCode == 422) return Left(InvalidCredential());
        if (e.response!.statusCode == 400) return Left(InvalidCredential());
        if (e.type == DioErrorType.receiveTimeout) return Left(TimeOutError());
        if (e.type == DioErrorType.connectTimeout) return Left(TimeOutError());
        return Left(SomethingWentWrong());
      } catch (e) {
        print(e);
        return Left(UnexpectedError());
      }
    } else {
      return Left(ServerException());
    }
  }

  @override
  Future<Either<Failure, List<StateModel>>> getState() async {
    if (await networkInfo.isConnected()) {
      try {
        var _lsit = <StateModel>[];
        var data = await remoteDatasource.getStates();

        for (var element in data) {
          _lsit.add(StateModel.fromJson(element));
        }

        return Right(_lsit);
      } on DioError catch (e) {
        if (e.type == DioErrorType.receiveTimeout) return Left(TimeOutError());
        if (e.type == DioErrorType.connectTimeout) return Left(TimeOutError());
        return Left(SomethingWentWrong());
      } catch (e) {
        return Left(UnexpectedError());
      }
    } else {
      return Left(ServerException());
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    return await localDatasource.isUserLoggedIn();
  }

  @override
  Future<void> logOut() async {
    return await localDatasource.logOut();
  }

  @override
  Future<void> location() async {
    var status = await localDatasource.isLocationallowed();

    if (!status) await localDatasource.allowLocation();
  }
}
