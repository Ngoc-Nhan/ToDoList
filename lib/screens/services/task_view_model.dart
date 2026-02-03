import 'package:flutter/material.dart';
import 'package:todolist/models/task.dart';
import '../models/task.dart';
import 'task_api_service.dart';

class TaskViewModel extends ChangeNotifier {
  List<Task> _tasks = [];
  bool _isLoading = false;
  String? _error;

  List<Task> get tasks => _tasks;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // FETCH - Load tasks from API
  Future<void> fetchTasks() async {
    _isLoading = true;
    notifyListeners();
    try {
      _tasks = await TaskApiService.getTasks();
    } catch (e) {
      _error = 'Error fetching tasks: $e';
      debugPrint(_error);
    }
    _isLoading = false;
    notifyListeners();
  }

  // ADD – yêu cầu II
  Future<bool> addTask(Task task) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final created = await TaskApiService.createTask({
        'title': task.title,
        'description': task.description,
        'status': task.status,
        'priority': task.priority,
      });
      _tasks.add(created);
      return true;
    } catch (e) {
      _error = 'Error creating task: $e';
      debugPrint(_error);
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // UPDATE
  Future<bool> updateTask(Task task) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      if (task.id == null) {
        _error = 'Cannot update task without id';
        return false;
      }

      final updated = await TaskApiService.updateTask(task.id!, {
        'title': task.title,
        'description': task.description,
        'status': task.status,
        'priority': task.priority,
      });
      final idx = _tasks.indexWhere((t) => t.id == updated.id);
      if (idx != -1) _tasks[idx] = updated;
      return true;
    } catch (e) {
      _error = 'Error updating task: $e';
      debugPrint(_error);
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // DELETE (bonus)
  Future<bool> deleteTask(Task task) async {
    _error = null;
    // optimistic remove
    final index = _tasks.indexWhere((t) => t.id == task.id);
    Task? removed;
    if (index != -1) {
      removed = _tasks.removeAt(index);
      notifyListeners();
    }

    try {
      if (task.id != null) {
        await TaskApiService.deleteTask(task.id!);
      } else {
        // local-only task removed already
      }
      return true;
    } catch (e) {
      _error = 'Error deleting task: $e';
      debugPrint(_error);
      // rollback
      if (removed != null) {
        _tasks.insert(index, removed);
        notifyListeners();
      }
      return false;
    }
  }
}
