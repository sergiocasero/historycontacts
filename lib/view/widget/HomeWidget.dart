import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:historycontacts/di/Locator.dart';
import 'package:historycontacts/domain/entity/Contact.dart';
import 'package:historycontacts/domain/entity/History.dart';
import 'package:historycontacts/view/viewmodel/HomeViewModel.dart';
import 'package:historycontacts/view/widget/RootWidget.dart';
import 'package:intl/intl.dart';

class HomeWidget extends RootWidget<HomeViewModel> {
  HomeWidget() : super(getIt());

  @override
  Widget widget(HomeViewModel model) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contactos estrechos"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: Chip(
              label: Text("${model.total} en total"),
              backgroundColor: Colors.white,
            ),
          ),
        ],
      ),
      body: withProgress(
          body: model.latestHistory.isEmpty
              ? _emptyCase()
              : ListView.builder(
                  itemCount: model.latestHistory.keys.length,
                  itemBuilder: (ctx, index) {
                    final contact = model.latestHistory.keys.toList()[index];
                    print(model.latestHistory);
                    return _contactHistory(
                      contact,
                      model.latestHistory[contact],
                    );
                  },
                ),
          model: model),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => model.onAddPressed(),
        label: Text("Registrar"),
        icon: Icon(Icons.add),
      ),
    );
  }

  Widget _contactHistory(Contact contact, List<History> history) {
    return Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12.0, top: 10.0, right: 12),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "${contact.name} ${contact.surname}",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                Chip(
                  label: Text("${history.length} veces"),
                  backgroundColor: Colors.white,
                  shape: StadiumBorder(side: BorderSide(color: Colors.blue)),
                ),
              ],
            ),
          ),
          Container(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: history.length,
              itemBuilder: (ctx, index) {
                return _history(model, history[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _history(HomeViewModel model, History history) {
    final date = DateFormat("dd/MM/yy 'a las' HH:mm").format(history.timestamp);
    return Padding(
      padding: const EdgeInsets.only(left: 4.0, top: 8.0),
      child: Card(
        color: Colors.blue,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              date,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
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
