import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_hive/domain/entity/task.dart';

import '../../domain/entity/group.dart';

class TasksWidgetModel extends ChangeNotifier {
  void _setup() {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(GroupAdapter());
    }
    _groupBox = Hive.openBox<Group>('groups_box');
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(TaskAdapter());
    }
    _taskBox = Hive.openBox<Task>('tasks_box');
    _loadGroup();
    _setupListenTasks();
  }

  TasksWidgetModel({required this.groupKey}) {
    _setup();
  }

  int groupKey;
  late final Future<Box<Group>> _groupBox;
  var tasks = <Task>[];
  late final Future<Box<Task>> _taskBox;
  Group? _group;
  Group? get group => _group;

  void showForm(BuildContext context) {
    Navigator.of(context).pushNamed('/groups/tasks/form/', arguments: groupKey);
  }

  void _loadGroup() async {
    final box = await _groupBox;
    _group = box.get(groupKey);
    notifyListeners();
    print(_group?.tasks?.length);
  }

  void _readTasks() {
    tasks = _group?.tasks ?? <Task>[];
    notifyListeners();
  }

  void _setupListenTasks() async {
    final box = await _groupBox;
    _readTasks();
    box.listenable(keys: <dynamic>[groupKey]).addListener(_readTasks);
  }

  void doneToggle(int groupIndex) async {
    final task = group?.tasks?[groupIndex];
    final currentState = task?.isDone ?? false;
    task?.isDone = !currentState;
    await task?.save();
    notifyListeners();
  }
}

class TasksWidgetModelProvider extends InheritedNotifier {
  final TasksWidgetModel model;
  const TasksWidgetModelProvider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(
          key: key,
          notifier: model,
          child: child,
        );

  static TasksWidgetModelProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<TasksWidgetModelProvider>();
  }

  static TasksWidgetModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<TasksWidgetModelProvider>()
        ?.widget;
    return widget is TasksWidgetModelProvider ? widget : null;
  }
}
