import 'package:historycontacts/data/datasource/Local.dart';
import 'package:historycontacts/domain/ContactRepository.dart';
import 'package:historycontacts/domain/entity/Contact.dart';
import 'package:historycontacts/domain/entity/History.dart';

class ContactRepositoryImpl extends ContactRepository {
  final Local _local;

  ContactRepositoryImpl(this._local);

  @override
  Future<void> addContact(Contact contact) {
    // TODO: implement addContact
    throw UnimplementedError();
  }

  @override
  Future<void> addHistory(History history) {
    // TODO: implement addHistory
    throw UnimplementedError();
  }

  @override
  Future<Map<Contact, List<History>>> getHistory() {
    return _local.getHistory();
  }
}