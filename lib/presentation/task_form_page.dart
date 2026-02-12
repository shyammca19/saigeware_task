import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saigeware_task/domain/task.dart';
import 'package:saigeware_task/presentation/task_provider.dart';

class TaskFormPage extends StatefulWidget {
  final Task? task;
  const TaskFormPage({super.key, this.task});

  @override
  State<TaskFormPage> createState() {
    return _TaskFormPageState();
  }
}

class _TaskFormPageState extends State<TaskFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  TaskPriority _priority = TaskPriority.medium;
  DateTime? _dueDate;

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _titleController.text = widget.task!.title;
      _descController.text = widget.task!.description ?? '';
      _priority = widget.task!.priority;
      _dueDate = widget.task!.dueDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<TaskProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task == null ? "Create Task" : "Edit Task"),
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Task Title'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _descController,
                decoration: InputDecoration(labelText: 'Task Description'),
              ),
              SizedBox(height: 20),
              DropdownButtonFormField(
                initialValue: _priority,
                items: TaskPriority.values
                    .map((e) => DropdownMenuItem(value: e, child: Text(e.name)))
                    .toList(),
                onChanged: (value) => _priority = value!,
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _dueDate == null
                          ? 'No due date selected'
                          : 'Due: ${_dueDate!.toLocal().toString().split(' ')[0]}',
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: _dueDate ?? DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) {
                        //print(picked);
                        setState(() {
                          _dueDate = picked;
                        });
                      }
                    },
                    child: const Text('Pick Date'),
                  ),
                ],
              ),
              SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final task = widget.task == null
                        ? provider.createTask(
                            title: _titleController.text,
                            description: _descController.text,
                            priority: _priority,
                            dueDate: _dueDate,
                          )
                        : widget.task!.copyWith(
                            title: _titleController.text,
                            description: _descController.text,
                            priority: _priority,
                            dueDate: _dueDate,
                          );
                    widget.task == null
                        ? provider.addTask(task)
                        : provider.updateTask(task);
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                  foregroundColor: Colors.white,
                  elevation: 5,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                child: Text(
                  "SAVE",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
