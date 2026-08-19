import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meditrack_admin/src/features/scan_document/bloc/scan_document_bloc.dart';
import 'package:meditrack_admin/src/features/scan_document/bloc/scan_document_event.dart';
import 'package:meditrack_admin/src/features/scan_document/bloc/scan_document_state.dart';

class ScanDocumentScreen extends StatefulWidget {
  const ScanDocumentScreen({Key? key}) : super(key: key);

  @override
  State<ScanDocumentScreen> createState() => _ScanDocumentScreenState();
}

class _ScanDocumentScreenState extends State<ScanDocumentScreen> {
  final ScanDocumentBloc _scanDocumentBloc = ScanDocumentBloc();
  File? _scannedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scan Document"),
      ),
      body: BlocProvider(
        create: (_) => _scanDocumentBloc,
        child: BlocListener<ScanDocumentBloc, ScanDocumentState>(
          listener: (context, state) {
            if (state is ScanDocumentSuccess) {
              setState(() {
                _scannedImage = state.scannedImage;
              });
            } else if (state is ScanDocumentError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                if (_scannedImage != null)
                  Image.file(
                    _scannedImage!,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    _scanDocumentBloc.add(StartScanDocument());
                  },
                  child: const Text("Scan Document"),
                ),
                const SizedBox(height: 16),
                if (_scannedImage != null)
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, _scannedImage);
                    },
                    child: const Text("OK"),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
