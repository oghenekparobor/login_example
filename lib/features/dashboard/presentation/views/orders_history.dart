import 'package:flutter/material.dart';
import 'package:kexze_logistics/features/dashboard/presentation/widgets/current_order_box.dart';
import 'package:kexze_logistics/features/dashboard/presentation/widgets/loader.dart';
import 'package:provider/provider.dart';

import '../../../../core/assets/assets.dart';
import '../change-notifier/dashboard_notifier.dart';

class OrdersHistory extends StatefulWidget {
  const OrdersHistory({Key? key}) : super(key: key);

  @override
  _OrdersHistoryState createState() => _OrdersHistoryState();
}

class _OrdersHistoryState extends State<OrdersHistory> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<DashboardNotifier>(
        context,
        listen: false,
      ).orderHistory(),
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
                    itemBuilder: (context, index) {
                      return CurrentOrdersBox(
                        order: value.orders[index],
                        fromCurrent: false,
                      );
                    },
                  ),
          );
        }
      },
    );
  }
}
