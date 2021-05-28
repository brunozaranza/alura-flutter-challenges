import 'package:flutter/material.dart';

class TaskButton extends StatelessWidget {

  final String title;
  final Function() onTap;

  TaskButton({@required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(title),
      onPressed: onTap,
    );
  }


}
