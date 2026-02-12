import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saigeware_task/domain/task.dart';
import 'package:saigeware_task/presentation/task_form_page.dart';
import 'package:saigeware_task/presentation/task_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TaskProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
      ),
      body: provider.tasks.isEmpty
          ? const Center(child: Text("No Tasks"))
          : ListView.builder(
              itemCount: provider.tasks.length,
              itemBuilder: (context, index) {
                final task = provider.tasks[index];
                return Dismissible(
                  key: Key(task.id),
                  onDismissed: (_) => provider.deleteTask(task.id),
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 20),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 8,
                    ),
                    child: ListTile(
                      tileColor: Colors.blueGrey[100],
                      leading: Checkbox(
                        value: task.isCompleted,
                        onChanged: (_) => provider.markTask(task),
                      ),
                      title: Text(
                        task.title,
                        style: TextStyle(
                          decoration: task.isCompleted
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                      subtitle:
                          task.description != null &&
                              task.description!.isNotEmpty
                          ? Text(task.description!)
                          : null,
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => TaskFormPage(task: task),
                              ),
                            ),
                            color: Colors.blueGrey,
                            icon: Icon(Icons.edit),
                          ),
                          SizedBox(width: 10),
                          Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: _priorityColor(task.priority),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
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
