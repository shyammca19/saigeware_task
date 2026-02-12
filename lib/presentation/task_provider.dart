import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:saigeware_task/data/task_model.dart';
import 'package:saigeware_task/domain/task.dart';
import 'package:uuid/uuid.dart';

class TaskProvider extends ChangeNotifier {
  final Box<TaskModel> box;

  TaskProvider(this.box) {
    loadTasks();
  }

  List<Task> _tasks = [];
  List<Task> get tasks => _tasks;

  void loadTasks() {
    _tasks = box.values.map((task) => task.toEntity()).toList();
    //print(_tasks);
    notifyListeners();
  }

  void addTask(Task task) {
    box.put(task.id, TaskModel.fromEntity(task));
    //print(box.get(task.id));
    loadTasks();
  }

  void updateTask(Task task) {
    box.put(task.id, TaskModel.fromEntity(task));
    loadTasks();
  }

  void markTask(Task task) {
    updateTask(task.copyWith(isCompleted: !task.isCompleted));
  }

  void deleteTask(String id) {
    box.delete(id);
    loadTasks();
  }

  Task createTask({
    required String title,
    String? description,
    required TaskPriority priority,
  }) {
    return Task(
      id: const Uuid().v4(),
      title: title,
      description: description,
      priority: priority,
    );
  }
}
