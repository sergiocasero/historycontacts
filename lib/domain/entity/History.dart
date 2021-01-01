class History {
    int id;
    String idContact;
    DateTime timestamp;

    History({this.id, this.idContact, this.timestamp});

    factory History.fromMap(Map<String, dynamic> json) {
        return History(
            id: json['id'], 
            idContact: json['id_contact'],
            timestamp: json['timestamp'], 
        );
    }

    Map<String, dynamic> toMap() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        data['id_contact'] = this.idContact;
        data['timestamp'] = this.timestamp;
        return data;
    }
}