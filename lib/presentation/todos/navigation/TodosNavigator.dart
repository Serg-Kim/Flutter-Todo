import 'package:flutter/material.dart';
import 'package:flutter_todo/presentation/todos/screens/todoItem/TodoItemScreen.dart';
import 'package:flutter_todo/presentation/todos/screens/todoList/TodoListScreen.dart';

import '../../../model/entity/todo.dart';

class TodosNavigator extends StatelessWidget {
  const TodosNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: 'todos/list',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case 'todos/list':
            builder = (BuildContext context) => const TodoListScreen();
          case 'todos/item':
            builder = (BuildContext context) => TodoItemScreen(todo: settings.arguments as Todo);
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute<void>(builder: builder, settings: settings);
      },
    );
  }
}