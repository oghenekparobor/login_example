import 'package:flutter/material.dart';
import 'package:kexze_logistics/features/dashboard/presentation/change-notifier/dashboard_notifier.dart';
import 'package:kexze_logistics/features/dashboard/presentation/widgets/loader.dart';
import 'package:provider/provider.dart';

import '../../../../core/assets/assets.dart';
import '../widgets/order_box.dart';

class Enroute extends StatefulWidget {
  const Enroute({Key? key}) : super(key: key);

  @override
  _EnrouteState createState() => _EnrouteState();
}

class _EnrouteState extends State<Enroute> {
  // add preloader
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<DashboardNotifier>(
        context,
        listen: false,
      ).enroutedOrders(),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loader();
        } else {
          return Consumer<DashboardNotifier>(
            builder: (context, value, child) =>value.orders.isEmpty
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
              itemBuilder: (context, i) => OrderBox(order: value.orders[i]),
            ),
          );
        }
      },
    );
  }
}
