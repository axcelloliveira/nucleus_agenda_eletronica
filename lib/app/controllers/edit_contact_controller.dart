import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:agenda_eletronica/app/models/contact_model.dart';
import 'package:agenda_eletronica/app/repositories/contact_repository_imp.dart';
import 'package:agenda_eletronica/app/views/pages/contact_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../views/components/new_contact_components/custom_snackbar.dart';

class EditContactController extends GetxController {
  final IContactRepository _contactRepository;

  EditContactController(this._contactRepository);

  var selectedImagePath = ''.obs;
  var imageFromFirebase = ''.obs;
  var imageString = ''.obs;
  var imageFirebase = false.obs;

  Rx<Uint8List> uintList = Uint8List.fromList([10, 1]).obs;

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

  setFields(ContactModel model) {
    tnome.text = model.nome.toString();
    temail.text = model.email.toString();
    ttelefone1.text = model.telefone1.toString();
    ttelefone2.text = model.telefone2.toString();
    tcep.text = model.cep.toString();
    tuf.text = model.uf.toString();
    tcidade.text = model.cidade.toString();
    tlogradouro.text = model.logradouro.toString();
    tcomplemento.text = model.complemento.toString();
    imageString.value = model.imagem!;
    if (imageString.value == '') {
      imageFirebase.value = false;
    } else {
      uintList.value = const Base64Decoder().convert(imageString.value);
      imageFirebase.value = true;
    }

    update();
  }

  void getImageFromDevice(ImageSource image) async {
    final pickedFile = await ImagePicker().pickImage(source: image);
    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
      imageFirebase.value = true;
      update();
    } else {}
  }

  validateField(String value, bool validation) {
    if (validation == false) {
    } else if (value.isEmpty) {
      return "Campo obrigatório";
    }
    return null;
  }

  editContact([BuildContext? context, DocumentReference? reference]) {
    bool formValidate = key.currentState!.validate();
    String base64Image;
    if (selectedImagePath.value.isEmpty) {
      base64Image = imageString.value;
    } else {
      List<int> imageBytes = File(selectedImagePath.value).readAsBytesSync();
      base64Image = base64Encode(imageBytes);
    }

    if (formValidate == true) {
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
          reference: reference,
          complemento: tcomplemento.text);
      try {
        ScaffoldMessenger.of(context!).showSnackBar(successSnackBar);

        _contactRepository.editContact(model);
      } catch (error) {
        ScaffoldMessenger.of(context!).showSnackBar(errorrSnackBar);
      }
      Get.offAll(const ContactPage());
    }
  }
}
