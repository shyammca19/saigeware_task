enum TaskPriority { low, medium, high }

class Task {
  final String id;
  final String title;
  final String? description;
  final TaskPriority priority;
  final bool isCompleted;

  Task({
    required this.id,
    required this.title,
    this.description,
    required this.priority,
    this.isCompleted = false,
  });

  Task copyWith({
    String? title,
    String? description,
    TaskPriority? priority,
    bool? isCompleted,
  }) {
    return Task(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
