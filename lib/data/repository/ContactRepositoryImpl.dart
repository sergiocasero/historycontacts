import 'package:historycontacts/data/datasource/Local.dart';
import 'package:historycontacts/domain/ContactRepository.dart';

class ContactRepositoryImpl extends ContactRepository {
  final Local _local;

  ContactRepositoryImpl(this._local);
}