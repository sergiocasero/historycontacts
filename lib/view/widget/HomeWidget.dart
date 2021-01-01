import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:historycontacts/di/Locator.dart';
import 'package:historycontacts/domain/entity/Contact.dart';
import 'package:historycontacts/view/viewmodel/HomeViewModel.dart';
import 'package:historycontacts/view/widget/RootWidget.dart';

class HomeWidget extends RootWidget<HomeViewModel> {
  HomeWidget() : super(getIt());

  @override
  Widget widget(HomeViewModel model) {
    return Scaffold(
      body: withProgress(
          body: model.latestHistory.isEmpty
              ? _emptyCase()
              : ListView.builder(
                  itemCount: model.latestHistory.keys.length,
                  itemBuilder: (ctx, index) {
                    return _contactHistory(model.latestHistory.keys.toList()[index]);
                  },
                ),
          model: model),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => model.onAddPressed(),
        label: Text("Añadir"),
        icon: Icon(Icons.add),
      ),
    );
  }

  Widget _contactHistory(Contact list) {
    return Text("Hello");
  }

  Widget _emptyCase() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "No tienes ningún registro de contacto con nadie en los últimos 7 días\nPara crear uno, pulsa en el botón de '+'",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
