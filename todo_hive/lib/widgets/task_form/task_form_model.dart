import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../domain/entity/group.dart';
import '../../domain/entity/task.dart';

class TaskFormWidgetModel {
  int groupKey;
  var taskText = '';
  TaskFormWidgetModel({required this.groupKey});
  void saveTask(BuildContext context) async {
    if (taskText.isEmpty) return;
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(GroupAdapter());
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(TaskAdapter());
    }
    final taskBox = await Hive.openBox<Task>('tasks_box');
    final task = Task(text: taskText, isDone: false);
    await taskBox.add(task);
    final groupBox = await Hive.openBox<Group>('groups_box');
    final group = groupBox.get(groupKey);
    group?.addTask(taskBox, task);
    Navigator.of(context).pop();
  }
}

class TaskFormWidgetProvider extends InheritedNotifier {
  final TaskFormWidgetModel model;
  TaskFormWidgetProvider({required Widget child, required this.model})
      : super(child: child);

  static TaskFormWidgetProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<TaskFormWidgetProvider>()
        ?.widget;
    return widget is TaskFormWidgetProvider ? widget : null;
  }

  static TaskFormWidgetProvider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TaskFormWidgetProvider>();
  }
}
