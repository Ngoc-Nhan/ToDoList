import 'package:flutter/material.dart';
import 'package:http/http.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import 'package:todolist/screens/services/task_view_model.dart';
import '../models/task.dart';
import '../services/task_view_model.dart';

class AddTaskScreen extends StatelessWidget {
  AddTaskScreen({super.key});

  final titleController = TextEditingController();
  final descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final vm = context.read<TaskViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('Add Task')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: descController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                vm.addTask(
                  Task(
                    title: titleController.text,
                    description: descController.text,
                    status: 'pending',
                    priority: 'normal',
                  ),
                );
                Navigator.pop(context);
              },
              child: const Text('Add'),
            )
          ],
        ),
      ),
    );
  }
}
