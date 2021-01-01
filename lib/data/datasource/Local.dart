import 'package:historycontacts/domain/entity/Contact.dart';
import 'package:historycontacts/domain/entity/History.dart';

abstract class Local {
  Future<Map<Contact, List<History>>> getHistory();

  Future<int> addContact(Contact contact);

  Future<void> addHistory(History history);

  Future<List<Contact>> getContacts();
}
