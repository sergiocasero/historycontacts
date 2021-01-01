import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:historycontacts/di/Locator.dart';
import 'package:historycontacts/domain/entity/Contact.dart';
import 'package:historycontacts/view/viewmodel/AddViewModel.dart';
import 'package:historycontacts/view/widget/RootWidget.dart';

class AddWidget extends RootWidget<AddViewModel> {
  AddWidget() : super(getIt());

  String _name = "";
  String _surname = "";
  String _address = "";
  String _phone = "";
  final _formKey = GlobalKey<FormState>();

  @override
  Widget widget(AddViewModel model) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Añadir contacto estrecho"),
      ),
      body: withProgress(body: _contactsList(model), model: model),
    );
  }

  Widget _newContact() {
    return Form(
      key: _formKey,
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text("Añádelo"),
            ),
            _input("Nombre *", Icons.person, (value) {
              _name = value;
            }),
            _input("Apellidos", Icons.person_outline, (value) {
              _surname = value;
            }),
            _input("Dirección", Icons.location_on, (value) {
              _address = value;
            }),
            _input("Teléfono", Icons.phone, (value) {
              _phone = value;
            }),
            RaisedButton.icon(
              icon: Icon(Icons.save),
              label: Text("Guardar y registrar"),
              onPressed: () => _onSavePressed(model),
            ),
          ],
        ),
      ),
    );
  }

  Widget _input(String hint, IconData icon, Function(String) onSave) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0, left: 4.0, right: 4.0),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hint,
          icon: Icon(icon),
        ),
        onSaved: (value) => onSave(value),
      ),
    );
  }

  void _onSavePressed(AddViewModel model) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      model.onAddContactPressed(_name, _surname, _address, _phone);
    }
  }

  Widget _contactsList(AddViewModel model) {
    return Column(
      children: [
        Text("Selecciona un contacto para registrarlo en la app"),
        Expanded(
          child: Container(
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: (ctx, index) {
                return _contactItem(model.contacts[index], model);
              },
              itemCount: model.contacts.length,
            ),
          ),
        ),
      ],
    );
  }

  Widget _contactItem(Contact contact, AddViewModel model) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        child: ListTile(
          onTap: () => model.onSaveHistoryPressed(contact.id, contact),
          leading: CircleAvatar(
            child: Text(contact.name.substring(0, 1)),
          ),
          title: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text("${contact.name} ${contact.surname}"),
          ),
          subtitle: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.location_on),
                  Text(contact.address),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.phone),
                  Text(contact.phone),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
