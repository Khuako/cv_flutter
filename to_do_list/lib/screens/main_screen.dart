import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_list/screens/task_detail.dart';

import '../db/database.dart';
import '../model/task.dart';

class MainToDoScreen extends StatefulWidget {
  const MainToDoScreen({super.key});

  @override
  State<MainToDoScreen> createState() => _MainToDoScreenState();
}

class _MainToDoScreenState extends State<MainToDoScreen> {
  Future<List<Task>>? _tasksList;
  void updateListView() {
    setState(() {
      _tasksList = DBProvider.db.getTaskList();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateListView();
  }

  getFirstLetter(String? title) {
    return title!.substring(0, 1);
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _delete(BuildContext context, Task task) async {
    int result = await DBProvider.db.deleteTask(task.id!);
    if (result != null) {
      _showSnackBar(context, 'Task was succesfully deleted');
      updateListView();
    }
  }

  void navigateToDetail(Task? task, String title) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return TaskDetail(task, title);
    }));
    updateListView();
  }

  Widget getTaskListView(Future<List<Task>>? taskList) {
    return FutureBuilder(
      future: taskList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              final taskData = snapshot.data;
              return Card(
                color: Colors.white,
                elevation: 2,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.amber,
                    child: Text(
                      getFirstLetter(taskData![index].title),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  title: Text(
                    taskData[index].title!,
                    maxLines: 1,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    taskData[index].descr!,
                    maxLines: 1,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        child: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onTap: () {
                          _delete(context, taskData[index]);
                        },
                      ),
                    ],
                  ),
                  onTap: () {
                    navigateToDetail(taskData[index], 'Edit Todo');
                  },
                ),
              );
            },
          );
        } else if (snapshot.data?.length == 0 || snapshot.data == null) {
          return Text('No Data Found');
        } else
          return CircularProgressIndicator();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ToDo'),
        centerTitle: true,
      ),
      body: getTaskListView(_tasksList),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add Todo',
        child: Icon(Icons.add),
        onPressed: () {
          navigateToDetail(Task(null, null, null, null), 'Add Todo');
        },
      ),
    );
  }
}
