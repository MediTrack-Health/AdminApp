import 'dart:io';

import 'package:dio/dio.dart' as form;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meditrack_admin/src/features/records/bloc/record_event.dart';
import 'package:meditrack_admin/src/features/records/bloc/record_state.dart';
import 'package:meditrack_admin/src/features/records/repo/record_repo.dart';
import 'package:mime/mime.dart' as min;
import 'package:http_parser/http_parser.dart' as mediaType;

import '../../../core/utils/logger.dart';
class RecordBloc extends Bloc<RecordEvent, RecordState> {
  final RecordRepo repository;

  RecordBloc(this.repository) : super(ItemInitial()) {
    on<LoadItems>(_onLoadItems);
    on<SubmitItem>(_onSubmitItem);
    on<SelectSubCategory>(_onSelectSubCategory);
  }

  void _onSelectSubCategory(SelectSubCategory event, Emitter<RecordState> emit) {
    if (state is ItemLoaded) {
      final currentState = state as ItemLoaded;
      emit(currentState.copyWith(
        selectedSubItem: event.subCategory,
        selectedReportTypeId: event.parentReportTypeId,
      ));
    }
  }

  void _onLoadItems(LoadItems event, Emitter<RecordState> emit) async {
    emit(ItemLoading());
    try {
      final items = await repository.getReportTypes();
      final reportTypeWithSubCategories = await repository.getCategories();
      logger.d("Naresh reportTypes ${items.reportTypes[0].reportType}");
      emit(ItemLoaded(reportTypes: items.reportTypes, reportTypeWithSubCategories: reportTypeWithSubCategories));
    } catch (e) {
      emit(ItemFailure('Failed to load items.'));
    }
  }

  void _onSubmitItem(SubmitItem event, Emitter<RecordState> emit) async {
      emit(ItemLoading());
      try {
        form.FormData formData = form.FormData.fromMap({
          "profileId": event.profileId ?? "",
          "reportTypeId": event.reportTypeId ?? "",
          "subReportTypeId": event.subReportTypeId ?? "",
          "hospitalName": event.hospitalName ?? "",
          "examinationDate": event.examinationDate ?? "",
          "examinationReport": event.examinationReport ?? "",
          "selfApproved": false,
          "invoiceAmount": event.invoiceAmount ?? "0",
        });

        if (event.invoiceImage != null && event.invoiceImage.isNotEmpty) {
          for (var image in event.invoiceImage) {
            var mimeType = min.lookupMimeType(image!);
            formData.files.add(
              MapEntry(
                "invoiceImage",
                form.MultipartFile.fromBytes(
                  File(image).readAsBytesSync(),
                  filename: image.split('/').last,
                  contentType: mediaType.MediaType.parse(mimeType!),
                ),
              ),
            );
          }
        }
        if (event.reportFiles != null && event.reportFiles.isNotEmpty) {
          for (var file in event.reportFiles) {
            var mimeType = min.lookupMimeType(file!);
            formData.files.add(
              MapEntry(
                "reportFiles",
                form.MultipartFile.fromBytes(
                  File(file).readAsBytesSync(),
                  filename: file.split('/').last,
                  contentType: mediaType.MediaType.parse(mimeType!),
                ),
              ),
            );
          }
        }

        final response = await repository.addRecord(formData);
        logger.d("Naresh response $response");
        if (response != null && response.success) {
          emit(ItemSuccess());
        } else {
          emit(ItemFailure('Invalid response from server.'));
        }
      } catch (e) {
        logger.d("Naresh error $e");
        emit(ItemFailure('Failed to submit. '));
      }
    }
  }
