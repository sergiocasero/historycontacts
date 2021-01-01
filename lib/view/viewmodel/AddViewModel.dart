import 'package:get/get.dart';
import 'package:historycontacts/domain/ContactRepository.dart';
import 'package:historycontacts/domain/entity/Contact.dart';
import 'package:historycontacts/domain/entity/History.dart';
import 'package:historycontacts/view/viewmodel/RootViewModel.dart';

class AddViewModel extends RootViewModel {
  final ContactRepository _repository;

  List<Contact> _contacts = [];

  List<Contact> get contacts => _contacts;

  AddViewModel(this._repository);

  @override
  initialize() {
    _getContacts();
  }

  void _getContacts() async {
    showProgress();

    final contacts = await _repository.getContacts();
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
}
