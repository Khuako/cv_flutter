import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:todo_hive/widgets/group_form/group_form_widget.dart';
import 'package:todo_hive/widgets/groups/groups_widget.dart';
import 'package:todo_hive/widgets/task_form/task_form_widget.dart';
import 'package:todo_hive/widgets/tasks/tasks_widget.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: {
        '/groups/': (context) => GroupsWidget(),
        '/groups/form': (context) => GroupFormWidget(),
        '/groups/tasks': (context) => TasksWidget(),
        '/groups/tasks/form/': (context) => TaskFormWidget(),
      },
      initialRoute: '/groups/',
    );
  }
}
