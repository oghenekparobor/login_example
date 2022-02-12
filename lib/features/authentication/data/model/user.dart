import '../../domain/entity/user.dart';

class UserModel extends UserEntity {
  UserModel(
      {required String firstname,
      required String lastname,
      required String phone,
      required String gender,
      required String email,
      required String dateOfBirth,
      required String address,
      required String stateOfOrigin,
      required String lga,
      required String nin,
      required String nextOfKinAddress,
      required String nextOfKinName,
      required String nextOfKinPhone,
      required String passport,
      required int id,
      required String trackingId})
      : super(
          firstname: firstname,
          lastname: lastname,
          phone: phone,
          gender: gender,
          email: email,
          dateOfBirth: dateOfBirth,
          address: address,
          stateOfOrigin: stateOfOrigin,
          lga: lga,
          nin: nin,
          nextOfKinAddress: nextOfKinAddress,
          nextOfKinName: nextOfKinName,
          nextOfKinPhone: nextOfKinPhone,
          passport: passport,
          id: id,
          trackingId: trackingId,
        );

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      firstname: map[UserMap.firstname],
      lastname: map[UserMap.lastname],
      phone: map[UserMap.phone],
      gender: map[UserMap.gender],
      email: map[UserMap.email],
      dateOfBirth: (map[UserMap.datebirth]),
      address: map[UserMap.address],
      stateOfOrigin: map[UserMap.stateorigin],
      lga: map[UserMap.lga],
      nin: map[UserMap.nin],
      nextOfKinAddress: map[UserMap.kinaddress],
      nextOfKinName: map[UserMap.kinname],
      nextOfKinPhone: map[UserMap.kinphone],
      passport: map[UserMap.passport],
      id: map[UserMap.id],
      trackingId: map[UserMap.track],
    );
  }

  Map<String, dynamic> toJson() => {
        UserMap.id: id,
        UserMap.firstname: firstname,
        UserMap.lastname: lastname,
        UserMap.address: address,
        UserMap.phone: phone,
        UserMap.gender: gender,
        UserMap.email: email,
        UserMap.datebirth: dateOfBirth,
        UserMap.stateorigin: stateOfOrigin,
        UserMap.lga: lga,
        UserMap.nin: nin,
        UserMap.kinname: nextOfKinName,
        UserMap.kinaddress: nextOfKinAddress,
        UserMap.kinphone: nextOfKinPhone,
        UserMap.passport: passport,
        UserMap.track: trackingId,
      };
}

class UserMap {
  static const id = 'RoleId';
  static const firstname = 'firstName';
  static const lastname = 'lastName';
  static const phone = 'phone';
  static const gender = 'gender';
  static const email = 'email';
  static const datebirth = 'dateOfBirth';
  static const address = 'address';
  static const stateorigin = 'stateOfOrigin';
  static const lga = 'LGA';
  static const nin = 'NIN';
  static const kinname = 'nextOfKinName';
  static const kinphone = 'nextOfKinPhone';
  static const kinaddress = 'nextOfKinAddress';
  static const passport = 'passportImage';
  static const track = 'trackingId';
  static const password = 'password';
}
