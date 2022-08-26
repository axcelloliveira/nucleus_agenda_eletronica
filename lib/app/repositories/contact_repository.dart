import 'dart:developer' as developer;

import 'package:agenda_eletronica/app/models/contact_model.dart';
import 'package:agenda_eletronica/app/repositories/contact_repository_imp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ContactRepository implements IContactRepository {
  final FirebaseFirestore firestore;

  ContactRepository(this.firestore);

  CollectionReference contacts =
      FirebaseFirestore.instance.collection('contato');

  @override
  Stream<List<ContactModel>> getContacts() {
    return contacts.orderBy('nome').snapshots().map((query) {
      return query.docs.map((doc) {
        return ContactModel.fromDocument(doc);
      }).toList();
    });
  }

  @override
  Future deleteContact(DocumentReference reference) {
    return contacts
        .doc(reference.id.toString())
        .delete()
        .then((value) => developer.log("Contato excluído"))
        .catchError(
            (error) => developer.log("Falha ao excluir contato: $error"));
  }

  @override
  Future saveContact(ContactModel model) async {
    model.reference = await contacts.add({
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
    return contacts
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
