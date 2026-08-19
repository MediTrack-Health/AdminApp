class LoginResponseModel {
  LoginResponseModel({
    required this.jwtToken,
    required this.refreshToken,
    required this.hospitalName,
    required this.contactPersonName
  });
  late final String jwtToken;
  late final String refreshToken;
  late final String hospitalName;
  late final String contactPersonName;

  LoginResponseModel.fromJson(Map<String, dynamic> json){
    jwtToken = json['jwtToken'];
    refreshToken = json['refreshToken'];
    hospitalName = json['hospitalName'];
    contactPersonName = json['contactPersonName'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['jwtToken'] = jwtToken;
    _data['refreshToken'] = refreshToken;
    _data['hospitalName'] = hospitalName;
    _data['contactPersonName'] = contactPersonName;
    return _data;
  }
}
