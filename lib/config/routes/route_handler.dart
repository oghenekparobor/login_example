import 'package:fluro/fluro.dart';
import 'package:flutter/widgets.dart';

import '../../features/authentication/presentation/views/create_account.dart';
import '../../features/authentication/presentation/views/finish_account.dart';
import '../../features/authentication/presentation/views/log_in.dart';
import '../../features/authentication/presentation/views/splash.dart';
import '../../features/dashboard/presentation/views/home.dart';

var rootHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return const SplashScreen();
});

var loginHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return const LogIn();
});

var createAcctHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return const CreateAccount();
});

var finishAcctHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return const FinishAccount();
});

var homeDashboardHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return const DashboardHome();
});

