import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_hive/widgets/groups/groups_widget_model.dart';

class GroupsWidget extends StatefulWidget {
  @override
  State<GroupsWidget> createState() => _GroupsWidgetState();
}

class _GroupsWidgetState extends State<GroupsWidget> {
  final _model = GroupsWidgetModel();
  @override
  Widget build(BuildContext context) {
    return GroupsWidgetModelProvider(
      child: _GroupsWidgetBody(),
      model: _model,
    );
  }
}

class _GroupsWidgetBody extends StatelessWidget {
  const _GroupsWidgetBody({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Группы'),
        centerTitle: true,
      ),
      body: const SafeArea(
        child: _GroupListWidget(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () =>
            GroupsWidgetModelProvider.read(context)?.model.showForm(context),
      ),
    );
  }
}

class _GroupListWidget extends StatelessWidget {
  const _GroupListWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final groupsCount =
        GroupsWidgetModelProvider.watch(context)?.model.groups.length ?? 0;
    return ListView.separated(
        itemBuilder: (context, index) {
          return _GroupListRowWidget(
            indexInList: index,
          );
        },
        separatorBuilder: ((context, index) {
          return const Divider(
            height: 1,
          );
        }),
        itemCount: groupsCount);
  }
}

class _GroupListRowWidget extends StatelessWidget {
  final int indexInList;
  _GroupListRowWidget({required this.indexInList});

  @override
  Widget build(BuildContext context) {
    final groupList = GroupsWidgetModelProvider.read(context)?.model.groups;
    return Slidable(
      endActionPane: ActionPane(
        extentRatio: 0.3,
        motion: BehindMotion(),
        children: [
          SlidableAction(
            padding: EdgeInsets.symmetric(horizontal: 12),
            onPressed: (context) => GroupsWidgetModelProvider.read(context)
                ?.model
                .deleteGroup(indexInList),
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: ListTile(
        title: Text(groupList![indexInList].name),
        trailing: Icon(Icons.chevron_right),
        onTap: () => GroupsWidgetModelProvider.read(context)
            ?.model
            .showTasks(context, indexInList),
      ),
    );
  }
}
