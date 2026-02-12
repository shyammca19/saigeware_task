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
  //List<Task> get tasks => _tasks;
  TaskFilter _filter = TaskFilter.all;
  TaskFilter get filter => _filter;

  void loadTasks() {
    _tasks = box.values.map((task) => task.toEntity()).toList();
    //print(_tasks);
    notifyListeners();
  }

  void setFilter(TaskFilter filter) {
    _filter = filter;
    loadTasks();
  }

  List<Task> get filteredTasks {
    switch (_filter) {
      case TaskFilter.completed:
        return _tasks.where((t) => t.isCompleted).toList();
      case TaskFilter.pending:
        return _tasks.where((t) => !t.isCompleted).toList();
      case TaskFilter.all:
        return _tasks;
    }
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
    DateTime? dueDate,
    required TaskPriority priority,
  }) {
    return Task(
      id: const Uuid().v4(),
      title: title,
      description: description,
      dueDate: dueDate,
      priority: priority,
    );
  }
}
