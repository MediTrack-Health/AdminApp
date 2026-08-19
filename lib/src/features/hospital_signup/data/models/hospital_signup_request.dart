class HospitalSignupRequest {
  final String hospitalName;
  final int hospitalTypeId;
  final String address;
  final String email;
  final String mobileNumber;
  final String contactPersonName;
  final String registrationNumber;
  final String yearEstablished;
  final String password;

  HospitalSignupRequest({
    required this.hospitalName,
    required this.hospitalTypeId,
    required this.address,
    required this.email,
    required this.mobileNumber,
    required this.contactPersonName,
    required this.registrationNumber,
    required this.yearEstablished,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      "hospitalName": hospitalName,
      "hospitalTypeId": hospitalTypeId,
      "address": address,
      "email": email,
      "mobileNumber": mobileNumber,
      "contactPersonName": contactPersonName,
      "registrationNumber": registrationNumber,
      "yearEstablished": yearEstablished,
      "password": password,
    };
  }
}