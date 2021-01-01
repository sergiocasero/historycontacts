import 'package:historycontacts/domain/ContactRepository.dart';
import 'package:historycontacts/domain/entity/Contact.dart';
import 'package:historycontacts/view/viewmodel/RootViewModel.dart';

class AddViewModel extends RootViewModel {
  final ContactRepository _repository;

  AddViewModel(this._repository);

  @override
  initialize() {
    // Nothing to do
  }

  void onSavePressed(Contact contact) {}

  void onAddContactPressed(String name, String surname, String address, String phone) {}
}
