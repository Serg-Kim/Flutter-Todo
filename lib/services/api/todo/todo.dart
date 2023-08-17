import 'package:dio/dio.dart';
import 'package:flutter_todo/model/entity/todo.dart';

const getTodosUrl = 'https://jsonplaceholder.typicode.com/todos?userId=1';

  final dio = Dio();

  Future<List<Todo>> getTodos() async {
    final response = await dio.get(getTodosUrl);
    final List<dynamic> data = response.data;
    final List<Todo> todos = data.map((e) => Todo(userId: e["userId"], title: e["title"], completed: e["completed"], id: e["id"])).toList();

    return todos;
  }
