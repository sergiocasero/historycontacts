import 'package:historycontacts/domain/entity/Contact.dart';

class ContactList {
  List<Contact> contacts;

  ContactList({this.contacts});

  factory ContactList.fromJson(Map<String, dynamic> json) {
    return ContactList(
      contacts: json['contacts'] != null ? (json['contacts'] as List).map((i) => Contact.fromMap(i)).toList() : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.contacts != null) {
      data['contacts'] = this.contacts.map((v) => v.toMap()).toList();
    }
    return data;
  }
}
