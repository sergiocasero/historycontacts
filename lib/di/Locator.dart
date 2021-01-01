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
      return db.execute('''CREATE TABLE poi(
      id text,
      title text,
      geocoordinates text
    );''');
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