import 'package:flutter/material.dart';

class TaskFAB extends StatelessWidget {
  final Function onPressed;
  final IconData icon;
  final String tooltip;

  TaskFAB({
    @required this.onPressed,
    @required this.icon,
    this.tooltip = "",
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: Icon(icon),
      tooltip: tooltip,
    );
  }
}
