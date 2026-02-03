import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/screens/services/task_view_model.dart';
import '../models/task.dart';
import '../services/task_view_model.dart';
import './detail/task_detail_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final taskVM = context.watch<TaskViewModel>();
    final tasks = taskVM.tasks;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: _buildAppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
        child: const Icon(Icons.add),
      ),
      body: taskVM.isLoading
          ? const Center(child: CircularProgressIndicator())
          : tasks.isEmpty
              ? _buildEmptyView()
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    return _buildTaskCard(context, tasks[index]);
                  },
                ),
    );
  }

  // ===== Empty View =====
  Widget _buildEmptyView() {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.inbox, size: 90, color: Colors.grey),
          SizedBox(height: 12),
          Text(
            'No Tasks Yet',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  // ===== Task Card =====
  Widget _buildTaskCard(BuildContext context, Task task) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => TaskDetailScreen(taskId: task.id ?? 0),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _getTaskColor(task.status),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Checkbox(value: false, onChanged: (_) {}),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(task.description),
                  const SizedBox(height: 6),
                  Text(
                    'Status: ${task.status}',
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // ===== AppBar =====
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: const Text(
        'SmartTasks',
        style: TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Color _getTaskColor(String status) {
    switch (status.toLowerCase()) {
      case 'in progress':
        return Colors.red.shade100;
      case 'pending':
        return Colors.yellow.shade100;
      default:
        return Colors.blue.shade100;
    }
  }
}
