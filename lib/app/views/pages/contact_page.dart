import 'dart:convert';
import 'dart:typed_data';

import 'package:agenda_eletronica/app/controllers/contact_controller.dart';
import 'package:agenda_eletronica/app/models/contact_model.dart';
import 'package:agenda_eletronica/app/repositories/contact_repository.dart';
import 'package:agenda_eletronica/app/views/pages/add_contact_page.dart';
import 'package:agenda_eletronica/app/views/pages/edit_contact_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/list_contacts_components/custom_app_bar.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  ContactController controller =
      Get.put(ContactController(ContactRepository(FirebaseFirestore.instance)));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height / 14),
            child: CustomAppBar(controller)),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Get.to(() => const AddContactPage());
          },
        ),
        body: GetBuilder<ContactController>(
          builder: (_) => StreamBuilder<List<ContactModel>>(
            stream: controller.contactStream,
            builder: (BuildContext context, snapshot) {
              controller.list = snapshot.data;

              if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                itemCount: controller.isSearching.value == true
                    ? controller.contactsFiltered.length
                    : controller.list!.length,
                itemBuilder: (_, index) {
                  ContactModel model = controller.isSearching.value == true
                      ? controller.contactsFiltered[index]
                      : controller.list![index];
                  Uint8List uintList =
                      const Base64Decoder().convert(model.imagem.toString());
                  return Center(
                    child: ListTile(
                      leading:
                          (model.imagem != null && model.imagem!.isNotEmpty)
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.memory(
                                    uintList,
                                    fit: BoxFit.cover,
                                    height: 40,
                                    width: 40,
                                  ),
                                )
                              : CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Text(controller
                                      .getInitials(model.nome.toString())),
                                ),
                      title: Text(model.nome.toString()),
                      subtitle: Text(model.telefone1.toString()),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Get.to(() => EditContactPage(model2: model));
                      },
                    ),
                  );
                },
              );
            },
          ),
        ));
  }
}
