import 'package:flutter/material.dart';
import 'package:kexze_logistics/core/assets/assets.dart';
import 'package:kexze_logistics/features/dashboard/presentation/change-notifier/dashboard_notifier.dart';
import 'package:kexze_logistics/features/dashboard/presentation/widgets/loader.dart';
import 'package:provider/provider.dart';

import '../widgets/order_box.dart';

class Assigned extends StatefulWidget {
  const Assigned({Key? key}) : super(key: key);

  @override
  _AssignedState createState() => _AssignedState();
}

class _AssignedState extends State<Assigned> {
  // add preloader
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<DashboardNotifier>(
        context,
        listen: false,
      ).assignedOrders(),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loader();
        } else {
          return Consumer<DashboardNotifier>(
            builder: (context, value, child) => value.orders.isEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(kEMPTY),
                      const SizedBox(height: 10),
                      Text(
                        'Oops! Nothing here',
                        style: Theme.of(context).textTheme.bodyText2,
                      )
                    ],
                  )
                : ListView.builder(
                    itemCount: value.orders.length,
                    itemBuilder: (context, i) =>
                        OrderBox(order: value.orders[i]),
                  ),
          );
        }
      },
    );
  }
}
