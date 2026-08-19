class DeleteModel {
  DeleteModel({
    required this.message,
    required this.success,
  });
  late final String message;
  late final bool success;

  DeleteModel.fromJson(Map<String, dynamic> json){
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['success'] = success;
    return _data;
  }
}
