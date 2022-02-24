import 'package:bot_toast/bot_toast.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import '../../../../core/failure/failure.dart';
import '../../../../core/usecases/usecases.dart';
import '../../data/model/state.dart';
import '../../data/model/user.dart';
import '../../domain/usecases/create.dart';
import '../../domain/usecases/is_logged.dart';
import '../../domain/usecases/location.dart';
import '../../domain/usecases/login.dart';
import '../../domain/usecases/logout.dart';
import '../../domain/usecases/state.dart';

class AuthNotifier with ChangeNotifier {
  AuthNotifier({
    required this.loginUsecase,
    required this.createAccountUsecase,
    required this.stateUsecase,
    required this.isUserLoggedUsecase,
    required this.logoutUsecase,
    required this.locationUsecase,
  });

  final LoginUsecase loginUsecase;
  final CreateAccountUsecase createAccountUsecase;
  final GetStateUsecase stateUsecase;
  final IsUserLoggedUsecase isUserLoggedUsecase;
  final LogoutUsecase logoutUsecase;
  final LocationUsecase locationUsecase;

  final _details = {
    UserMap.firstname: '',
    UserMap.lastname: '',
    UserMap.phone: '',
    UserMap.address: '',
    UserMap.gender: '',
    UserMap.email: '',
    UserMap.datebirth: '',
    UserMap.stateorigin: '',
    UserMap.lga: '',
    UserMap.nin: '',
    UserMap.kinname: '',
    UserMap.kinphone: '',
    UserMap.kinaddress: '',
    UserMap.passport: '',
    UserMap.password: '',
  };

  Map get details => _details;

  void setDetails(var key, var value) {
    _details.update(key, (_) => value);

    notifyListeners();
  }

  Future<void> location() async => await locationUsecase.call(NoParams());

  Future<Either<Function, void>> login() async {
    var data = await loginUsecase.call(_details);

    return data.fold(
      (l) => Left(BotToast.showSimpleNotification(
        title: 'Oops!',
        subTitle: FailureToString.mapFailureToMessage(l),
      )),
      (r) => Right(notifyListeners()),
    );
  }

  Future<Either<Function, void>> createAccount() async {
    var data = await createAccountUsecase.call(_details);

    return data.fold(
      (l) => Left(BotToast.showSimpleNotification(
        title: 'Oops!',
        subTitle: FailureToString.mapFailureToMessage(l),
      )),
      (r) => Right(notifyListeners()),
    );
  }

  var _states = <StateModel>[];

  List<StateModel> get states => _states;

  Future<Either<Function, void>> getStates() async {
    var data = await stateUsecase.call(NoParams());

    return data.fold(
      (l) => Left(BotToast.showSimpleNotification(
        title: 'Oops!',
        subTitle: FailureToString.mapFailureToMessage(l),
      )),
      (r) {
        _states = r;

        return Right(notifyListeners());
      },
    );
  }

  Future<bool> isUserLogged() async =>
      await isUserLoggedUsecase.call(NoParams());

  Future<void> logout() async => await logoutUsecase.call(NoParams());
}
