import 'package:agenda_eletronica/app/controllers/add_contact_controller.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(this.controller,
      {Key? key,
      required this.hint,
      required this.label,
      required this.tcontroller,
      required this.validation})
      : super(key: key);
  final String hint;
  final String label;
  final bool validation;
  final AddContactController controller;
  TextEditingController tcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextFormField(
        controller: tcontroller,
        validator: (String? value) =>
            controller.valideField(value!, validation),
        decoration: InputDecoration(
          hintText: hint,
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}
