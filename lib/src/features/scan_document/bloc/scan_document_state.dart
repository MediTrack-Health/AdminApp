import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class ScanDocumentState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ScanDocumentInitial extends ScanDocumentState {}

class ScanDocumentLoading extends ScanDocumentState {}

class ScanDocumentSuccess extends ScanDocumentState {
  final File scannedImage;

  ScanDocumentSuccess(this.scannedImage);

  @override
  List<Object?> get props => [scannedImage];
}

class ScanDocumentError extends ScanDocumentState {
  final String message;

  ScanDocumentError(this.message);

  @override
  List<Object?> get props => [message];
}
