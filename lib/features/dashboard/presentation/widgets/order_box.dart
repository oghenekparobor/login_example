import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kexze_logistics/features/dashboard/data/model/order.dart';

import '../../../../config/routes/route.dart';
import '../../../../config/routes/route_config.dart';

class OrderBox extends StatelessWidget {
  const OrderBox({
    Key? key,
    required this.order,
  }) : super(key: key);

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      margin: const EdgeInsets.symmetric(vertical: 7.5),
      height: 170,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Text(
                      'Parcel ID:',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        order.reference,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  if (order.status.toLowerCase() == 'assigned') {
                    Application.router.navigateTo(
                      context,
                      Routes.startRide,
                      routeSettings: RouteSettings(
                        arguments: json.encode(order.toJson()),
                      ),
                    );
                  } else {
                    Application.router.navigateTo(
                      context,
                      Routes.riding,
                      routeSettings: RouteSettings(
                        arguments: json.encode(order.toJson()),
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
          Row(
            children: [
              Text(
                'Date:',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  DateFormat.yMMMd().format(order.created),
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'Time:',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  DateFormat.jms().format(order.created),
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'Status:',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  order.status,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: order.status.toLowerCase() != 'delivered'
                          ? Colors.amber
                          : Colors.green),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
