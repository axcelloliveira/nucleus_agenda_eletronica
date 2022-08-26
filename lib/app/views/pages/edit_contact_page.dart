import 'package:agenda_eletronica/app/models/contact_model.dart';
import 'package:agenda_eletronica/app/views/components/edit_contacts_components/custom_text_field_edit.dart';
import 'package:agenda_eletronica/app/views/components/edit_contacts_components/submit_button_edit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/edit_contact_controller.dart';
import '../../repositories/contact_repository.dart';
import '../components/edit_contacts_components/custom_image_container_edit.dart';

class EditContactPage extends StatefulWidget {
  EditContactPage({Key? key, this.model2}) : super(key: key);
  ContactModel? model2;

  @override
  State<EditContactPage> createState() => _EditContactPageState();
}

class _EditContactPageState extends State<EditContactPage> {
  final EditContactController controller = Get.put(
      EditContactController(ContactRepository(FirebaseFirestore.instance)));

  @override
  initState() {
    super.initState();
    controller.setFields(widget.model2!);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Editar contato'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Agenda'),
                  content: const Text('Confirma a exclusão deste contato?'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancelar'),
                    ),
                    TextButton(
                      onPressed: () => controller.deleteContact(
                          context, widget.model2!.reference),
                      child: const Text('Confirmar'),
                    ),
                  ],
                ),
              ),
              icon: const Icon(Icons.delete),
            ),
          )
        ],
      ),
      body: Form(
        key: controller.key,
        child: ListView(
          children: [
            const SizedBox(height: 15),
            CustomImageContainerEdit(controller),
            const SizedBox(height: 10),
            CustomTextFieldEdit(
              controller,
              hint: 'Insira o nome do contato',
              label: 'Nome',
              validation: true,
              tcontroller: controller.tnome,
            ),
            CustomTextFieldEdit(
              controller,
              hint: 'Insira o E-mail do contato',
              label: 'E-mail',
              validation: true,
              tcontroller: controller.temail,
            ),
            Row(
              children: [
                Expanded(
                  child: CustomTextFieldEdit(
                    controller,
                    hint: 'Primeiro telefone',
                    label: 'Telefone',
                    validation: true,
                    tcontroller: controller.ttelefone1,
                  ),
                ),
                Expanded(
                  child: CustomTextFieldEdit(
                    controller,
                    hint: 'Segundo telefone',
                    label: 'Telefone',
                    validation: true,
                    tcontroller: controller.ttelefone2,
                  ),
                ),
              ],
            ),
            //      CustomButton(controller),
            const SizedBox(height: 10),
            const Divider(thickness: 1),
            const SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: CustomTextFieldEdit(
                    controller,
                    hint: 'Insira o CEP',
                    label: 'CEP',
                    validation: false,
                    tcontroller: controller.tcep,
                  ),
                ),
                Expanded(
                  child: CustomTextFieldEdit(
                    controller,
                    hint: 'Insira a UF',
                    label: 'UF',
                    validation: false,
                    tcontroller: controller.tuf,
                  ),
                ),
              ],
            ),
            CustomTextFieldEdit(
              controller,
              hint: 'Insira a cidade do contato',
              label: 'Cidade',
              validation: false,
              tcontroller: controller.tcidade,
            ),
            CustomTextFieldEdit(
              controller,
              hint: 'Insira o logradouro do contato',
              label: 'Logradouro',
              validation: false,
              tcontroller: controller.tlogradouro,
            ),
            CustomTextFieldEdit(
              controller,
              hint: 'Insira o complemento do contato',
              label: 'Complemento',
              validation: false,
              tcontroller: controller.tcomplemento,
            ),
            const SizedBox(height: 30),
            SubmitButtonEdit(controller, widget.model2!)
          ],
        ),
      ),
    );
  }
}
