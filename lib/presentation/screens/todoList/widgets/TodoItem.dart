import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../model/entity/todo.dart';
import '../../../../blocs/todos/todos_bloc.dart';

import 'TodoDialog.dart';

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
      onTap: () async {
        String? editedTitle = await TodoDialog.displayDialog(context, false);
        if (editedTitle != null && context.mounted) {
          context.read<TodosBloc>().add(
            UpdateTodo(todo: todo.copyWith(title: editedTitle)),
          );
        }
      },
      leading: Checkbox(
        checkColor: Colors.white,
        activeColor: Colors.blueAccent,
        value: todo.completed,
        onChanged: (value) {
          context.read<TodosBloc>().add(CompleteTodo(todo: todo.copyWith(completed: !todo.completed)));
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
            context.read<TodosBloc>().add(DeleteTodo(todo: todo));
          },
        ),
      ]),
    );
  }
}
