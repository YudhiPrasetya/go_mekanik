import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_mekanik/screen/widget/bottom_sheet.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  Future<PickedFile> pickImage({required ImageSource source}) async {
    final xFileSource = await ImagePicker().pickImage(source: source);

    return PickedFile(xFileSource!.path);
  }

  Future<File?> chooseImageFile(BuildContext context) async {
    try {
      return await showModalBottomSheet(
          context: context, builder: (builder) => bottomSheet(context));
    } catch (e) {
      debugPrint("The error is in image picker service...$e");
    }
    return null;
  }
}
