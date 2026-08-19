class ReportTypeModel {
  ReportTypeModel({
    required this.reportTypes,
  });
  late final List<ReportTypes> reportTypes;

  ReportTypeModel.fromJson(Map<String, dynamic> json){
    reportTypes = List.from(json['reportTypes']).map((e)=>ReportTypes.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['reportTypes'] = reportTypes.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class ReportTypes {
  ReportTypes({
    required this.reportTypeId,
    required this.reportType,
    required this.active,
  });
  late final int? reportTypeId;
  late final String? reportType;
  late final bool? active;

  ReportTypes.fromJson(Map<String, dynamic> json){
    reportTypeId = json['reportTypeId'];
    reportType = json['reportType'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['reportTypeId'] = reportTypeId;
    _data['reportType'] = reportType;
    _data['active'] = active;
    return _data;
  }
}
