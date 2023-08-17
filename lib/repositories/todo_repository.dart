import 'package:dio/dio.dart';
import 'package:flutter_todo/model/entity/todo.dart';

class TodoRepository {
  final String getTodosUrl =
      'https://jsonplaceholder.typicode.com/todos?userId=1';

  final dio = Dio();

  Future<List<Todo>> getTodos() async {
    final response = await dio.get(getTodosUrl);

    if (response.statusCode == 200) {
      return (response.data as List)
          .map((todo) => Todo(
              userId: todo["userId"],
              title: todo["title"],
              completed: todo["completed"],
              id: todo["id"]))
          .toList();
    } else {
      throw Exception("Failed to load todos");
    }
  }
}
