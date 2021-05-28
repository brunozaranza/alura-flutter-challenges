import 'package:challenge3/ui/pages/categories_page.dart';
import 'package:challenge3/ui/pages/initialization_page.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

FirebaseAnalytics analytics = FirebaseAnalytics();

class TaskApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        return MaterialApp(
          navigatorObservers: [
            FirebaseAnalyticsObserver(analytics: analytics),
          ],
          debugShowCheckedModeBanner: false,
          title: 'Tasks',
          theme: ThemeData(
            primarySwatch: Colors.purple,
          ),
          home: snapshot.connectionState == ConnectionState.done
              ? CategoriesPage()
              : InitializationPage(),
        );
      },
    );
  }
}
