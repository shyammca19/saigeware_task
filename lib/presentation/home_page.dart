import 'package:flutter/material.dart';
import 'package:saigeware_task/presentation/task_form_page.dart';

enum TaskPriority { low, medium, high }

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  final bool _isCompleted = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          ListTile(
            tileColor: Colors.blueGrey[100],
            leading: _isCompleted
                ? Icon(Icons.check_box_outlined)
                : Icon(Icons.check_box_outline_blank_outlined),
            title: Text(
              "new task",
              style: TextStyle(
                decoration: _isCompleted ? TextDecoration.lineThrough : null,
              ),
            ),
            subtitle: Text("description here"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
                Container(
                  height: 10,
                  width: 10,
                  color: _priorityColor(TaskPriority.low),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => TaskFormPage()),
        ),
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }

  Color _priorityColor(TaskPriority p) {
    switch (p) {
      case TaskPriority.high:
        return Colors.red;
      case TaskPriority.medium:
        return Colors.orange;
      case TaskPriority.low:
        return Colors.green;
    }
  }
}
