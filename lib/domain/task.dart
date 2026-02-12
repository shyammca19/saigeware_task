enum TaskPriority { low, medium, high }
enum TaskFilter { all, completed, pending }

class Task {
  final String id;
  final String title;
  final String? description;
  final DateTime? dueDate;
  final TaskPriority priority;
  final bool isCompleted;

  Task({
    required this.id,
    required this.title,
    this.description,
    this.dueDate,
    required this.priority,
    this.isCompleted = false,
  });

  Task copyWith({
    String? title,
    String? description,
    DateTime? dueDate,
    TaskPriority? priority,
    bool? isCompleted,
  }) {
    return Task(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      priority: priority ?? this.priority,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
