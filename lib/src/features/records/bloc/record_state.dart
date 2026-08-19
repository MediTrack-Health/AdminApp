
import '../model/report_type_model.dart';
import '../model/report_type_with_sub_categories.dart';

abstract class RecordState {}
class ItemInitial extends RecordState {}
class ItemLoading extends RecordState {}
// class ItemLoaded extends RecordState {
//   final List<ReportTypes> reportTypes;
//   final List<ReportTypeWithSubCategories> reportTypeWithSubCategories;
//
//   ItemLoaded({required this.reportTypes,required this.reportTypeWithSubCategories});
// }

class ItemLoaded extends RecordState {
  final List<ReportTypes> reportTypes;
  final List<ReportTypeWithSubCategories> reportTypeWithSubCategories;
  final SubCategory? selectedSubItem; // New field
  final int? selectedReportTypeId;    // New field

  ItemLoaded({
    required this.reportTypes,
    required this.reportTypeWithSubCategories,
    this.selectedSubItem,
    this.selectedReportTypeId,
  });

  // Add a copyWith to handle selection updates
  ItemLoaded copyWith({
    SubCategory? selectedSubItem,
    int? selectedReportTypeId,
  }) {
    return ItemLoaded(
      reportTypes: reportTypes,
      reportTypeWithSubCategories: reportTypeWithSubCategories,
      selectedSubItem: selectedSubItem ?? this.selectedSubItem,
      selectedReportTypeId: selectedReportTypeId ?? this.selectedReportTypeId,
    );
  }
}

class ItemSubmitting extends RecordState {}
class ItemSuccess extends RecordState {}
class ItemFailure extends RecordState {
  final String message;
  ItemFailure(this.message);
}
