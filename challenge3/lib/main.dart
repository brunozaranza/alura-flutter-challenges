import 'package:challenge3/core/viewmodels/category_viewmodel.dart';
import 'package:challenge3/core/viewmodels/task_viewmodel.dart';
import 'package:challenge3/task_app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => CategoryViewModel()),
      ChangeNotifierProvider(create: (_) => TaskViewModel()),
    ],
    child: TaskApp(),
  ));
}
