import 'package:historycontacts/data/datasource/Local.dart';
import 'package:historycontacts/domain/entity/Contact.dart';
import 'package:historycontacts/domain/entity/History.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class SqliteLocal extends Local {
  final Database _db;
  final SharedPreferences _preferences;

  SqliteLocal(this._db, this._preferences);

  @override
  Future<Map<Contact, List<History>>> getHistory() async {
    Map<Contact, List<History>> map = Map();

    final contacts = await getContacts();

    final since = DateTime.now().subtract(Duration(days: 7)).millisecondsSinceEpoch;

    for (final contact in contacts) {
      final history =
          await _db.rawQuery("SELECT * FROM HISTORY WHERE " + "id_contact = ${contact.id} AND timestamp > $since");

      if (history.isNotEmpty) {
        map[contact] = history.map((e) => History.fromMap(e)).toList();
      }
    }

    return map;
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

  @override
  Future<bool> hasAskedForContacts() async {
    return _preferences.containsKey("CONTACTS") && _preferences.getBool("CONTACTS");
  }

  @override
  Future<void> setAskedForContacts(bool value) async {
    await _preferences.setBool("CONTACTS", value);
  }

  @override
  Future<void> addContacts(List<Contact> list) {
    final batch = _db.batch();
    for (final contact in list) {
      batch.insert("contact", contact.toMap());
    }
    return batch.commit();
  }
}
