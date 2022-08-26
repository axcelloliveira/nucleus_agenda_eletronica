import 'package:agenda_eletronica/app/models/contact_model.dart';
import 'package:agenda_eletronica/app/repositories/contact_repository_imp.dart';

class ContactController {
  final IContactRepository _contactRepository;

  ContactController(this._contactRepository);

  Stream<List<ContactModel>>? contactStream;
  String getInitials(String name) => name.isNotEmpty
      ? name.trim().split(RegExp(' +')).map((s) => s[0]).take(2).join()
      : '';
  getContact() {
    contactStream = _contactRepository.getContacts();
  }
}
