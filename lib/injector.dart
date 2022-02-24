import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';

import 'core/constants/constants.dart';
import 'core/network/network_info.dart';
import 'features/authentication/data/datasource/local/auth_local.dart';
import 'features/authentication/data/datasource/remote/auth_remote.dart';
import 'features/authentication/data/repository/auth_impl.dart';
import 'features/authentication/domain/repository/auth.dart';
import 'features/authentication/domain/usecases/create.dart';
import 'features/authentication/domain/usecases/is_logged.dart';
import 'features/authentication/domain/usecases/location.dart';
import 'features/authentication/domain/usecases/login.dart';
import 'features/authentication/domain/usecases/logout.dart';
import 'features/authentication/domain/usecases/state.dart';
import 'features/authentication/presentation/change-notifier/auth_notifier.dart';

GetIt getIt = GetIt.instance;

Future<void> setUp() async {
  //? storage
  getIt.registerLazySingleton<FlutterSecureStorage>(
      () => const FlutterSecureStorage());

  //? Dio
  var options = BaseOptions(
    connectTimeout: 5000,
    receiveTimeout: 3000,
    baseUrl: kBASEURL,
  );
  Dio dio = Dio(options);
  getIt.registerLazySingleton<Dio>(() => dio);

  //? Http
  getIt.registerLazySingleton<http.Client>(() => http.Client());

  //? location
  getIt.registerLazySingleton<Location>(() => Location());

  //! Core
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());

  //! Authentication
  //? Change notifier
  getIt.registerFactory<AuthNotifier>(
    () => AuthNotifier(
      loginUsecase: getIt(),
      createAccountUsecase: getIt(),
      stateUsecase: getIt(),
      isUserLoggedUsecase: getIt(),
      logoutUsecase: getIt(),
      locationUsecase: getIt(),
    ),
  );

  //? Usecases
  getIt.registerLazySingleton(() => LoginUsecase(repository: getIt()));
  getIt.registerLazySingleton(() => CreateAccountUsecase(repository: getIt()));
  getIt.registerLazySingleton(() => GetStateUsecase(repository: getIt()));
  getIt.registerLazySingleton(() => IsUserLoggedUsecase(repository: getIt()));
  getIt.registerLazySingleton(() => LogoutUsecase(repository: getIt()));
  getIt.registerLazySingleton(() => LocationUsecase(repository: getIt()));

  //? Repository
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      localDatasource: getIt(),
      remoteDatasource: getIt(),
      networkInfo: getIt(),
    ),
  );

  //? Datasource
  getIt.registerLazySingleton<AuthLocalDatasource>(
      () => AuthLocalDatasourceImpl(secureStorage: getIt(), location: getIt()));
  getIt.registerLazySingleton<AuthRemoteDatasource>(
      () => AuthRemoteDatasourceImpl(dio: getIt(), client: getIt()));

}
