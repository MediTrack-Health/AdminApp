class ReportTypeWithSubCategories {
  ReportTypeWithSubCategories({
    required this.reportType,
    required this.reportTypeId,
    required this.subCategories,
  });

  final String reportType;
  final int reportTypeId;
  final List<SubCategory> subCategories;

  factory ReportTypeWithSubCategories.fromJson(Map<String, dynamic> json) {
    return ReportTypeWithSubCategories(
      reportType: json['reportType'],
      reportTypeId: json['reportTypeId'],
      subCategories: List<SubCategory>.from(
        json['subCategories'].map((x) => SubCategory.fromJson(x)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reportType': reportType,
      'reportTypeId': reportTypeId,
      'subCategories': subCategories.map((x) => x.toJson()).toList(),
    };
  }
}

class SubCategory {
  SubCategory({
    required this.subReportTypeId,
    required this.reportTypeId,
    required this.subReportType,
  });

  final int subReportTypeId;
  final int reportTypeId;
  final String subReportType;

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      subReportTypeId: json['subReportTypeId'],
      reportTypeId: json['reportTypeId'],
      subReportType: json['subReportType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subReportTypeId': subReportTypeId,
      'reportTypeId': reportTypeId,
      'subReportType': subReportType,
    };
  }
}
