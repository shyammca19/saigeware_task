import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:saigeware_task/data/task_model.dart';
import 'package:saigeware_task/domain/task.dart';
import 'package:uuid/uuid.dart';

class TaskProvider extends ChangeNotifier {
  final Box<TaskModel> box;

  TaskProvider(this.box) {}

  void addTask(Task task) {
    box.put(task.id, TaskModel.fromEntity(task));
    //print(box.get(task.id));
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
