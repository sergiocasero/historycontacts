import 'package:historycontacts/domain/entity/Contact.dart';
import 'package:historycontacts/domain/entity/History.dart';

abstract class Local {
  Future<Map<Contact, List<History>>> getHistory();

}