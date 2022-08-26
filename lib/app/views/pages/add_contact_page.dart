import 'package:agenda_eletronica/app/views/components/new_contact_components/custom_text_field_phone.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/add_contact_controller.dart';
import '../../repositories/contact_repository.dart';
import '../components/new_contact_components/custom_image_container.dart';
import '../components/new_contact_components/custom_text_field.dart';
import '../components/new_contact_components/submit_button.dart';

class AddContactPage extends StatefulWidget {
  const AddContactPage({Key? key}) : super(key: key);

  @override
  State<AddContactPage> createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  final AddContactController controller = Get.put(
      AddContactController(ContactRepository(FirebaseFirestore.instance)));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: controller.key,
        child: ListView(
          children: [
            CustomImageContainer(controller),
            const SizedBox(height: 10),
            CustomTextField(
              controller,
              hint: 'Insira o nome do contato',
              label: 'Nome',
              validation: true,
              tcontroller: controller.tnome,
            ),
            CustomTextField(
              controller,
              hint: 'Insira o E-mail do contato',
              label: 'E-mail',
              validation: true,
              tcontroller: controller.temail,
            ),
            Row(
              children: [
                Expanded(
                  child: CustomTextFieldNumber(
                    controller,
                    hint: 'Primeiro telefone',
                    label: 'Telefone',
                    validation: true,
                    tcontroller: controller.ttelefone1,
                  ),
                ),
                Expanded(
                  child: CustomTextFieldNumber(
                    controller,
                    hint: 'Segundo telefone',
                    label: 'Telefone',
                    validation: true,
                    tcontroller: controller.ttelefone2,
                  ),
                ),
              ],
            ),
            //   CustomButton(controller),
            const SizedBox(height: 10),
            const Divider(thickness: 1),
            const SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: CustomTextFieldNumber(
                    controller,
                    hint: 'Insira o CEP',
                    label: 'CEP',
                    validation: false,
                    tcontroller: controller.tcep,
                  ),
                ),
                Expanded(
                  child: CustomTextField(
                    controller,
                    hint: 'Insira a UF',
                    label: 'UF',
                    validation: false,
                    tcontroller: controller.tuf,
                  ),
                ),
              ],
            ),
            CustomTextField(
              controller,
              hint: 'Insira a cidade do contato',
              label: 'Cidade',
              validation: false,
              tcontroller: controller.tcidade,
            ),
            CustomTextField(
              controller,
              hint: 'Insira o logradouro do contato',
              label: 'Logradouro',
              validation: false,
              tcontroller: controller.tlogradouro,
            ),
            CustomTextField(
              controller,
              hint: 'Insira o complemento do contato',
              label: 'Complemento',
              validation: false,
              tcontroller: controller.tcomplemento,
            ),
            const SizedBox(height: 30),
            SubmitButton(controller)
          ],
        ),
      ),
    );
  }
}
