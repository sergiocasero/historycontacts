import 'dart:convert';

import 'package:historycontacts/data/datasource/Local.dart';
import 'package:historycontacts/domain/entity/Contact.dart';
import 'package:historycontacts/domain/entity/ContactList.dart';
import 'package:historycontacts/domain/entity/History.dart';
import 'package:historycontacts/domain/entity/HistoryList.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedLocal extends Local {
  final SharedPreferences _prefs;

  final String _CONTACTS_KEY = "_CONTACTS_KEY";
  final String _HISTORY_KEY = "_HISTORY_KEY";

  SharedLocal(this._prefs) {
    _initialize();
  }

  void _initialize() {
    _prefs.setString(_CONTACTS_KEY, jsonEncode(ContactList(contacts: [])));
    _prefs.setString(_HISTORY_KEY, jsonEncode(HistoryList(history: [])));
  }

  @override
  Future<int> addContact(Contact contact) async {
    var list = ContactList.fromJson(jsonDecode(_prefs.getString(_CONTACTS_KEY)));
    final lastId = list.contacts.length;
    list.contacts.add(Contact(
      id: lastId,
      address: contact.address,
      phone: contact.phone,
      surname: contact.surname,
      name: contact.name,
    ));
    await _prefs.setString(_CONTACTS_KEY, jsonEncode(list.toJson()));
    return lastId;
  }

  @override
  Future<void> addContacts(List<Contact> list) async {
    List<Contact> newList = [];

    for (final item in list) {
      newList.add(Contact(
        id: newList.length,
        address: item.address,
        phone: item.phone,
        surname: item.surname,
        name: item.name,
      ));
    }
  }

  @override
  Future<void> addHistory(History history) async {
    var list = HistoryList.fromJson(jsonDecode(_prefs.getString(_HISTORY_KEY)));
    final lastId = list.history.length;
    list.history.add(History(
      id: lastId,
      timestamp: history.timestamp,
      idContact: history.idContact,
    ));
    await _prefs.setString(_HISTORY_KEY, jsonEncode(list.toJson()));
    return lastId;
  }

  @override
  Future<void> deleteHistory(int id) {
    // TODO: implement deleteHistory
    throw UnimplementedError();
  }

  @override
  Future<List<Contact>> getContacts() async {
    var contacts = ContactList.fromJson(jsonDecode(_prefs.getString(_CONTACTS_KEY)));
    return contacts.contacts;
  }

  @override
  Future<Map<Contact, List<History>>> getHistory() async {
    var contacts = ContactList.fromJson(jsonDecode(_prefs.getString(_CONTACTS_KEY)));
    var history = HistoryList.fromJson(jsonDecode(_prefs.getString(_HISTORY_KEY)));

    final since = DateTime.now().subtract(Duration(days: 7));

    Map<Contact, List<History>> map = Map();

    for (final contact in contacts.contacts) {
      List<History> newHistory = [];

      for (var item in history.history) {
        if (item.idContact == contact.id && item.timestamp.isAfter(since)) {
          newHistory.add(item);
        }
      }

      if (newHistory.isNotEmpty) {
        map[contact] = newHistory;
      }
    }

    return map;
  }

  @override
  Future<bool> hasAskedForContacts() async {
    return true;
  }

  @override
  Future<void> setAskedForContacts(bool value) {
    // Do nothing
  }
}
