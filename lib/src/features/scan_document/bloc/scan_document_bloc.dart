import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'scan_document_event.dart';
import 'scan_document_state.dart';

class ScanDocumentBloc extends Bloc<ScanDocumentEvent, ScanDocumentState> {
  final ImagePicker _imagePicker = ImagePicker();

  ScanDocumentBloc() : super(ScanDocumentInitial()) {
    on<StartScanDocument>((event, emit) async {
      try {
        emit(ScanDocumentLoading());
        final XFile? pickedFile = await _imagePicker.pickImage(
          source: ImageSource.camera,
        );
        if (pickedFile != null) {
          final scannedImage = File(pickedFile.path);
          emit(ScanDocumentSuccess(scannedImage));
        } else {
          emit(ScanDocumentError("No document scanned."));
        }
      } catch (e) {
        emit(ScanDocumentError("Failed to scan document: ${e.toString()}"));
      }
    });
  }
}
