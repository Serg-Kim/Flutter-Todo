import 'package:flutter/material.dart';
import 'package:flutter_todo/blocs/todos/todos_bloc.dart';
import '../../../../model/entity/todo.dart';

class TodoItem extends StatelessWidget {
  TodoItem({required this.todo}) : super(key: ObjectKey(todo));

  final Todo todo;

  TextStyle? _getTextStyle(bool checked) {
    if (!checked) return null;

    return const TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        UpdateTodo(todo: todo);
      },
      leading: Checkbox(
        checkColor: Colors.white,
        activeColor: Colors.blueAccent,
        value: todo.completed,
        onChanged: (value) {
          UpdateTodo(todo: todo);
        },
      ),
      title: Row(children: <Widget>[
        Expanded(
          child: Text(todo.title, style: _getTextStyle(todo.completed)),
        ),
        IconButton(
          iconSize: 30,
          icon: const Icon(
            Icons.delete,
            color: Colors.blueGrey,
          ),
          alignment: Alignment.centerRight,
          onPressed: () {
            DeleteTodo(todo: todo);
          },
        ),
      ]),
    );
  }
}
