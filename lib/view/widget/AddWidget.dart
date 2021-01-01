import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:historycontacts/di/Locator.dart';
import 'package:historycontacts/view/viewmodel/AddViewModel.dart';
import 'package:historycontacts/view/widget/RootWidget.dart';

class AddWidget extends RootWidget<AddViewModel> {
  AddWidget() : super(getIt());

  @override
  Widget widget(AddViewModel model) {
    return Container();
  }
}
