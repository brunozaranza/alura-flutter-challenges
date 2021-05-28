import 'package:challenge3/core/models/category.dart';
import 'package:challenge3/core/models/task.dart';
import 'package:challenge3/core/repositories/firebase/task_firestore.dart';
import 'package:challenge3/core/viewmodels/viewmodel_contract.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TaskViewModel extends ChangeNotifier implements ViewModelContract {
  TaskFirestore _firestore ;

  bool isButtonAddActive = false;

  List<Task> list = [];

  Category category;

  setCategory(Category cat) {
    category = cat;
    _firestore = TaskFirestore(categoryId: cat.reference.id);
  }

  delete(String taskId) async {
    DocumentReference reference = await _firestore.getBy(param: taskId);
    reference.delete();
    updateList();
  }

  @override
  updateList() async {
    if (category != null) {
      list = await _firestore.getList(reference: category.reference);
      notifyListeners();
    }
  }

  @override
  setButtonAddActive(bool isActive) {
    this.isButtonAddActive = isActive;

    notifyListeners();
  }

  save(String description, Category category) {
    _firestore.add(Task(
            description: description,
            date: Timestamp.now(),
            status: false,
            categoryId: category.id)
        .toJson());

    updateList();
  }
}
