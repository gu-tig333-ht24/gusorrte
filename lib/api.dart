import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/task.dart';

class ApiService {
  static const String baseUrl = 'https://todoapp-api.apps.k8s.gu.se';
  static const String apiKey = '8324884c-e84e-40a1-a193-ee8776ee4f3a';

  ApiService();

  Future<List<Task>> getTodos() async {
    final response = await http.get(Uri.parse('$baseUrl/todos?key=$apiKey'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((json) => Task.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load todos');
    }
  }

  Future<List<Task>> addTodo(Task task) async {
    final response = await http.post(
      Uri.parse('$baseUrl/todos?key=$apiKey'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(task.toJson()),
    );
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((json) => Task.fromJson(json)).toList();
    } else {
      throw Exception('Failed to add todo');
    }
  }

  Future<void> updateTodo(Task task) async {
    final response = await http.put(
      Uri.parse('$baseUrl/todos/${task.id}?key=$apiKey'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(task.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update todo');
    }
  }

  Future<void> deleteTodo(String id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/todos/$id?key=$apiKey'),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to delete todo');
    }
  }
}
