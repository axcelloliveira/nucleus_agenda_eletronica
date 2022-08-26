import 'dart:io';

import 'package:agenda_eletronica/app/controllers/add_contact_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:image_picker/image_picker.dart';

class CustomImageContainer extends StatelessWidget {
  const CustomImageContainer(this.controller, {Key? key}) : super(key: key);
  final AddContactController controller;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddContactController>(
      builder: (_) => Padding(
          padding: const EdgeInsets.only(left: 100.0, right: 90),
          child: GestureDetector(
            onTap: () => controller.getImageFromDevice(ImageSource.camera),
            child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                width: 30,
                height: 150,
                child: controller.selectedImagePath.value.isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(100.0),
                        child: Image.file(
                          File(controller.selectedImagePath.value),
                          fit: BoxFit.cover,
                        ),
                      )
                    : const Icon(
                        Icons.camera_alt_outlined,
                        size: 50,
                        color: Colors.black,
                      )),
          )),
    );
  }
}
