import 'package:historycontacts/domain/entity/History.dart';

class HistoryList {
  List<History> history;

  HistoryList({this.history});

  factory HistoryList.fromJson(Map<String, dynamic> json) {
    return HistoryList(
      history: json['history'] != null ? (json['history'] as List).map((i) => History.fromMap(i)).toList() : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.history != null) {
      data['history'] = this.history.map((v) => v.toMap()).toList();
    }
    return data;
  }
}
