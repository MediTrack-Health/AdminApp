import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meditrack_admin/src/core/utils/logger.dart';
import 'package:meditrack_admin/src/features/records/bloc/record_bloc.dart';
import 'package:meditrack_admin/src/features/records/bloc/record_event.dart';
import 'package:meditrack_admin/src/features/records/bloc/record_state.dart';
import 'package:meditrack_admin/src/features/relations/relation_details_screen.dart';
import 'package:meditrack_admin/src/widgets/button_widget.dart';
import 'package:meditrack_admin/src/widgets/custom_text_field.dart';
import 'package:meditrack_admin/src/widgets/snack_bar.dart';
import 'package:meditrack_admin/src/widgets/static_text.dart';

import '../../core/themes/app_color.dart';
import '../../widgets/images.dart';
import '../../widgets/local_storage.dart';
import '../../widgets/selected_files.dart';

import 'package:google_mlkit_document_scanner/google_mlkit_document_scanner.dart';

import '../relations/relation_details/relation_model.dart';
import 'model/report_type_with_sub_categories.dart';

class AddRecordScreen extends StatefulWidget {
  final RelationDetail relationDetail;

  const AddRecordScreen({super.key, required this.relationDetail});

  @override
  State<AddRecordScreen> createState() => _AddRecordScreenState();
}

class _AddRecordScreenState extends State<AddRecordScreen> {
  final _formKey = GlobalKey<FormState>();

  String? fileName = '';
  String selectRecord = '';
  List<int>? bytes;
  var recordsList = <String>[];
  var invoiceList = <String>[];
  String recordName = '';
  String invoiceName = '';
  TextEditingController hospitalNameController = TextEditingController();
  TextEditingController invoicePriceController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  FilePickerResult? result;

  String selectReport = '';
  int selectedReportId = -1;
  int selectedSubReportId = -1;
  List invoiceAttachmentList = [];

  List recordAttachmentList = [];

  List<SubCategory> selectedSubItems = [];

  Future pickFile(List<String> photoPath, {int? pathListIndex}) async {
    result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc'],
    );
    if (result != null && result?.paths != '') {
      fileName = result?.files[0].name.toString();
      File file = File(result?.files.single.path ?? "");
      bytes = File(file.path).readAsBytesSync();
      for (int i = 0; i < result!.files.length; i++) {
        photoPath.add(result?.files[i].path.toString() ?? '');
      }
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<RecordBloc>().add(LoadItems());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<RecordBloc, RecordState>(
        listener: (context, state) {
          if (state is ItemSuccess) {
            CustomSnackBar.toast(StaticText.recordSavedSuccessfully);
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => RelationDetailsScreen()));

            //context.read<NavigationCubit>().updateIndex(0);
          } else if (state is ItemFailure) {
            // Navigator.pushAndRemoveUntil(
            //   context,
            //   MaterialPageRoute(
            //     builder: (BuildContext context) => CustomBottomNavigationBar(),
            //   ),
            //       (Route<dynamic> route) => false,
            // );
            CustomSnackBar.toast(state.message);
          }
        },
        child: BlocBuilder<RecordBloc, RecordState>(
          builder: (context, state) {
            if (state is ItemLoading || state is ItemInitial) {
              return const Center(
                child: CircularProgressIndicator(color: AppColor.buttonColor),
              );
            }
            if (state is ItemLoaded) {
              return Form(
                key: _formKey,
                child: SafeArea(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        // AppBar section
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                widget.relationDetail.profileImagePath ?? 'https://via.placeholder.com/150',
                              ),
                              radius: 18,
                            ),
                            SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.relationDetail.profileName ?? 'Unknown',
                                  style: GoogleFonts.inter(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  StaticText.addRecord,
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        // Form container
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Color(0xFFE9FBF4),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _labelWithIcon(
                                AssetImages.xRaySvg,
                                StaticText.reportType,
                              ),
                              SizedBox(height: 6),
                              _buildReportTypeSection(
                                state.reportTypeWithSubCategories,
                                state,
                              ),
                              const SizedBox(height: 6),
                              _labelWithIcon(
                                AssetImages.calendarSvg,
                                'Date of Examination',
                              ),
                              const SizedBox(height: 6),
                              CustomTextField(
                                controller: dateController,
                                readOnly: true,
                                isColorChange: true,
                                hintText: StaticText.dateOfExamination1,
                                validator:
                                    (value) =>
                                value == null || value.isEmpty
                                    ? StaticText
                                    .dateOfExaminationRequired
                                    : null,
                                suffixWidget: IconButton(
                                  onPressed: () async {
                                    FocusScope.of(context).unfocus();
                                    final date = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime.now(),
                                    );
                                    if (date != null) {
                                      dateController.text =
                                      date.toLocal().toString().split(
                                        ' ',
                                      )[0];
                                    }
                                  },
                                  icon: Icon(Icons.calendar_month),
                                ),
                              ),
                              SizedBox(height: 6),
                              _labelWithIcon(
                                AssetImages.hospitalSvg,
                                StaticText.hospitalName,
                              ),
                              SizedBox(height: 6),
                              CustomTextField(
                                hintText: StaticText.hospitalName,
                                controller: hospitalNameController,
                                isColorChange: true,
                              ),
                              SizedBox(height: 6),
                              _labelWithIcon(
                                AssetImages.reasonSvg,
                                StaticText.invoiceAmount,
                              ),
                              SizedBox(height: 6),
                              CustomTextField(
                                hintText: StaticText.invoiceAmount,
                                controller: invoicePriceController,
                                isColorChange: true,
                                isNumber: true,
                              ),
                              SizedBox(height: 16),
                              _labelWithIcon(
                                AssetImages.reasonSvg,
                                'Description',
                              ),
                              SizedBox(height: 6),
                              _multiLineInput(''),
                              SizedBox(height: 16),
                              Text(
                                StaticText.addReport,
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 6),
                              _uploadBox('Report'),
                              SizedBox(height: 8),
                              SelectedFiles(
                                pathList: recordsList,
                                iconData: Icons.cancel,
                                fileRemove: recordName,
                              ),
                              Text(
                                'Add Invoice',
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 8),
                              _uploadBox('Invoice'),
                              SizedBox(height: 16),
                              SelectedFiles(
                                pathList: invoiceList,
                                iconData: Icons.cancel,
                                fileRemove: invoiceName,
                              ),
                              SizedBox(height: 16),
                            ],
                          ),
                        ),

                        SizedBox(height: 20),
                        state is ItemSubmitting
                            ? Center(
                          child: CircularProgressIndicator(
                            color: AppColor.buttonColor,
                          ),
                        )
                            : DefaultButton(
                          width: MediaQuery.of(context).size.width * 0.5,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              if(selectedReportId == -1){
                                CustomSnackBar.toast('Please select Report Type');
                              } else {
                                logger.d("Naresh recordsList $recordsList invoiceList $invoiceList");
                                context.read<RecordBloc>().add(
                                  SubmitItem(
                                    profileId: widget.relationDetail.profileId,
                                    reportTypeId: selectedReportId,
                                    subReportTypeId: selectedSubReportId,
                                    hospitalName: hospitalNameController.text,
                                    examinationDate: dateController.text,
                                    examinationReport: reasonController.text,
                                    invoiceImage: invoiceList,
                                    selfApproved: true,
                                    invoiceAmount: invoicePriceController.text,
                                    reportFiles: recordsList,
                                  ),
                                );
                              }
                            }
                          },
                          text: StaticText.saveText,
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              );
            }
            return Container();
          },
        ),
      ),
    ));
  }

  // 1. Add these variables to your _AddRecordScreenState
  final LayerLink _reportTypeLink = LayerLink();
  OverlayEntry? _reportTypeOverlay;
  bool _isReportTypeOpen = false;

  // 2. Add the toggle logic
  void _toggleReportTypeDropdown(
    List<ReportTypeWithSubCategories> types,
    ItemLoaded state,
  ) {
    if (_isReportTypeOpen) {
      _reportTypeOverlay?.remove();
      _reportTypeOverlay = null;
      setState(() => _isReportTypeOpen = false);
    } else {
      _reportTypeOverlay = _createReportTypeOverlay(types, state);
      Overlay.of(context).insert(_reportTypeOverlay!);
      setState(() => _isReportTypeOpen = true);
    }
  }

  // 3. Create the Floating Overlay
  OverlayEntry _createReportTypeOverlay(
    List<ReportTypeWithSubCategories> types,
    ItemLoaded state,
  ) {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;

    return OverlayEntry(
      builder:
          (context) => Stack(
            children: [
              GestureDetector(
                onTap: () => _toggleReportTypeDropdown(types, state),
                behavior: HitTestBehavior.translucent,
                child: Container(color: Colors.transparent),
              ),
              Positioned(
                width: size.width - 52, // Adjusting for container padding
                child: CompositedTransformFollower(
                  link: _reportTypeLink,
                  showWhenUnlinked: false,
                  offset: Offset(0, 50),
                  child: Material(
                    elevation: 8,
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      constraints: const BoxConstraints(maxHeight: 350),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: types.length,
                        itemBuilder: (context, index) {
                          final type = types[index];
                          if (type.subCategories.isEmpty) {
                            return const SizedBox.shrink();
                          }

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.fromLTRB(
                                  16,
                                  12,
                                  16,
                                  4,
                                ),
                                color: Colors.grey.shade50,
                                child: Text(
                                  type.reportType.toUpperCase(),
                                  style: GoogleFonts.inter(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w800,
                                    color: const Color(0xFF27AE60),
                                  ),
                                ),
                              ),
                              ...type.subCategories.map((sub) {
                                final bool isSelected =
                                    state.selectedSubItem?.subReportTypeId ==
                                    sub.subReportTypeId;
                                return ListTile(
                                  dense: true,
                                  title: Text(
                                    sub.subReportType ?? '',
                                    style: GoogleFonts.inter(
                                      fontSize: 13,
                                      color:
                                          isSelected
                                              ? const Color(0xFF27AE60)
                                              : Colors.black87,
                                      fontWeight:
                                          isSelected
                                              ? FontWeight.w600
                                              : FontWeight.normal,
                                    ),
                                  ),
                                  trailing:
                                      isSelected
                                          ? const Icon(
                                            Icons.check,
                                            size: 16,
                                            color: Color(0xFF27AE60),
                                          )
                                          : null,
                                  onTap: () {
                                    logger.d("Naresh selected subcategory: ${sub.subReportType} with ID: ${sub.subReportTypeId} under report type: ${type.reportType} with ID: ${type.reportTypeId}");
                                    // Update IDs for form submission
                                    selectedReportId = type.reportTypeId;
                                    selectedSubReportId = sub.subReportTypeId;

                                    // Dispatch to Bloc
                                    context.read<RecordBloc>().add(
                                      SelectSubCategory(sub, type.reportTypeId),
                                    );
                                    _toggleReportTypeDropdown(types, state);
                                  },
                                );
                              }).toList(),
                              const Divider(height: 1),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
    );
  }

  // 4. The actual Widget that goes in your Column
  Widget _buildReportTypeSection(
    List<ReportTypeWithSubCategories> reportTypes,
    ItemLoaded state,
  ) {
    return CompositedTransformTarget(
      link: _reportTypeLink,
      child: InkWell(
        onTap: () => _toggleReportTypeDropdown(reportTypes, state),

        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: const Color(0xFF27AE60),
              width: 1.0,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  state.selectedSubItem?.subReportType ??
                      "Select Report Category",
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color:
                        state.selectedSubItem != null
                            ? Colors.black
                            : Colors.grey,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(
                _isReportTypeOpen
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _labelWithIcon(String iconPath, String label) {
    return Row(
      children: [
        SvgPicture.asset(iconPath, height: 20, width: 20, fit: BoxFit.fitWidth),
        SizedBox(width: 6),
        Text(
          label,
          style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _multiLineInput(String value) {
    return SizedBox(
      height: 100,
      child: CustomTextField(
        hintText: 'Enter Description Here',
        controller: reasonController,
        isColorChange: true,
        maxLines: 5,
      ),
    );
  }

  showPhotoBottomSheet(title) {
    return showModalBottomSheet(
      useRootNavigator: true,
      context: context,
      builder: (BuildContext context) {
        return SafeArea(child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.photo),
              title: Text(StaticText.gallery),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
              onTap:
                  () => {
                Navigator.pop(context),
                if (title == 'Report')
                  {pickFile(recordsList)}
                else if (title == 'Invoice')
                  {pickFile(invoiceList)},
              },
            ),
            ListTile(
              leading: Icon(Icons.document_scanner),
              title: Text(StaticText.scanDocument),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () async {
                // Navigator.pop(context);
                // final scannedImage = await Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const ScanDocumentScreen(),
                //   ),
                // );
                // if (scannedImage != null) {
                //   setState(() {
                //     if (title == 'Report') {
                //       recordsList.add(scannedImage.path);
                //     } else if (title == 'Invoice') {
                //       invoiceList.add(scannedImage.path);
                //     }
                //   });
                // }

                Navigator.pop(context);
                final scannedImage = await _scanDocument();
                if (scannedImage != null) {
                  setState(() {
                    if (title == 'Report') {
                      recordsList.add(scannedImage.path);
                    } else if (title == 'Invoice') {
                      invoiceList.add(scannedImage.path);
                    }
                  });
                }
              },
            ),
          ],
        ));
      },
    );
  }

  Future<File?> _scanDocument() async {
    try {
      // 1. Configure the options
      final options = DocumentScannerOptions(
        mode: ScannerMode.full, // Full UI with corner adjustments
        isGalleryImport: true,  // Gallery import allowed
        pageLimit: 1,           // Single page for the report
      );

      // 2. Initialize the scanner instance
      final documentScanner = DocumentScanner(options: options);

      // 3. Launch the native scanner activity
      // result is of type DocumentScanningResult
      final result = await documentScanner.scanDocument();

      // 4. Handle the result using result.images
      if (result.images != null && result.images!.isNotEmpty) {
        // The images list contains paths (Strings) to the processed files
        String scannedPath = result.images!.first;

        // Close the scanner instance to release native resources
        await documentScanner.close();

        return File(scannedPath);
      }
    } catch (e) {
      logger.e("Scanning failed: $e");
      // Show a user-friendly error
      CustomSnackBar.toast("Scanner encountered an error: ${e.toString()}");
    }
    return null;
  }

  Widget _uploadBox(title) {
    return InkWell(
      onTap: () {
        showPhotoBottomSheet(title);
        // if (title == 'Report') {
        //   pickFile(recordsList);
        // } else if (title == 'Invoice') {
        //   pickFile(invoiceList);
        // }
      },
      child: DottedBorder(
        dashPattern: [6, 3],
        borderType: BorderType.RRect,
        radius: Radius.circular(12),
        color: Color(0xFF2ECC8B),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          width: double.infinity,
          height: 140,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.cloud_upload_outlined,
                size: 32,
                color: Color(0xFF2ECC8B),
              ),
              SizedBox(height: 8),
              Text(
                "Upload",
                style: GoogleFonts.inter(color: Color(0xFF2ECC8B)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
