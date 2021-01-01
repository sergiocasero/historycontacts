import 'package:get/get.dart';
import 'package:historycontacts/domain/ContactRepository.dart';
import 'package:historycontacts/domain/entity/Contact.dart';
import 'package:historycontacts/domain/entity/History.dart';
import 'package:historycontacts/view/viewmodel/RootViewModel.dart';
import 'package:historycontacts/view/widget/AddWidget.dart';

class HomeViewModel extends RootViewModel {
  final ContactRepository _repository;

  Map<Contact, List<History>> _latestHistory = Map();
  int _total = 0;

  HomeViewModel(this._repository);

  Map<Contact, List<History>> get latestHistory => _latestHistory;

  int get total => _total;

  @override
  initialize() async {
    _getHistory();
  }

  void _getHistory() async {
    showProgress();

    _latestHistory = await _repository.getHistory();

    for (final history in _latestHistory.values) {
      _total += history.length;
    }

    notify();

    hideProgress();
  }

  void onAddPressed() {
    Get.to(AddWidget());
  }
}
