import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:location/location.dart';

import '../../../../../core/constants/constants.dart';

abstract class AuthLocalDatasource {
  Future<void> saveToken(Map map);
  Future<void> saveUser(Map map);
  Future<bool> isUserLoggedIn();
  Future<void> logOut();
  Future<bool> isLocationallowed();
  Future<void> allowLocation();
}

class AuthLocalDatasourceImpl extends AuthLocalDatasource {
  AuthLocalDatasourceImpl({
    required this.secureStorage,
    required this.location,
  });

  final FlutterSecureStorage secureStorage;
  final Location location;

  @override
  Future<bool> isUserLoggedIn() async {
    var data = await secureStorage.read(key: kTOKEN);

    if (data != null) return true;
    return false;
  }

  @override
  Future<void> logOut() async {
    await secureStorage.delete(key: kUSER);
    await secureStorage.delete(key: kTOKEN);
  }

  @override
  Future<void> saveToken(Map map) async {
    await secureStorage.write(key: kTOKEN, value: (map['token']));
  }

  @override
  Future<void> saveUser(Map map) async {
    await secureStorage.write(key: kUSER, value: json.encode(map['Logistics']));
  }

  @override
  Future<void> allowLocation() async {
    await location.requestPermission();
    await location.requestService();
  }

  @override
  Future<bool> isLocationallowed() async {
    var status = await location.hasPermission();

    if (status == PermissionStatus.granted ||
        status == PermissionStatus.grantedLimited) {
      return true;
    } else {
      return false;
    }
  }
}
