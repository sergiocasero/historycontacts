import 'package:historycontacts/data/datasource/Local.dart';
import 'package:historycontacts/domain/ContactRepository.dart';
import 'package:historycontacts/domain/entity/Contact.dart';
import 'package:historycontacts/domain/entity/History.dart';

class ContactRepositoryImpl extends ContactRepository {
  final Local _local;

  ContactRepositoryImpl(this._local);

  @override
  Future<int> addContact(Contact contact) {
    return _local.addContact(contact);
  }

  @override
  Future<void> addHistory(History history) {
    return _local.addHistory(history);
  }

  @override
  Future<Map<Contact, List<History>>> getHistory() {
    return _local.getHistory();
  }

  @override
  Future<List<Contact>> getContacts() {
    return _local.getContacts();
  }

  @override
  Future<bool> hasAskedForContacts() {
    return _local.hasAskedForContacts();
  }

  @override
  Future<void> setAskedForContacts(bool value) {
    return _local.setAskedForContacts(value);
  }

  @override
  Future<void> addContacts(List<Contact> list) {
    return _local.addContacts(list);
  }

  @override
  Future<void> deleteHistory(int id) {
    return _local.deleteHistory(id);
  }
}
