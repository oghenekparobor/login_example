import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'route_handler.dart';

class Routes {
  static String root = "/";
  static String login = '/login';
  static String create = '/createAccount';
  static String finish = '/finishaccount';
  static String dashboard = '/dashboardHome';

  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      return const Scaffold(
        body: Center(
          child: Text('Page not found'),
        ),
      );
    });

    router.define(root, handler: rootHandler);
    router.define(login, handler: loginHandler);
    router.define(create, handler: createAcctHandler);
    router.define(finish, handler: finishAcctHandler);
    router.define(dashboard, handler: homeDashboardHandler);
  }
}
