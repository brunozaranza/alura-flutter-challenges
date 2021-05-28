import 'package:challenge3/core/models/category.dart';
import 'package:challenge3/core/repositories/firebase/firestore_contract.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class CategotyFirestore implements FirestoreContract {
  CollectionReference categories =
  FirebaseFirestore.instance.collection('categories');

  @override
  Future<Category> add(map, {reference}) async {
    DocumentReference ref = await categories
        .add(map)
        .catchError((error) => print("Failed to add category: $error"));

    edit(ref, {"id": ref.id});

    return Category.fromJson((await ref.get()).data(), ref);
  }

  @override
  Future delete(reference) {
    return reference.delete();
  }

  @override
  Future<Category> edit(reference, map) async {
    reference.update(map);

    return Category.fromJson((await reference.get()).data(), reference);
  }

  @override
  Future<Category> getBy({@required String param}) async {
    DocumentSnapshot snapshot = await categories.doc(param).get();

    return Category.fromJson(snapshot.data(), snapshot.reference);
  }

  @override
  Future<List<Category>> getList({reference}) async {
    List<Category> list = [];
    QuerySnapshot querySnapshot = await categories.get();
    List<QueryDocumentSnapshot> queryList = querySnapshot.docs.toList();

    for(QueryDocumentSnapshot query in queryList) {
      list.add(Category.fromJson(query.data(), query.reference));
    }
    return list;
  }
}
