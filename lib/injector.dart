import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:kexze_logistics/core/constants/constants.dart';
import 'package:kexze_logistics/features/authentication/data/datasource/local/auth_local.dart';
import 'package:kexze_logistics/features/authentication/data/datasource/remote/auth_remote.dart';
import 'package:kexze_logistics/features/authentication/data/repository/auth_impl.dart';
import 'package:kexze_logistics/features/authentication/domain/repository/auth.dart';
import 'package:kexze_logistics/features/authentication/domain/usecases/create.dart';
import 'package:kexze_logistics/features/authentication/domain/usecases/is_logged.dart';
import 'package:kexze_logistics/features/authentication/domain/usecases/location.dart';
import 'package:kexze_logistics/features/authentication/domain/usecases/login.dart';
import 'package:kexze_logistics/features/authentication/domain/usecases/logout.dart';
import 'package:kexze_logistics/features/authentication/domain/usecases/state.dart';
import 'package:kexze_logistics/features/authentication/presentation/change-notifier/auth_notifier.dart';
import 'package:kexze_logistics/features/dashboard/data/datasource/local/d_local.dart';
import 'package:kexze_logistics/features/dashboard/data/datasource/remote/d_remote.dart';
import 'package:kexze_logistics/features/dashboard/data/repository/d_repo_impl.dart';
import 'package:kexze_logistics/features/dashboard/domain/repository/d_repo.dart';
import 'package:kexze_logistics/features/dashboard/domain/usecases/assign_order.dart';
import 'package:kexze_logistics/features/dashboard/domain/usecases/assigned_orders.dart';
import 'package:kexze_logistics/features/dashboard/domain/usecases/current_order.dart';
import 'package:kexze_logistics/features/dashboard/domain/usecases/delivered_orders.dart';
import 'package:kexze_logistics/features/dashboard/domain/usecases/does_order_exist.dart';
import 'package:kexze_logistics/features/dashboard/domain/usecases/enroute_orders.dart';
import 'package:kexze_logistics/features/dashboard/domain/usecases/my_location.dart';
import 'package:kexze_logistics/features/dashboard/domain/usecases/order_history.dart';
import 'package:kexze_logistics/features/dashboard/domain/usecases/pending_orders.dart';
import 'package:kexze_logistics/features/dashboard/domain/usecases/set_order_delivered.dart';
import 'package:kexze_logistics/features/dashboard/domain/usecases/set_order_enroute.dart';
import 'package:kexze_logistics/features/dashboard/presentation/change-notifier/dashboard_notifier.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';

import 'core/network/network_info.dart';

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

  //! Dashboard
  //? Chnage notifier
  getIt.registerFactory<DashboardNotifier>(
    () => DashboardNotifier(
      assignOrderUsecase: getIt(),
      assignedOrdersUsecase: getIt(),
      deliveredOrderUsecase: getIt(),
      doesOrderExistUsecase: getIt(),
      enrouteOrdersUsecase: getIt(),
      getCurrentOrderUsecase: getIt(),
      orderHistoryUsecase: getIt(),
      pendingorderUsecase: getIt(),
      setOrderDeliveredUsecase: getIt(),
      setOrderEnrouteUsecase: getIt(),
      myLocationUsecase: getIt(),
    ),
  );

  //? Usecase
  getIt.registerLazySingleton(() => MyLocationUsecase(repository: getIt()));
  getIt.registerLazySingleton(() => AssignOrderUsecase(repository: getIt()));
  getIt.registerLazySingleton(() => AssignedOrdersUsecase(repository: getIt()));
  getIt.registerLazySingleton(() => DeliveredOrderUsecase(repository: getIt()));
  getIt.registerLazySingleton(() => DoesOrderExistUsecase(repository: getIt()));
  getIt.registerLazySingleton(() => EnrouteOrdersUsecase(repository: getIt()));
  getIt
      .registerLazySingleton(() => GetCurrentOrderUsecase(repository: getIt()));
  getIt.registerLazySingleton(() => OrderHistoryUsecase(repository: getIt()));
  getIt.registerLazySingleton(() => PendingorderUsecase(repository: getIt()));
  getIt.registerLazySingleton(
      () => SetOrderDeliveredUsecase(repository: getIt()));
  getIt
      .registerLazySingleton(() => SetOrderEnrouteUsecase(repository: getIt()));

  //? Repository
  getIt.registerLazySingleton<DashboardRepository>(
    () => DashboardRepositoryImpl(
      localDatasource: getIt(),
      remoteDatasource: getIt(),
      networkInfo: getIt(),
    ),
  );

  //? Data source
  getIt.registerLazySingleton<DashboardLocalDatasource>(() =>
      DashboardLocalDatasourceImpl(secureStorage: getIt(), location: getIt()));
  getIt.registerLazySingleton<DashbordRemoteDatasource>(
      () => DashbordRemoteDatasourceImpl(dio: getIt(), cLient: getIt()));
}
