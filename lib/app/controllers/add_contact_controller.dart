import 'dart:convert';
import 'dart:io';

import 'package:agenda_eletronica/app/models/contact_model.dart';
import 'package:agenda_eletronica/app/repositories/contact_repository_imp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../views/components/new_contact_components/custom_snackbar.dart';
import '../views/pages/contact_page.dart';

class AddContactController extends GetxController {
  final IContactRepository _contactRepository;

  AddContactController(this._contactRepository);

  DateTime dateTime = DateTime.now();
  var selectedImagePath = ''.obs;

  final GlobalKey<FormState> key = GlobalKey();
  TextEditingController tnome = TextEditingController();
  TextEditingController temail = TextEditingController();
  TextEditingController ttelefone1 = TextEditingController();
  TextEditingController ttelefone2 = TextEditingController();
  TextEditingController tcep = TextEditingController();
  TextEditingController tuf = TextEditingController();
  TextEditingController tcidade = TextEditingController();
  TextEditingController tlogradouro = TextEditingController();
  TextEditingController tcomplemento = TextEditingController();

  void getImageFromDevice(ImageSource image) async {
    final pickedFile = await ImagePicker().pickImage(source: image);
    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;

      update();
    } else {}
  }

  valideField(String value, bool validation) {
    if (validation == false) {
    } else if (value.isEmpty) {
      return "Campo obrigatório";
    }
    return null;
  }

  saveContact([BuildContext? context]) {
    bool validateForm = key.currentState!.validate();
    String base64Image;
    if (selectedImagePath.value.isEmpty) {
      base64Image = '';
    } else {
      List<int> imageBytes = File(selectedImagePath.value).readAsBytesSync();
      base64Image = base64Encode(imageBytes);
    }

    if (validateForm == true) {
      final model = ContactModel(
          nome: tnome.text,
          email: temail.text,
          telefone1: ttelefone1.text,
          telefone2: ttelefone2.text,
          logradouro: tlogradouro.text,
          cep: tcep.text,
          cidade: tcidade.text,
          uf: tuf.text,
          imagem: base64Image,
          complemento: tcomplemento.text);
      ScaffoldMessenger.of(context!).showSnackBar(successSnackBar);
      _contactRepository.saveContact(model);
      Get.offAll(const ContactPage());
    }
  }

// Future<void> selectDate(BuildContext context) async {
//   date.value = (await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       initialDatePickerMode: DatePickerMode.day,
//       firstDate: DateTime(2015),
//       lastDate: DateTime(2101)))!;
//
//   selectTime(context);
// }
//
// Future<void> selectTime(BuildContext context) async {
//   time.value = (await showTimePicker(
//     context: context,
//     initialTime: TimeOfDay.now(),
//   ))!;
//
//   selectDateTime(context);
// }
//
// Future<void> selectDateTime(BuildContext context) async {
//   dateTime = DateTime(
//     date.value.year,
//     date.value.month,
//     date.value.day,
//     time.value.hour,
//     time.value.minute,
//   );
//   print(dateTime.toString());
// }
}
