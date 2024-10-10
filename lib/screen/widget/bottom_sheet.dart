import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_mekanik/classes/GetPermissions.dart';
import 'package:go_mekanik/classes/ImagePickerService.dart';
import 'package:image_picker/image_picker.dart';

Widget bottomSheet(BuildContext context) {
  ImagePickerService imagePickerService = ImagePickerService();
  GetPermissions getPermissions = GetPermissions();

  Future<void> openSource(ImageSource source) async {
    final file = await imagePickerService.pickImage(source: source);
    File selected = File(file.path);
    if (kDebugMode) {
      print('selected: $selected');
    }
    if (await selected.exists()) {
      Navigator.pop(context, selected);
    } else {
      Navigator.pop(context, File(''));
    }
  }

  var styleFs12Fw600 = const TextStyle(
      fontSize: 14, letterSpacing: 0.02, fontWeight: FontWeight.w600);

  return Container(
    height: 100,
    width: MediaQuery.of(context).size.width,
    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: Column(
      children: [
        Text(
          'Pilih File Image',
          style: styleFs12Fw600,
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () async {
                final bool cameraStatus =
                    await getPermissions.getCameraPermission();
                if (cameraStatus) {
                  openSource(ImageSource.camera);
                }
              },
              child: Column(
                children: [
                  const Icon(
                    Icons.camera_alt,
                    size: 22,
                  ),
                  Text(
                    'Camera',
                    style: styleFs12Fw600,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 1,
            ),
            InkWell(
              onTap: () async {
                final bool galeryStatus =
                    await getPermissions.getStoragePermission();
                if (galeryStatus) {
                  openSource(ImageSource.gallery);
                }
              },
              child: Column(
                children: [
                  const Icon(
                    Icons.image,
                    size: 22,
                  ),
                  Text(
                    'Gallery',
                    style: styleFs12Fw600,
                  )
                ],
              ),
            )
          ],
        )
      ],
    ),
  );
}
