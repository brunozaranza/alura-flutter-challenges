import 'package:challenge3/core/models/task.dart';
import 'package:challenge3/core/repositories/firebase/firestore_contract.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TaskFirestore implements FirestoreContract {

  CollectionReference _tasks;

  TaskFirestore({String categoryId}) {
    _tasks = FirebaseFirestore.instance.collection('categories').doc(categoryId).collection("tasks");
  }

  @override
  Future<Task> add(map, {reference}) async {
    DocumentReference ref = await _tasks
        .add(map)
        .catchError((error) => print("Failed to add task: $error"));

    edit(ref, {"id": ref.id});

    return Task.fromJson((await ref.get()).data());
  }

  @override
  Future delete(DocumentReference<Object> reference) {
    return reference.delete();
  }

  @override
  Future<Task> edit(
      DocumentReference<Object> reference, Map<String, dynamic> map) async {
    reference.update(map);

    return Task.fromJson((await reference.get()).data());
  }

  @override
  Future<DocumentReference> getBy({String param}) async {
    DocumentSnapshot snapshot = await _tasks.doc(param).get();

    return snapshot.reference;
  }

  @override
  Future<List> getList({reference}) async {
    List<Task> list = [];
    QuerySnapshot querySnapshot = await _tasks.get();

    List<QueryDocumentSnapshot> queryList = querySnapshot.docs.toList();

    for (QueryDocumentSnapshot query in queryList) {
      list.add(Task.fromJson(query.data()));
    }
    return list;
  }
}
