import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:historycontacts/di/Locator.dart';
import 'package:historycontacts/view/viewmodel/HomeViewModel.dart';
import 'package:historycontacts/view/viewmodel/RootViewModel.dart';
import 'package:historycontacts/view/widget/RootWidget.dart';

class HomeWidget extends RootWidget<HomeViewModel> {
  HomeWidget() : super(getIt());

  @override
  Widget widget(RootViewModel model) {
    return Scaffold(
      body: withProgress(body: Container(), model: model),
    );
  }
}
