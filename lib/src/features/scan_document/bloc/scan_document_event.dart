import 'package:equatable/equatable.dart';

abstract class ScanDocumentEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class StartScanDocument extends ScanDocumentEvent {}
