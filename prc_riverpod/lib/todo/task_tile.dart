import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  TaskTile({
    this.isChecked,
    this.taskTitle,
    this.checkCallback,
    this.longPressCallback,
  });
  final bool isChecked;
  final String taskTitle;
  final Function(bool) checkCallback;
  final Function() longPressCallback;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 4,
      child: GestureDetector(
        onLongPress: longPressCallback,
        child: CheckboxListTile(
          title: Text(
            taskTitle,
            style: TextStyle(
                decoration: isChecked ? TextDecoration.lineThrough : null),
          ),
          value: isChecked,
          activeColor: Colors.lightBlueAccent,
          onChanged: checkCallback,
        ),
      ),
    );
  }
}
