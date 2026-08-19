class SuccessModel {
  SuccessModel({
    required this.message,
    required this.success,
    required this.userId,
    required this.otpTimestamp,
  });
  late final String message;
  late final bool success;
  late final int userId;
  late final String otpTimestamp;

  SuccessModel.fromJson(Map<String, dynamic> json){
    message = json['message'];
    success = json['success'];
    userId = json['userId'];
    otpTimestamp = json['otpTimestamp'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['success'] = success;
    _data['userId'] = userId;
    _data['otpTimestamp'] = otpTimestamp;
    return _data;
  }
}
