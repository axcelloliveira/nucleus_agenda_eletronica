import 'package:agenda_eletronica/app/models/contact_model.dart';

abstract class IContactRepository {
  Stream<List<ContactModel>> getContacts();

  Future saveContact(ContactModel model);

  Future editContact(ContactModel model);

  Future deleteContact(ContactModel model);
}
