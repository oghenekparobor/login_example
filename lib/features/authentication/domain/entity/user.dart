class UserEntity {
  final int id;
  final String firstname;
  final String lastname;
  final String phone;
  final String gender;
  final String email;
  final String dateOfBirth;
  final String address;
  final String stateOfOrigin;
  final String lga;
  final String nin;
  final String nextOfKinName;
  final String nextOfKinAddress;
  final String nextOfKinPhone;
  final String passport;
  final String trackingId;

  UserEntity({
    required this.firstname,
    required this.lastname,
    required this.phone,
    required this.gender,
    required this.email,
    required this.dateOfBirth,
    required this.address,
    required this.stateOfOrigin,
    required this.lga,
    required this.nin,
    required this.nextOfKinAddress,
    required this.nextOfKinName,
    required this.nextOfKinPhone,
    required this.passport,
    required this.id,
    required this.trackingId,
  });
}
