class ErrorModel {
  ErrorModel({
    required this.timestamp,
    required this.message,
  });
  late final String timestamp;
  late final String message;

  ErrorModel.fromJson(Map<String, dynamic> json){
    timestamp = json['timestamp'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['timestamp'] = timestamp;
    _data['message'] = message;
    return _data;
  }
}
