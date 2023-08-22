import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo/utils/constants/colors.dart';
import 'package:flutter_todo/utils/constants/fonts.dart';

import '../../../../blocs/todos/todos_bloc.dart';
import '../../../../model/entity/todo.dart';
import '../todoList/widgets/TodoDialog.dart';

class TodoItemScreen extends StatefulWidget {
  TodoItemScreen({required this.todo}) : super(key: ObjectKey(todo));

  final Todo todo;

  @override
  State<TodoItemScreen> createState() => _TodoItemStateScreen();
}

class _TodoItemStateScreen extends State<TodoItemScreen> {
  late Todo todo;

  void toggleTodo() {
    setState(() {
      todo.completed = !todo.completed;
    });
  }

  void updateTitle(String title) {
    setState(() {
      todo.title = title;
    });
  }

  @override
  void initState() {
    super.initState();

    todo = widget.todo;
  }

  @override
  Widget build(BuildContext context) {
    final String completeButtonText = todo.completed == true ? 'Uncomplete Todo' : 'Complete Todo';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Todo', style: FONTS.appBarTitle),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
        child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            height: 220,
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            // color: Theme.of(context).colorScheme.outlineVariant,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              color: Theme.of(context).colorScheme.outlineVariant,
              image: const DecorationImage(
                image: NetworkImage('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(todo.title, style: TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                decoration: todo.completed == true ? TextDecoration.lineThrough : null,
                color: COLORS.white,
            )),
           ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary
                  ),
                  onPressed: () async {
                    String? editedTitle = await TodoDialog.displayDialog(context, false);
                    if (editedTitle != null && context.mounted) {
                      context.read<TodosBloc>().add(
                        UpdateTodo(todo: todo.copyWith(title: editedTitle)),
                      );
                      updateTitle(editedTitle);
                    }
                  },
                  child: Text('Edit Todo', style: TextStyle(color: COLORS.white)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: todo.completed == true ? Colors.amber : Colors.green
                  ),
                  onPressed: () {
                    context.read<TodosBloc>().add(CompleteTodo(todo: todo.copyWith(completed: !todo.completed)));
                    toggleTodo();
                    },
                  child: Text(completeButtonText, style: TextStyle(color: COLORS.white)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red
                  ),
                  onPressed: () {
                    context.read<TodosBloc>().add(DeleteTodo(todo: todo));
                    Navigator.pop(context);
                  },
                  child: Text('Delete Todo', style: TextStyle(color: COLORS.white)),
                ),
              ],
            ),
          ),
          ),
        ],
        ),
      ),
    ),
    );
  }
}