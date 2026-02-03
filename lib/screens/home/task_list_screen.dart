import 'package:flutter/material.dart';
import '../../models/task.dart';
import '../services/task_api_service.dart';
import '../detail/task_detail_screen.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  late Future<List<Task>> _tasksFuture;

  @override
  void initState() {
    super.initState();
    _tasksFuture = TaskApiService.getTasks();
  }

  void _reload() {
    setState(() {
      _tasksFuture = TaskApiService.getTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tasks')),
      body: FutureBuilder<List<Task>>(
        future: _tasksFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }

          final tasks = snapshot.data!;

          // EMPTY VIEW
          if (tasks.isEmpty) {
            return const Center(child: Text('No Tasks Yet'));
          }

          // LIST
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  title: Text(task.title),
                  subtitle: Text('Status: ${task.status}'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => TaskDetailScreen(taskId: task.id ?? 0),
                      ),
                    );
                    _reload();
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
