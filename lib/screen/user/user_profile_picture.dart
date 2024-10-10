import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_mekanik/classes/ImagePickerService.dart';
import 'package:go_mekanik/service/baseUrl.dart';
import 'package:go_mekanik/util/ShowToast.dart';

class UserProfilePicture extends StatefulWidget {
  final String? userImageUrl;
  const UserProfilePicture({super.key, this.userImageUrl});

  @override
  State<UserProfilePicture> createState() => _UserProfilePictureState();
}

class _UserProfilePictureState extends State<UserProfilePicture> {
  @override
  Widget build(BuildContext context) {
    String urlNoImage = BaseUrl.baseUrlMekanikImages + "/noimage.jpg";
    ImagePickerService imagePickerService = ImagePickerService();
    ShowToast showToast = ShowToast();
    File? image;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Pilih gambar profile Anda'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(14),
          child: Stack(
            children: [
              CircleAvatar(
                radius: 64,
                // backgroundImage: widget.userImageUrl != null
                //     ? NetworkImage(
                //         BaseUrl.baseUrlMekanikImages + widget.userImageUrl!)
                //     : NetworkImage(urlNoImage),
                backgroundImage: image != null
                    ? Image.file(image).image
                    : NetworkImage(urlNoImage),
                backgroundColor: Colors.grey,
              ),
              Positioned(
                bottom: -10,
                left: 80,
                child: IconButton(
                  icon: const Icon(Icons.add_a_photo),
                  onPressed: () async {
                    image = await imagePickerService.chooseImageFile(context);
                    if (kDebugMode) {
                      print('image: $image');
                    }
                    image == null
                        ? showToast.showToastWarning('Image not picked')
                        : setState(() {});
                  },
                ),
              )
            ],
          ),
        ));
  }
}
