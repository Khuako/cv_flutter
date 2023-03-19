import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_hive/widgets/tasks/tasks_widget_model.dart';

class TasksWidget extends StatefulWidget {
  const TasksWidget({super.key});

  @override
  State<TasksWidget> createState() => _TasksWidgetState();
}

class _TasksWidgetState extends State<TasksWidget> {
  TasksWidgetModel? _model;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (_model == null) {
      final groupKey = ModalRoute.of(context)!.settings.arguments as int;
      _model = TasksWidgetModel(groupKey: groupKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    final model = _model;
    if (model != null) {
      return TasksWidgetModelProvider(
        model: model,
        child: TasksWidgetBody(),
      );
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }
}

class TasksWidgetBody extends StatelessWidget {
  const TasksWidgetBody({super.key});

  @override
  Widget build(BuildContext context) {
    final model = TasksWidgetModelProvider.watch(context)?.model;
    final title = model?.group?.name ?? 'Задачи';
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: const SafeArea(
        child: _TaskListWidget(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => model?.showForm(context),
      ),
    );
  }
}

class _TaskListWidget extends StatelessWidget {
  const _TaskListWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final tasksCount =
        TasksWidgetModelProvider.watch(context)?.model.tasks.length ?? 0;
    return ListView.separated(
        itemBuilder: (context, index) {
          return _TaskListRowWidget(
            indexInList: index,
          );
        },
        separatorBuilder: ((context, index) {
          return const Divider(
            height: 1,
          );
        }),
        itemCount: tasksCount);
  }
}

class _TaskListRowWidget extends StatelessWidget {
  final int indexInList;
  _TaskListRowWidget({required this.indexInList});

  @override
  Widget build(BuildContext context) {
    final tasksList = TasksWidgetModelProvider.read(context)?.model.tasks;
    return Slidable(
      endActionPane: ActionPane(
        extentRatio: 0.3,
        motion: BehindMotion(),
        children: [
          SlidableAction(
            padding: EdgeInsets.symmetric(horizontal: 12),
            onPressed: null,
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: ListTile(
        title: Text(tasksList![indexInList].text),
        trailing: Icon(Icons.chevron_right),
        onTap: () {},
      ),
    );
  }
}
