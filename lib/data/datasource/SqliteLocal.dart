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
}
