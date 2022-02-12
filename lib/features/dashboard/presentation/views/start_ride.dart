import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:kexze_logistics/config/routes/route.dart';
import 'package:kexze_logistics/config/routes/route_config.dart';
import 'package:kexze_logistics/features/dashboard/data/model/order.dart';
import 'package:kexze_logistics/features/dashboard/presentation/change-notifier/dashboard_notifier.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class StartRide extends StatefulWidget {
  const StartRide({
    Key? key,
    required this.data,
  }) : super(key: key);

  final String data;

  @override
  State<StartRide> createState() => _StartRideState();
}

class _StartRideState extends State<StartRide> {
  @override
  Widget build(BuildContext context) {
    var order = OrderModel.fromJson(json.decode(widget.data));

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: FutureBuilder(
              future: Provider.of<DashboardNotifier>(
                context,
                listen: false,
              ).myLocattion(),
              builder: (_, s) {
                if (s.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 1,
                    ),
                  );
                } else {
                  if (s.data == null) return const SizedBox();
                  var data = s.data as LocationData;

                  return GoogleMap(
                    mapType: MapType.normal,
                    myLocationButtonEnabled: false,
                    myLocationEnabled: true,
                    zoomControlsEnabled: false,
                    markers: {
                      Marker(
                        markerId: const MarkerId('me'),
                        position: LatLng(data.latitude!, data.longitude!),
                        draggable: false,
                        flat: false,
                      ),
                    },
                    scrollGesturesEnabled: false,
                    zoomGesturesEnabled: false,
                    compassEnabled: false,
                    initialCameraPosition: CameraPosition(
                      bearing: 192.8334901395799,
                      target: LatLng(data.latitude!, data.longitude!),
                      tilt: 0.0,
                      zoom: 19.151926040649414,
                    ),
                  );
                }
              },
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.only(bottom: 15),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Column(
                        //   crossAxisAlignment: CrossAxisAlignment.stretch,
                        //   children: [
                        //     Text(
                        //       'FROM: 126 Mayne avenue road, Jakande Lagos',
                        //       style: Theme.of(context).textTheme.bodyText1,
                        //     ),
                        //     const SizedBox(height: 15),
                        //     Text(
                        //       'TO: Flat 22 smith street, Ikeja Lagos',
                        //       style: Theme.of(context).textTheme.bodyText1,
                        //     ),
                        //   ],
                        // ),
                        Row(
                          children: [
                            Text(
                              'Reciept:',
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                order.status,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                          ],
                        ),
                        // const SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              'Phone no:',
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                '-',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                          ],
                        ),
                        // const SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              'Payment:',
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                '-',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                          ],
                        ),
                        // const SizedBox(height: 10),
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
                        // const SizedBox(height: 10),
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
                        // const SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              'Distance:',
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                '-',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                          ],
                        ),
                        // const SizedBox(height: 10),
                      ],
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                    ),
                  ),
                  const Divider(),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          child: Text(
                            'BACK',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(
                                    color: Colors.amber,
                                    fontWeight: FontWeight.normal),
                          ),
                          onPressed: () => Application.router.pop(context),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: MaterialButton(
                            color: Theme.of(context).primaryColor,
                            child: Text(
                              'START RIDE',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal),
                            ),
                            onPressed: () => _startRide(order)),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  _startRide(OrderModel order) {
    Provider.of<DashboardNotifier>(
      context,
      listen: false,
    ).setOrderEnroute(order).then((value) {
      value.fold(
        (l) => l,
        (r) => Application.router.navigateTo(
          context,
          Routes.riding,
          routeSettings: RouteSettings(arguments: json.encode(order.toJson())),
        ),
      );
    });
  }
}
