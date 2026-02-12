import 'package:hive/hive.dart';
import '../domain/task.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String? description;

  @HiveField(3)
  final int priority;

  @HiveField(4)
  final bool isCompleted;

  @HiveField(5)
  final DateTime? dueDate;

  TaskModel({
    required this.id,
    required this.title,
    this.description,
    required this.priority,
    required this.isCompleted,
    this.dueDate,
  });

  // Convert Model → Domain
  Task toEntity() {
    return Task(
      id: id,
      title: title,
      description: description,
      priority: TaskPriority.values[priority],
      isCompleted: isCompleted,
      dueDate: dueDate,
    );
  }

  // Convert Domain → Model
  factory TaskModel.fromEntity(Task task) {
    return TaskModel(
      id: task.id,
      title: task.title,
      description: task.description,
      priority: task.priority.index,
      isCompleted: task.isCompleted,
      dueDate: task.dueDate,
    );
  }
}
