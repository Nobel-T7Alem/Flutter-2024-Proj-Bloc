import 'dart:convert';

List<Calendar> calendarFromJson(String str) =>
    List<Calendar>.from(json.decode(str).map((x) => Calendar.fromJson(x)));

String calendarToJson(List<Calendar> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Calendar {
  Calendar({
     this.id,
    required this.name,
    required this.description,
    required this.contact,
    required this.date,
  });
  final String? id;
  final String name;
  final String description;
  final String contact;
  final String date;

  factory Calendar.fromJson(Map<String, dynamic> json) => Calendar(
    id: json['id'],
    name: json['name'],
    description: json['description'],
    contact: json['contact'],
    date: json['date'],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "id": id,
        "name": name,
        "description": description,
        "contact": contact,
      };
}
