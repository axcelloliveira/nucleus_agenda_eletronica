import 'dart:io';

import 'package:agenda_eletronica/app/controllers/edit_contact_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CustomImageContainerEdit extends StatelessWidget {
  const CustomImageContainerEdit(this.controller, {Key? key}) : super(key: key);
  final EditContactController controller;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditContactController>(
      builder: (_) => Padding(
        padding: const EdgeInsets.only(left: 100.0, right: 90),
        child: controller.imageFirebase.value == false
            ? GestureDetector(
                onTap: () {
                  controller.getImageFromDevice(ImageSource.camera);
                },
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  height: 100,
                  width: 35,
                  child: const Icon(
                    Icons.camera_alt_outlined,
                    size: 35,
                    color: Colors.black,
                  ),
                ),
              )
            : Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent,
                ),
                width: 50,
                height: 150,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100.0),
                  child: controller.imageString.value != ''
                      ? Image.memory(
                          (controller.uintList.value),
                          fit: BoxFit.cover,
                        )
                      : Image.file(
                          File(controller.selectedImagePath.value),
                          fit: BoxFit.cover,
                        ),
                ),
              ),
      ),
    );
  }
}
