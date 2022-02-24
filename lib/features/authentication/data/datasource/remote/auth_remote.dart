import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;

import '../../../../../core/constants/constants.dart';
import '../../model/user.dart';

abstract class AuthRemoteDatasource {
  Future<Map> login(Map map);
  Future<Map> createAccount(Map map);
  Future<List> getStates();
}

class AuthRemoteDatasourceImpl extends AuthRemoteDatasource {
  AuthRemoteDatasourceImpl({required this.dio, required this.client});

  final Dio dio;
  final http.Client client;

  @override
  Future<Map> createAccount(Map map) async {
    print(map);
    File file = File(map[UserMap.passport]);
    var filename = basename(file.path);

    var byte = await file.readAsBytes();

    //? Using dio
    var form = FormData();

    form.fields.add(MapEntry(UserMap.firstname, map[UserMap.firstname]));
    form.fields.add(MapEntry(UserMap.lastname, map[UserMap.lastname]));
    form.fields.add(MapEntry(UserMap.phone, map[UserMap.phone]));
    form.fields.add(MapEntry(UserMap.gender, map[UserMap.gender]));
    form.fields.add(MapEntry(UserMap.email, map[UserMap.email]));
    form.fields.add(MapEntry(UserMap.datebirth, map[UserMap.datebirth]));
    form.fields.add(MapEntry(UserMap.address, map[UserMap.address]));
    form.fields.add(MapEntry(UserMap.stateorigin, map[UserMap.stateorigin]));
    form.fields.add(MapEntry(UserMap.lga, map[UserMap.lga]));
    form.fields.add(MapEntry(UserMap.nin, map[UserMap.nin]));
    form.fields.add(MapEntry(UserMap.kinname, map[UserMap.kinname]));
    form.fields.add(MapEntry(UserMap.kinaddress, map[UserMap.kinaddress]));
    form.fields.add(MapEntry(UserMap.kinphone, map[UserMap.kinphone]));
    form.fields.add(MapEntry(UserMap.password, map[UserMap.password]));

    form.files.add(MapEntry(
      UserMap.passport,
      await MultipartFile.fromFile(file.path, filename: filename),
    ));

    // ? Using dio
    var response = await dio.post(
      '/signUp',
      data: form,
      options: Options(contentType: 'multipart/form-data'),
    );

    return response.data;
  }

  @override
  Future<Map> login(Map map) async {
    //? Using dio
    // var response = await dio.post('/login', data: map)
    // return response.data;

    //? Using http
    var response = await client.post(Uri.parse('$kBASEURL/login'), body: map);
    return json.decode(response.body);
  }

  @override
  Future<List> getStates() async {
    Dio dio = Dio();

    var response = await dio.post(
      'https://countriesnow.space/api/v0.1/countries/states/',
      data: {"country": "Nigeria"},
    );

    return response.data['data']['states'];
  }
}
