import 'package:flutter/material.dart';
import 'package:kexze_logistics/config/routes/route.dart';
import 'package:kexze_logistics/config/routes/route_config.dart';
import 'package:kexze_logistics/core/assets/assets.dart';
import 'package:kexze_logistics/features/authentication/presentation/change-notifier/auth_notifier.dart';
import 'package:provider/provider.dart';

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
    return Scaffold(
      body: Center(
        child: Image.asset(kLOGO),
      ),
    );
  }
}
