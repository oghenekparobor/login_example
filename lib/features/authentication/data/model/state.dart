import 'package:kexze_logistics/features/authentication/domain/entity/state.dart';

class StateModel extends StateEntity {
  StateModel({
    required String name,
    required String stateCode,
  }) : super(name: name, stateCode: stateCode);

  factory StateModel.fromJson(Map<String, dynamic> map) {
    return StateModel(
      name: map['name'],
      stateCode: map['state_code'],
    );
  }
}
