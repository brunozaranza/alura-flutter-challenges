import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

abstract class FirestoreContract {
  Future<dynamic> add(Map<String, dynamic> map, {DocumentReference reference});

  Future<dynamic> edit(DocumentReference reference, Map<String, dynamic> map);

  Future<dynamic> delete(DocumentReference reference);

  Future<dynamic> getBy({@required String param});

  Future<List<dynamic>> getList({DocumentReference reference});
}
