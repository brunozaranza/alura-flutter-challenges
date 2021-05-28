import 'package:flutter/material.dart';

class TaskAppBar extends StatelessWidget with PreferredSizeWidget {

  final String title;

  TaskAppBar({@required this.title});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        centerTitle: true,
        title: Text(title),
    );
  }
}
