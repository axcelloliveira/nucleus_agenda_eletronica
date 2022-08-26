import 'package:flutter/material.dart';

import '../../../controllers/add_contact_controller.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton(this.controller, {Key? key}) : super(key: key);
  final AddContactController controller;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 58,
      minWidth: 340,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1)),
      onPressed: () => controller.saveContact(context),
      color: Colors.white,
      child: const Text(
        "Cadastrar",
        style: TextStyle(
          fontSize: 24,
          color: Colors.black,
        ),
      ),
    );
  }
}
