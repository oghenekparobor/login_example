import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kexze_logistics/config/routes/route.dart';
import 'package:kexze_logistics/config/routes/route_config.dart';
import 'package:kexze_logistics/features/dashboard/data/model/order.dart';
import 'package:kexze_logistics/features/dashboard/presentation/change-notifier/dashboard_notifier.dart';
import 'package:provider/provider.dart';

class CurrentOrdersBox extends StatefulWidget {
  const CurrentOrdersBox({
    Key? key,
    required this.order,
    this.fromCurrent = true,
  }) : super(key: key);

  final OrderModel order;
  final bool fromCurrent;

  @override
  State<CurrentOrdersBox> createState() => _CurrentOrdersBoxState();
}

class _CurrentOrdersBoxState extends State<CurrentOrdersBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 7.5),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Parcel ID:',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    widget.order.reference,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (widget.order.status.toLowerCase() == 'assigned') {
                      Application.router.navigateTo(
                        context,
                        Routes.startRide,
                        routeSettings: RouteSettings(
                          arguments: json.encode(widget.order.toJson()),
                        ),
                      );
                    } else {
                      Application.router.navigateTo(
                        context,
                        Routes.riding,
                        routeSettings: RouteSettings(
                          arguments: json.encode(widget.order.toJson()),
                        ),
                      );
                    }
                  },
                  child: Text(
                    'OPEN',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                )
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        'Status:',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          widget.order.status.toUpperCase(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.amber),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  '\$ ${widget.order.amount}',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        'Date:',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          DateFormat.yMMMMd().format(widget.order.created),
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  '${widget.order.orderProducts.length} Items',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 100,
              width: double.infinity,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: widget.order.orderProducts
                    .map((e) => Container(
                          padding: const EdgeInsets.all(8),
                          margin: const EdgeInsets.all(5),
                          color: Colors.white,
                          child: Column(
                            children: [
                              Text(e.product.name),
                              const SizedBox(height: 5),
                              Text(e.product.currentPrice),
                              const SizedBox(height: 5),
                              Text(e.qunatity.toString()),
                            ],
                          ),
                        ))
                    .toList(),
              ),
            ),
            const SizedBox(height: 10),
            if (widget.fromCurrent) const Divider(),
            if (widget.fromCurrent)
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Provider.of<DashboardNotifier>(
                        context,
                        listen: false,
                      ).removeOrder(widget.order),
                      child: Text(
                        'DECLINE ORDER',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: MaterialButton(
                      color: Theme.of(context).primaryColor,
                      onPressed: () => _acceptOrder(widget.order),
                      child: const Text(
                        'ACCEPT ORDER',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
          ],
        ),
      ),
    );
  }

  _acceptOrder(OrderModel order) {
    var dn = Provider.of<DashboardNotifier>(context, listen: false);

    dn.assignOrder(order).then((value) {
      value.fold(
        (l) => l,
        (r) => Application.router.navigateTo(
          context,
          Routes.startRide,
          clearStack: true,
          routeSettings: RouteSettings(arguments: json.encode(r.toJson())),
        ),
      );
    });
  }
}
