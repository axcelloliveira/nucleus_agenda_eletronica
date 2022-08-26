import 'package:agenda_eletronica/app/models/contact_model.dart';
import 'package:agenda_eletronica/app/repositories/contact_repository_imp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactController extends GetxController {
  final IContactRepository _contactRepository;

  ContactController(this._contactRepository);

  var isSearching = false.obs;
  var stateAppBar = false.obs;
  TextEditingController search = TextEditingController();
  Stream<List<ContactModel>>? contactStream;
  List<ContactModel> contactsFiltered = [];
  List<ContactModel>? list;

  String getInitials(String name) => name.isNotEmpty
      ? name.trim().split(RegExp(' +')).map((s) => s[0]).take(2).join()
      : '';

  @override
  void onInit() {
    super.onInit();
    getContacts();
    search.addListener(() {
      filterContacts();
    });
  }

  setStateAppBar() {
    stateAppBar.value = !stateAppBar.value;
    search.text = '';
    contactsFiltered.clear();
    isSearching.value = !isSearching.value;
    update();
  }

  filterContacts() {
    List<ContactModel> _contacts = [];
    _contacts.addAll(list!);
    if (search.text.isNotEmpty) {
      _contacts.retainWhere((contact) {
        String searchItem = search.text.toLowerCase();
        String contactName = contact.nome!.toLowerCase();
        return contactName.contains(searchItem);
      });
      contactsFiltered = _contacts;
      isSearching.value = true;
      update();
    }
  }

  getContacts() {
    contactStream = _contactRepository.getContacts();
  }
}
