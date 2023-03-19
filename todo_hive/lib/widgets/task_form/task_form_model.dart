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

    final groupBox = await Hive.openBox<Group>('goups_box');
    final group = groupBox.get(groupKey);
    group?.addTask(taskBox, task);
    group?.save();
    Navigator.of(context).pop();
  }
}

class TaskFormWidgetProvider extends InheritedWidget {
  final TaskFormWidgetModel model;

  const TaskFormWidgetProvider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(
          key: key,
          child: child,
        );

  static TaskFormWidgetProvider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TaskFormWidgetProvider>();
  }

  static TaskFormWidgetProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<TaskFormWidgetProvider>()
        ?.widget;
    return widget is TaskFormWidgetProvider ? widget : null;
  }

  @override
  bool updateShouldNotify(TaskFormWidgetProvider oldWidget) {
    return false;
  }
}
