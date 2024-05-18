import 'package:flutter/material.dart';

class TasksProvider with ChangeNotifier {
  final List<String> _tasks = [];
  final List<String> _completedTasks = [];

  List<String> get completedTasks => _completedTasks;
  List<String> get tasks => _tasks;

  void addTask(String task) {
    _tasks.add(task);
    notifyListeners();
  }

  void deleteTask(int index) {
    _tasks.removeAt(index);
    notifyListeners();
  }

  void addTaskToCompleted(String task) {
    _completedTasks.add(task);
    notifyListeners();
  }

  void deleteTaskFromCompleted(int index) {
    _completedTasks.removeAt(index);
    notifyListeners();
  }
}
