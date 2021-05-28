import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  String id;
  String name;
  String icon;
  DocumentReference reference;

  Category({
    this.id,
    this.name,
    this.icon,
    this.reference,
  });

  Category.fromJson(Map<String, dynamic> json, DocumentReference documentReference) {
    id = json['id'];
    name = json['name'];
    icon = json['age'];
    reference = documentReference;
  }

  Category.fromReference(DocumentReference ref) {
    reference.get().then((document) {

      Category category = Category.fromJson(document.data(), ref);

      id = category.id;
      name = category.name;
      icon = category.icon;
      reference = ref;
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.name;
    data['name'] = this.name;
    data['icon'] = this.icon;
    return data;
  }
}
