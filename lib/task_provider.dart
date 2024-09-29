import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import '../models/task.dart';
import '../api.dart';

class TaskProvider extends ChangeNotifier {
  final ApiService apiService = ApiService();
  List<Task> _taskList = [];

  List<Task> get taskList => _taskList;

  var logger = Logger();

  TaskProvider();

  Future<void> fetchTasks() async {
    try {
      _taskList = await apiService.getTodos();
      notifyListeners();
    } catch (e) {
      logger.e('Error fetching tasks', e);
    }
  }

  Future<void> addTask(Task task) async {
    try {
      _taskList = await apiService.addTodo(task);
      notifyListeners();
    } catch (e) {
      logger.e('Error adding task', e);
    }
  }

  Future<void> updateTask(Task task) async {
    try {
      await apiService.updateTodo(task);
      int index = _taskList.indexWhere((t) => t.id == task.id);
      if (index != -1) {
        _taskList[index] = task;
        notifyListeners();
      }
    } catch (e) {
      logger.e('Error updating task', e);
    }
  }

  Future<void> deleteTask(Task task) async {
    try {
      await apiService.deleteTodo(task.id!);
      _taskList.removeWhere((t) => t.id == task.id);
      notifyListeners();
    } catch (e) {
      logger.e('Error deleting task', e);
    }
  }
}
