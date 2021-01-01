import 'package:historycontacts/data/datasource/Local.dart';
import 'package:sqflite/sqflite.dart';

class SqliteLocal extends Local {
  final Database _db;

  SqliteLocal(this._db);
}
