import 'package:challenge3/core/models/category.dart';
import 'package:challenge3/core/repositories/firebase/category_firestore.dart';
import 'package:flutter/material.dart';

class CategoryViewModel extends ChangeNotifier {
  CategotyFirestore _firestore = CategotyFirestore();

  bool isButtonAddActive = false;

  List<Category> list;

  updateList() async {

    list = await _firestore.getList();

    notifyListeners();
  }

  setButtonAddActive(bool isActive) {
    this.isButtonAddActive = isActive;

    notifyListeners();
  }

  save(String categoryTitle) {
    _firestore.add(Category(name: categoryTitle).toJson());

    updateList();
  }
}
