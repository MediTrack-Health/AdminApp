// Events
import 'dart:io';

import '../model/report_type_with_sub_categories.dart';

abstract class RecordEvent {}
class LoadItems extends RecordEvent {}

class SubmitItem extends RecordEvent {
  final int profileId;
  final int reportTypeId;
  final int subReportTypeId;
  final String? hospitalName;
  final String examinationDate;
  final String? examinationReport;
  final List<String> invoiceImage;
  final bool selfApproved;
  final String? invoiceAmount;
  final List<String> reportFiles;

  SubmitItem({
    required this.profileId,
    required this.reportTypeId,
    required this.subReportTypeId,
    required this.hospitalName,
    required this.examinationDate,
    required this.examinationReport,
    required this.invoiceImage,
    required this.selfApproved,
    required this.invoiceAmount,
    required this.reportFiles,
  });
}

class SelectSubCategory extends RecordEvent {
  final SubCategory subCategory;
  final int parentReportTypeId;
  SelectSubCategory(this.subCategory, this.parentReportTypeId);
}
