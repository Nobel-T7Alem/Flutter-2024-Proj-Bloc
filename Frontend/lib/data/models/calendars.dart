import 'dart:convert';

List<Calendar> calendarFromJson(String str) => List<Calendar>.from(json.decode(str).map((x) => Calendar.fromJson(x)));

String calendarToJson(List<Calendar> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Calendar {
  Calendar({
    this.date,
  }) ;
  String? date;

  factory Calendar.fromJson(Map<String, dynamic> json) => Calendar(
    date: json["date"],

  );

  Map<String, dynamic> toJson() => {
    "date": date,
  };
}