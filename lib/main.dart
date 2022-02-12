import 'package:bot_toast/bot_toast.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:kexze_logistics/config/theme/theme.dart';
import 'package:kexze_logistics/injector.dart';
import 'package:provider/provider.dart';

import 'config/routes/route.dart';
import 'config/routes/route_config.dart';
import 'features/authentication/presentation/change-notifier/auth_notifier.dart';
import 'features/dashboard/presentation/change-notifier/dashboard_notifier.dart';

void main() {
  setUp().then((_) => runApp(const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  _MyAppState() {
    final router = FluroRouter();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: getIt<AuthNotifier>()),
        ChangeNotifierProvider.value(value: getIt<DashboardNotifier>()),
      ],
      child: MaterialApp(
        title: 'Kexze Logitics',
        theme: theme(context),
        debugShowCheckedModeBanner: false,
        builder: BotToastInit(),
        navigatorObservers: [BotToastNavigatorObserver()],
        onGenerateRoute: Application.router.generator,
      ),
    );
  }
}
