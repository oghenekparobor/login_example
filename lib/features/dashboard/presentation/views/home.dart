import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../config/routes/route.dart';
import '../../../../config/routes/route_config.dart';
import '../../../authentication/presentation/change-notifier/auth_notifier.dart';

class DashboardHome extends StatefulWidget {
  const DashboardHome({Key? key}) : super(key: key);

  @override
  State<DashboardHome> createState() => _DashboardHomeState();
}

class _DashboardHomeState extends State<DashboardHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home', style: Theme.of(context).textTheme.headline1),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () => showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  content: const Text(
                    'Do you want to logout?',
                    textAlign: TextAlign.center,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Application.router.pop(context),
                      child: const Text('NO'),
                    ),
                    TextButton(
                      onPressed: () => Provider.of<AuthNotifier>(
                        context,
                        listen: false,
                      ).logout().then(
                            (value) => Application.router.navigateTo(
                              context,
                              Routes.login,
                              clearStack: true,
                            ),
                          ),
                      child: const Text('YES'),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        body: const Placeholder());
  }
}
