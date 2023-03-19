import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:todo_hive/widgets/task_form/task_form_model.dart';

class TaskFormWidget extends StatefulWidget {
  const TaskFormWidget({super.key});

  @override
  State<TaskFormWidget> createState() => _TaskFormWidgetState();
}

class _TaskFormWidgetState extends State<TaskFormWidget> {
  TaskFormWidgetModel? _model;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (_model == null) {
      final groupKey = ModalRoute.of(context)!.settings.arguments as int;
      _model = TaskFormWidgetModel(groupKey: groupKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TaskFormWidgetProvider(child: _taskFormWidgetBody(), model: _model!);
  }
}

class _taskFormWidgetBody extends StatelessWidget {
  const _taskFormWidgetBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Новая задача'),
        centerTitle: true,
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: _TaskTextWidget(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            TaskFormWidgetProvider.read(context)?.model.saveTask(context),
        child: const Icon(Icons.done),
      ),
    );
  }
}

class _TaskTextWidget extends StatelessWidget {
  const _TaskTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = TaskFormWidgetProvider.read(context)?.model;
    return TextField(
        minLines: null,
        maxLines: null,
        expands: true,
        autofocus: true,
        decoration: const InputDecoration(
            border: InputBorder.none, hintText: 'Текст задачи'),
        onEditingComplete: () => model?.saveTask(context),
        onChanged: (value) => model?.taskText = value);
  }
}
