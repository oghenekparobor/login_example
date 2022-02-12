import 'package:fluro/fluro.dart';
import 'package:flutter/widgets.dart';
import 'package:kexze_logistics/features/authentication/presentation/views/create_account.dart';
import 'package:kexze_logistics/features/authentication/presentation/views/finish_account.dart';
import 'package:kexze_logistics/features/authentication/presentation/views/log_in.dart';
import 'package:kexze_logistics/features/dashboard/presentation/views/home.dart';
import 'package:kexze_logistics/features/dashboard/presentation/views/riding.dart';
import 'package:kexze_logistics/features/dashboard/presentation/views/start_ride.dart';

import '../../features/authentication/presentation/views/splash.dart';

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

var startRideHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  var data = context!.settings!.arguments as String;

  return  StartRide(data: data);
});

var ridingHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  var data = context!.settings!.arguments as String;

  return  Riding(data: data);
});
