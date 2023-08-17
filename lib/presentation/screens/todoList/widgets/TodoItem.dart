import 'package:flutter/material.dart';
import '../../../../model/entity/todo.dart';

class TodoItem extends StatelessWidget {
  TodoItem(
      {required this.todo,
        required this.onTodoChanged,
        required this.removeTodo})
      : super(key: ObjectKey(todo));

  final Todo todo;
  final void Function(Todo todo) onTodoChanged;
  final void Function(Todo todo) removeTodo;

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
        onTodoChanged(todo);
      },
      leading: Checkbox(
        checkColor: Colors.white,
        activeColor: Colors.blueAccent,
        value: todo.completed,
        onChanged: (value) {
          onTodoChanged(todo);
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
            removeTodo(todo);
          },
        ),
      ]),
    );
  }
}