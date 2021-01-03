class Contact {
    String address;
    int id;
    String name;
    String phone;
    String surname;

    Contact({this.address, this.id, this.name, this.phone, this.surname});

    factory Contact.fromMap(Map<String, dynamic> json) {
        return Contact(
            address: json['address'], 
            id: json['id'], 
            name: json['name'], 
            phone: json['phone'], 
            surname: json['surname'], 
        );
    }

    Map<String, dynamic> toMap() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['address'] = this.address;
        data['id'] = this.id;
        data['name'] = this.name;
        data['phone'] = this.phone;
        data['surname'] = this.surname;
        return data;
    }
}
