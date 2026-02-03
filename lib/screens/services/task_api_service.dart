import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/task.dart';

class TaskApiService {
  static const baseUrl = 'https://amock.io/api/researchUTH';

  // ===== GET LIST =====
  static Future<List<Task>> getTasks() async {
    final res = await http.get(Uri.parse('$baseUrl/tasks'));

    if (res.statusCode == 200) {
      final decoded = jsonDecode(res.body);
      final List list = decoded['data']; // đúng format amock
      return list.map((e) => Task.fromJson(e)).toList();
    } else {
      throw Exception('Load tasks failed');
    }
  }

  // ===== GET DETAIL =====
  static Future<Task> getTaskDetail(int id) async {
    final res = await http.get(Uri.parse('$baseUrl/task/$id'));

    if (res.statusCode == 200) {
      final decoded = jsonDecode(res.body);
      return Task.fromJson(decoded['data']);
    } else {
      throw Exception('Load detail failed');
    }
  }

  // ===== DELETE (MOCK) =====
  static Future<void> deleteTask(int id) async {
    final res = await http.delete(
      Uri.parse('$baseUrl/task/$id'),
    );

    // amock thường KHÔNG xóa thật → chỉ check cho đúng luồng
    if (res.statusCode != 200 && res.statusCode != 204) {
      throw Exception('Delete failed');
    }
  }

  // ===== CREATE =====
  static Future<Task> createTask(Map<String, dynamic> data) async {
    final res = await http.post(
      Uri.parse('$baseUrl/task'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'data': data}),
    );

    if (res.statusCode == 200 || res.statusCode == 201) {
      final decoded = jsonDecode(res.body);
      return Task.fromJson(decoded['data']);
    } else {
      throw Exception('Create failed');
    }
  }

  // ===== UPDATE =====
  static Future<Task> updateTask(int id, Map<String, dynamic> data) async {
    final res = await http.put(
      Uri.parse('$baseUrl/task/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'data': data}),
    );

    if (res.statusCode == 200) {
      final decoded = jsonDecode(res.body);
      return Task.fromJson(decoded['data']);
    } else {
      throw Exception('Update failed');
    }
  }
}
