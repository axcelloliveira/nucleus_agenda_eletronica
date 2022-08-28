import 'package:agenda_eletronica/app/controllers/edit_contact_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFieldNumberEdit extends StatelessWidget {
  CustomTextFieldNumberEdit(this.controller,
      {Key? key,
      required this.hint,
      required this.label,
      required this.tcontroller,
      required this.validation})
      : super(key: key);
  final String hint;
  final String label;
  final bool validation;
  final EditContactController controller;
  TextEditingController tcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextFormField(
        controller: tcontroller,
        inputFormatters: [
          FilteringTextInputFormatter(RegExp(r'[0-9]'), allow: true)
        ],
        keyboardType: TextInputType.number,
        validator: (String? value) =>
            controller.validateField(value!, validation),
        decoration: InputDecoration(
          hintText: hint,
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}
