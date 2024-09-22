import 'package:flutter/material.dart';
import '../models/task.dart';
import '../widgets/app_bar_design.dart';
import 'todos_add.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Task> _taskList = [];
  String _filterOption = 'All';

  @override
  Widget build(BuildContext context) {
    List<Task> filteredTaskList;

    if (_filterOption == 'All') {
      filteredTaskList = _taskList;
    } else if (_filterOption == 'Done') {
      filteredTaskList = _taskList.where((task) => task.taskFinished).toList();
    } else if (_filterOption == 'Undone') {
      filteredTaskList = _taskList.where((task) => !task.taskFinished).toList();
    } else {
      filteredTaskList = _taskList;
    }

    return Scaffold(
      appBar: AppBarDesign(
        actions: [
          PopupMenuButton<String>(
            onSelected: (String value) {
              setState(() {
                _filterOption = value;
              });
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<String>(
                  value: 'All',
                  child: Text("All"),
                ),
                const PopupMenuItem<String>(
                  value: 'Done',
                  child: Text("Done"),
                ),
                const PopupMenuItem<String>(
                  value: 'Undone',
                  child: Text("Undone"),
                ),
              ];
            },
          ),
        ],
      ),
      body: ListView.separated(
        itemCount: filteredTaskList.length,
        itemBuilder: (context, index) {
          final task = filteredTaskList[index];
          return ListTile(
            leading: Checkbox(
              value: task.taskFinished,
              onChanged: (bool? value) {
                setState(() {
                  task.taskFinished = value ?? false;
                });
              },
              activeColor: Theme.of(context).colorScheme.secondary,
            ),
            title: Text(
              task.input,
              style: TextStyle(
                fontSize: 20,
                decoration:
                    task.taskFinished ? TextDecoration.lineThrough : null,
              ),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                setState(() {
                  _taskList.remove(task);
                });
              },
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            color: Theme.of(context).dividerColor,
            thickness: 1,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newTaskInput = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TodosAdd()),
          );

          if (newTaskInput != null) {
            setState(() {
              _taskList.add(Task(input: newTaskInput));
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
