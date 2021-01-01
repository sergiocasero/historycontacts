import 'package:contacts_service/contacts_service.dart' as Service;
import 'package:get/get.dart';
import 'package:historycontacts/domain/ContactRepository.dart';
import 'package:historycontacts/domain/entity/Contact.dart';
import 'package:historycontacts/domain/entity/History.dart';
import 'package:historycontacts/view/viewmodel/RootViewModel.dart';
import 'package:permission_handler/permission_handler.dart';

class AddViewModel extends RootViewModel {
  final ContactRepository _repository;

  List<Contact> _contacts = [];
  List<Contact> _filteredContacts = [];

  List<Contact> get contacts => _filteredContacts;

  AddViewModel(this._repository);

  @override
  initialize() {
    _getContacts();
  }

  void _getContacts() async {
    showProgress();

    if (!await _repository.hasAskedForContacts()) {
      final isGranted = await Permission.contacts.request().isGranted;
      await _repository.setAskedForContacts(true);

      if (isGranted) {
        Iterable<Service.Contact> contacts = await Service.ContactsService.getContacts();
        _repository.addContacts(contacts
            .map((e) => Contact(
                name: e.displayName,
                surname: e.middleName,
                phone: e.phones.isEmpty ? "" : e.phones.first.value,
                address: e.postalAddresses.isEmpty ? "" : e.postalAddresses.first.toString()))
            .toList());
      }
    }

    final contacts = await _repository.getContacts();
    _filteredContacts.clear();
    _filteredContacts.addAll(contacts);
    _contacts.clear();
    _contacts.addAll(contacts);
    notify();

    hideProgress();
  }

  void onSaveHistoryPressed(int id, Contact contact) async {
    showProgress();

    final history = History(idContact: id, timestamp: DateTime.now());

    await _repository.addHistory(history);

    hideProgress();

    Get.back(result: true);
  }

  void onAddContactPressed(String name, String surname, String address, String phone) async {
    showProgress();

    final contact = Contact(
      name: name,
      surname: surname,
      address: address,
      phone: phone,
    );

    final idContact = await _repository.addContact(contact);

    onSaveHistoryPressed(idContact, contact);

    hideProgress();
  }

  void onChanged(String value) {
    List<Contact> filtered = _contacts.where((e) => e.name.toLowerCase().contains(value.toLowerCase())).toList();
    _filteredContacts.clear();
    _filteredContacts.addAll(filtered);
    notify();
  }
}
