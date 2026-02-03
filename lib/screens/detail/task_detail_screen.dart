import 'package:flutter/material.dart';
import '../../models/task.dart';
import '../services/task_api_service.dart';

class TaskDetailScreen extends StatelessWidget {
  final int taskId;

  const TaskDetailScreen({super.key, required this.taskId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Detail', style: TextStyle(color: Colors.black)),
        iconTheme: const IconThemeData(color: Colors.blue),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.orange),
            onPressed: () async {
              await TaskApiService.deleteTask(taskId);
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: FutureBuilder<Task>(
        future: TaskApiService.getTaskDetail(taskId),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Error loading detail'));
          }

          final task = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(task.title,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(task.description,
                    style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.pink.shade200,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _infoChip(Icons.widgets, 'Work'),
                      _infoChip(Icons.list_alt_outlined, task.status),
                      _infoChip(Icons.flag, task.priority),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                const Text('Subtasks',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                _subTaskItem('This task is related to Fitness.'),
                _subTaskItem('It needs to be completed.'),
                const SizedBox(height: 24),
                const Text('Attachments',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.attach_file),
                      SizedBox(width: 8),
                      Text('document_1_0.pdf'),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

Widget _infoChip(IconData icon, String text) {
  return Container(
    // padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    // decoration: BoxDecoration(
    //   color: Colors.grey.shade200,
    //   borderRadius: BorderRadius.circular(12),
    // ),
    child: Row(
      children: [
        Icon(icon, size: 16),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(fontSize: 12)),
      ],
    ),
  );
}

Widget _subTaskItem(String text) {
  return Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [
        Checkbox(value: false, onChanged: (_) {}),
        Expanded(child: Text(text)),
      ],
    ),
  );
}
