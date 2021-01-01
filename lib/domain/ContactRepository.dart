import 'package:historycontacts/domain/entity/Contact.dart';
import 'package:historycontacts/domain/entity/History.dart';

abstract class ContactRepository {
  Future<Map<Contact, List<History>>> getHistory();

  Future<void> addHistory(History history);

  Future<int> addContact(Contact contact);

  Future<List<Contact>> getContacts();
}
