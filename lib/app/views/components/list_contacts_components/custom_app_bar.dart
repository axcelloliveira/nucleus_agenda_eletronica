import 'package:agenda_eletronica/app/controllers/contact_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar(this.controller, {Key? key}) : super(key: key);
  final ContactController controller;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContactController>(
      builder: (_) => AppBar(
        title: controller.stateAppBar.value == false
            ? const Text('Agenda Eletronica')
            : TextField(
                autofocus: true,
                controller: controller.search,
                decoration: const InputDecoration(
                    hintText: 'Contato', labelText: 'Pesquise o contato aqui!'),
              ),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                controller.setStateAppBar();
              },
              icon: controller.stateAppBar.value == false
                  ? const Icon(Icons.search)
                  : const Icon(Icons.list),
            ),
          )
        ],
      ),
    );
  }
}
