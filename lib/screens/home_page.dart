import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../task_provider.dart';
import '../models/task.dart';
import '../widgets/app_bar_design.dart';
import 'todos_add.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _filterOption = 'All';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TaskProvider>(context, listen: false).fetchTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
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
                const PopupMenuItem(value: 'All', child: Text("All")),
                const PopupMenuItem(value: 'Done', child: Text("Done")),
                const PopupMenuItem(value: 'Undone', child: Text("Undone")),
              ];
            },
          ),
        ],
      ),
      body: Consumer<TaskProvider>(
        builder: (context, taskProvider, child) {
          List<Task> filteredTaskList = _filterOption == 'All'
              ? taskProvider.taskList
              : taskProvider.taskList.where((task) {
                  return _filterOption == 'Done' ? task.done : !task.done;
                }).toList();

          return ListView.separated(
            itemCount: filteredTaskList.length,
            itemBuilder: (context, index) {
              final task = filteredTaskList[index];
              return ListTile(
                leading: Checkbox(
                  value: task.done,
                  onChanged: (bool? value) {
                    final updatedTask = Task(
                      id: task.id,
                      title: task.title,
                      done: value ?? false,
                    );
                    taskProvider.updateTask(updatedTask);
                  },
                  activeColor: Theme.of(context).colorScheme.secondary,
                ),
                title: Text(
                  task.title,
                  style: TextStyle(
                    fontSize: 20,
                    decoration: task.done ? TextDecoration.lineThrough : null,
                  ),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    taskProvider.deleteTask(task);
                  },
                ),
              );
            },
            separatorBuilder: (context, index) => Divider(
              color: Theme.of(context).dividerColor,
              thickness: 1,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newTaskTitle = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TodosAdd()),
          );
          if (newTaskTitle != null) {
            final newTask = Task(title: newTaskTitle);
            Provider.of<TaskProvider>(context, listen: false).addTask(newTask);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
