import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  String id;
  String description;
  bool status;
  Timestamp date;
  String categoryId;

  Task({
    this.id,
    this.description,
    this.status,
    this.date,
    this.categoryId,
  });

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    status = json['status'];
    date = json['date'];
    categoryId = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['date'] = this.date;
    data['status'] = this.status;
    data['category'] = categoryId;
    return data;
  }
}
