import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:image_picker/image_picker.dart';

import '../core/errors/failures.dart';


class Pickers {
  Pickers._();

  static Future<XFile?> getVideo(ImageSource source) async {
    final XFile? videoPicker = await ImagePicker().pickVideo(source: source);
    if (videoPicker != null) {
      return videoPicker;
    } else {
      return null;
    }
  }

  static Future<Either<Failure, File>> pickImage(
      {required BuildContext buildContext, required ImageSource source}) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source,imageQuality: 25);
    if (pickedFile != null) {
      return right(File(pickedFile.path));
    } else {
      return left( CacheFailure());
    }
  }

  static Future<Either<Failure, File>> pickVideo(
      {required BuildContext buildContext, required ImageSource source}) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickVideo(
        source: source, maxDuration: const Duration(seconds: 30));
    if (pickedFile != null) {
      return right(File(pickedFile.path));
    } else {
      return left( CacheFailure());
    }
  }

  static Future<Either<Failure, DateTime>> selectDate(
      {required BuildContext context, DateTime? initialDate}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: DateTime(1920, 1),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      return right(picked);
    } else {
      return left( CacheFailure());
    }
  }

// static Future<File?> compressImage(File imageFile) async {
//   try {
//     final Directory directory = await getTemporaryDirectory();
//     final String targetPath =
//         '${directory.path}_${DateTime.now().millisecondsSinceEpoch}.jpg';

//     final XFile? compressedFile =
//         await FlutterImageCompress.compressAndGetFile(
//       imageFile.path,
//       targetPath,
//       quality: 50,
//     );

//     return compressedFile != null ? File(compressedFile.path) : null;
//   } catch (e, stackTrace) {
//     print('Error compressing image: $e');
//     print('Stack trace: $stackTrace');
//     return null;
//   }
// }
}
