import 'package:get_it/get_it.dart';
import 'package:historycontacts/data/datasource/Local.dart';
import 'package:historycontacts/data/datasource/SqliteLocal.dart';
import 'package:historycontacts/data/repository/ContactRepositoryImpl.dart';
import 'package:historycontacts/domain/ContactRepository.dart';
import 'package:sqflite/sqflite.dart';

final getIt = GetIt.I;

Future<void> initializeDI() async {
  await _data();
  await _domain();
  await _view();
}

void _data() async {
  final db = await openDatabase(
    "history.db",
    version: 1,
    onCreate: (db, version) async {

      final createContactQuery ='''CREATE TABLE contact(
      id INTEGER PRIMARY KEY,
      name TEXT,
      surname TEXT,
      phone TEXT,
      address TEXT,
    );''';

      final createHistoryQuery = '''
        CREATE TABLE history(
      id INTEGER PRIMARY KEY,
      timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
      id_contact INTEGER
    );
      ''';

      return db.execute(createContactQuery + createHistoryQuery);
    },
  );

  // DATA
  getIt.registerSingleton<Local>(SqliteLocal(db));
  getIt.registerSingleton<ContactRepository>(ContactRepositoryImpl(getIt.get()));
}

void _domain() async {}

void _view() async {
  // getIt.registerFactory<SplashViewModel>(() => SplashViewModel(getIt()));
}