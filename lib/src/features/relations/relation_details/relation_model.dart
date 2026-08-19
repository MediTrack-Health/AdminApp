class RelationModel {
  RelationModel({
    required this.relations,
  });

  late final List<RelationDetail> relations;

  RelationModel.fromJson(Map<String, dynamic> json) {
    relations = List.from(json['data']).map((e) => RelationDetail.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = relations.map((e) => e.toJson()).toList();
    return _data;
  }
}

class RelationDetail {
  RelationDetail({
    required this.profileName,
    required this.profileId,
    required this.profileImagePath,
    required this.relation,
  });

  late final String profileName;
  late final int profileId;
  late final String profileImagePath;
  late final String relation;

  RelationDetail.fromJson(Map<String, dynamic> json) {
    profileName = json['profileName'];
    profileId = json['profileId'];
    profileImagePath = json['profileImagePath'];
    relation = json['relation'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['profileName'] = profileName;
    data['profileId'] = profileId;
    data['profileImagePath'] = profileImagePath;
    data['relation'] = relation;
    return data;
  }
}
