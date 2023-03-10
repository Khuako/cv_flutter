import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list/db/database.dart';

import '../model/task.dart';

class TaskDetail extends StatefulWidget {
  String? appBarTitle;
  Task? task;
  TaskDetail(this.task, this.appBarTitle);

  @override
  State<TaskDetail> createState() => _TaskDetailState();
}

class _TaskDetailState extends State<TaskDetail> {
  @override
  String? appBarTitle;
  Task? task;
  void initState() {
    // TODO: implement initState
    super.initState();
    appBarTitle = widget.appBarTitle;
    task = widget.task;
  }

  void moveToLastScreen() {
    Navigator.of(context).pop(true);
  }

  void updateTitle() {
    task?.title = titleController?.text;
  }

  void updateDescr() {
    task?.descr = descrController?.text;
  }

  void _save() async {
    moveToLastScreen();
    task?.date = DateFormat.yMMMd().format(DateTime.now());
    int? result;
    if (task?.id != null) {
      result = await DBProvider.db.updateTask(task!);
    } else {
      result = await DBProvider.db
          .insertTask(Task(null, task!.title, task!.descr, task!.date));
    }
    if (result != 0) {
      _showAlertDialog('Status', 'Task Saved Succesfully');
    } else {
      _showAlertDialog('Status', 'A problem occured');
    }
  }

  void _delete() async {
    moveToLastScreen();
    if (task!.id == null) {
      _showAlertDialog('Status', 'No task was deleted');
    }
    int result = await DBProvider.db.deleteTask(task!.id!);
    if (result != 0) {
      _showAlertDialog('Status', 'Task was Removed Succesfully');
    } else {
      _showAlertDialog('Status', 'A problem occured');
    }
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }

  TextEditingController? titleController = TextEditingController();
  TextEditingController? descrController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    titleController?.text = task?.title ?? '';
    descrController?.text = task?.descr ?? '';
    return WillPopScope(
      onWillPop: () {
        moveToLastScreen();
        throw '';
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(appBarTitle ?? 'Add Task'),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              moveToLastScreen();
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 15),
                child: TextField(
                  controller: titleController,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14),
                  onChanged: (value) {
                    updateTitle();
                  },
                  decoration: InputDecoration(
                    labelText: 'Title',
                    labelStyle: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 15),
                child: TextField(
                  controller: descrController,
                  style: const TextStyle(fontSize: 12),
                  onChanged: (value) {
                    updateDescr();
                  },
                  decoration: InputDecoration(
                    labelText: 'Description',
                    labelStyle: const TextStyle(fontSize: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15, bottom: 15),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        child: Text(
                          'SAVE',
                          textScaleFactor: 1.5,
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green),
                        ),
                        onPressed: () {
                          setState(() {
                            _save();
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        child: const Text(
                          'DELETE',
                          textScaleFactor: 1.5,
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red),
                        ),
                        onPressed: () {
                          setState(() {
                            _delete();
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
