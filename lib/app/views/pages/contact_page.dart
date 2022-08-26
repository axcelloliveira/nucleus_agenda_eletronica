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

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  ContactController controller =
      ContactController(ContactRepository(FirebaseFirestore.instance));

  @override
  initState() {
    super.initState();
    controller.getContact();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agenda Eletronica'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Get.to(() => const AddContactPage());
        },
      ),
      body: StreamBuilder<List<ContactModel>>(
        stream: controller.contactStream,
        builder: (BuildContext context, snapshot) {
          List<ContactModel>? list = snapshot.data;

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: list!.length,
            itemBuilder: (_, index) {
              ContactModel model = list[index];
              Uint8List uintList =
                  Base64Decoder().convert(model.imagem.toString());
              return Center(
                child: ListTile(
                  leading: (model.imagem != null && model.imagem!.isNotEmpty)
                      ? Container(
                          child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.memory(
                            uintList,
                            fit: BoxFit.cover,
                            height: 40,
                            width: 40,
                          ),
                        ))
                      : CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Text(
                              controller.getInitials(model.nome.toString())),
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
    );
  }
}
