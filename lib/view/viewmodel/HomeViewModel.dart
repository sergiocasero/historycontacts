import 'package:get/get.dart';
import 'package:historycontacts/domain/ContactRepository.dart';
import 'package:historycontacts/domain/entity/Contact.dart';
import 'package:historycontacts/domain/entity/History.dart';
import 'package:historycontacts/view/viewmodel/RootViewModel.dart';
import 'package:historycontacts/view/widget/AddWidget.dart';

class HomeViewModel extends RootViewModel {
  final ContactRepository _repository;

  Map<Contact, List<History>> _latestHistory = Map();

  HomeViewModel(this._repository);

  Map<Contact, List<History>> get latestHistory => _latestHistory;

  @override
  initialize() async {
    _getHistory();
  }

  void _getHistory() async {
    showProgress();

    _latestHistory = await _repository.getHistory();

    hideProgress();
  }

  void onAddPressed() {
    Get.to(AddWidget());
  }
}
