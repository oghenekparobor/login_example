import 'package:flutter/material.dart';
import 'package:kexze_logistics/config/routes/route.dart';
import 'package:kexze_logistics/config/routes/route_config.dart';
import 'package:kexze_logistics/features/authentication/presentation/change-notifier/auth_notifier.dart';
import 'package:kexze_logistics/features/dashboard/presentation/views/assigned.dart';
import 'package:kexze_logistics/features/dashboard/presentation/views/current_orders.dart';
import 'package:kexze_logistics/features/dashboard/presentation/views/delivered.dart';
import 'package:kexze_logistics/features/dashboard/presentation/views/entoute.dart';
import 'package:kexze_logistics/features/dashboard/presentation/views/orders_history.dart';
import 'package:provider/provider.dart';

class DashboardHome extends StatefulWidget {
  const DashboardHome({Key? key}) : super(key: key);

  @override
  State<DashboardHome> createState() => _DashboardHomeState();
}

class _DashboardHomeState extends State<DashboardHome> {
  final _labels = const [
    'Assigned',
    'Enrouted',
    'Delivered',
    'Available',
    'History',
  ];

  final _tabs = const [
    Assigned(),
    Enroute(),
    Delivered(),
    CurrentOrders(),
    OrdersHistory(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _labels.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Orders', style: Theme.of(context).textTheme.headline1),
          centerTitle: true,
          bottom: TabBar(
            isScrollable: true,
            physics: const ClampingScrollPhysics(),
            tabs: _labels
                .map((e) => Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text(
                        e.toString(),
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ))
                .toList(),
          ),
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
        body: TabBarView(
          children: _tabs.map((e) => e).toList(),
          physics: const NeverScrollableScrollPhysics(),
        ),
      ),
    );
  }
}
