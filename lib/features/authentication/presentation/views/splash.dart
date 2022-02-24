import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../config/routes/route.dart';
import '../../../../config/routes/route_config.dart';
import '../change-notifier/auth_notifier.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3)).then((value) {
      var an = Provider.of<AuthNotifier>(context, listen: false);

      an.location();

      an.isUserLogged().then((value) {
        if (value) {
          Application.router.navigateTo(
            context,
            Routes.dashboard,
            clearStack: true,
          );
        } else {
          Application.router.navigateTo(
            context,
            Routes.login,
            clearStack: true,
          );
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SizedBox(
          height: 100,
          width: 100,
          child: Placeholder(),
        ),
      ),
    );
  }
}
