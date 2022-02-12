import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kexze_logistics/config/routes/route.dart';
import 'package:kexze_logistics/config/routes/route_config.dart';
import 'package:kexze_logistics/features/dashboard/data/model/order.dart';
import 'package:kexze_logistics/features/dashboard/presentation/change-notifier/dashboard_notifier.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class Riding extends StatefulWidget {
  const Riding({
    Key? key,
    required this.data,
  }) : super(key: key);

  final String data;

  @override
  State<Riding> createState() => _RidingState();
}

class _RidingState extends State<Riding> {
  @override
  Widget build(BuildContext context) {
    var order = OrderModel.fromJson(json.decode(widget.data));

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Stack(
              children: [
                FutureBuilder(
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
                        markers: {
                          Marker(
                            markerId: const MarkerId('me'),
                            position: LatLng(data.latitude!, data.longitude!),
                            draggable: false,
                            flat: false,
                          ),
                        },
                        myLocationButtonEnabled: false,
                        myLocationEnabled: true,
                        zoomControlsEnabled: false,
                        initialCameraPosition: CameraPosition(
                          bearing: 192.8334901395799,
                          target: LatLng(data.latitude!, data.longitude!),
                          tilt: 59.440717697143555,
                          zoom: 19.151926040649414,
                        ),
                      );
                    }
                  },
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.all(15),
                    color: Colors.white,
                    child: ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      children: [
                        Text(
                          '0mins 0secs remaining',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.place),
                            const SizedBox(width: 5),
                            Text(
                              'Arrive destination',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top * 1.2,
                      right: 15,
                      left: 15,
                    ),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: () => Application.router.pop(context),
                        icon: const Icon(Icons.close),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 15),
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
            child: MaterialButton(
              onPressed: () => _completed(order),
              child: const Text(
                'DELIVERY COMPLETED',
                style: TextStyle(color: Colors.white),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: Theme.of(context).primaryColor,
            ),
          )
        ],
      ),
    );
  }

  _completed(OrderModel order) {
    Provider.of<DashboardNotifier>(
      context,
      listen: false,
    ).setOrderDelivered(order).then((value) {
      value.fold(
        (l) => l,
        (r) => Application.router.navigateTo(
          context,
          Routes.dashboard,
          clearStack: true,
        ),
      );
    });
  }
}
