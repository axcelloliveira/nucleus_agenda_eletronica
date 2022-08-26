import 'dart:developer' as developer;

import 'package:agenda_eletronica/app/models/contact_model.dart';
import 'package:agenda_eletronica/app/repositories/contact_repository_imp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ContactRepository implements IContactRepository {
  final FirebaseFirestore firestore;

  ContactRepository(this.firestore);

  @override
  Stream<List<ContactModel>> getContacts() {
    return firestore
        .collection('contato')
        .orderBy('nome')
        .snapshots()
        .map((query) {
      return query.docs.map((doc) {
        return ContactModel.fromDocument(doc);
      }).toList();
    });
  }

  @override
  Future deleteContact(ContactModel model) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future saveContact(ContactModel model) async {
    model.reference = await firestore.collection('contato').add({
      'nome': model.nome,
      'telefone_1': model.telefone1,
      'telefone_2': model.telefone2,
      'email': model.email,
      'imagem': model.imagem,
      'logradouro': model.logradouro,
      'cep': model.cep,
      'cidade': model.cidade,
      'numero': model.numero,
      'uf': model.uf
    });
  }

  @override
  Future editContact(ContactModel model) {
    return firestore
        .collection('contato')
        .doc(model.reference!.id.toString())
        .update({
          'nome': model.nome,
          'telefone_1': model.telefone1,
          'telefone_2': model.telefone2,
          'email': model.email,
          'imagem': model.imagem,
          'logradouro': model.logradouro,
          'cep': model.cep,
          'cidade': model.cidade,
          'numero': model.numero,
          'uf': model.uf,
          'complemento': model.complemento
        })
        .then((value) => developer.log("Contato atualizado"))
        .catchError(
            (error) => developer.log("Falha ao atualizar contato: $error"));
  }
}
