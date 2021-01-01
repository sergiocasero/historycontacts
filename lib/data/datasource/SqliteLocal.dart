import 'package:historycontacts/data/datasource/Local.dart';
import 'package:historycontacts/domain/entity/Contact.dart';
import 'package:historycontacts/domain/entity/History.dart';
import 'package:sqflite/sqflite.dart';

class SqliteLocal extends Local {
  final Database _db;

  SqliteLocal(this._db);

  @override
  Future<Map<Contact, List<History>>> getHistory() async {
    return await Map();
  }

  @override
  Future<int> addContact(Contact contact) {
    return _db.insert("contact", contact.toMap());
  }

  @override
  Future<void> addHistory(History history) async {
    await _db.insert("history", history.toMap());
  }

  @override
  Future<List<Contact>> getContacts() async {
    final query = await _db.query("contact");
    return query.map((e) => Contact.fromMap(e)).toList();
  }
}
