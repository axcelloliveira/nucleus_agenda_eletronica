import 'package:agenda_eletronica/app/controllers/edit_contact_controller.dart';
import 'package:agenda_eletronica/app/models/contact_model.dart';
import 'package:flutter/material.dart';

class SubmitButtonEdit extends StatelessWidget {
  const SubmitButtonEdit(this.controller, this.model, {Key? key})
      : super(key: key);
  final EditContactController controller;
  final ContactModel model;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 58,
      minWidth: 340,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      onPressed: () => controller.editContact(context, model.reference),
      color: Colors.white,
      child: const Text(
        "CADASTRAR",
        style: TextStyle(
          fontSize: 24,
          color: Colors.black,
        ),
      ),
    );
  }
}
