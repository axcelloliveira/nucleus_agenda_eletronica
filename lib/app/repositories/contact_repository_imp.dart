import 'package:agenda_eletronica/app/models/contact_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class IContactRepository {
  Stream<List<ContactModel>> getContacts();

  Future saveContact(ContactModel model);

  Future editContact(ContactModel model);

  Future deleteContact(DocumentReference document);
}
