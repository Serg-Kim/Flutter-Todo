import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo/blocs/todos/todos_bloc.dart';
import 'package:flutter_todo/utils/constants/colors.dart';

import '../../../../model/entity/todo.dart';
import '../../../../utils/constants/fonts.dart';
import 'TodoItem.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  late TextEditingController _textFieldController;

  @override
  void initState() {
    super.initState();

    _textFieldController = TextEditingController();
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text('Todo List', style: FONTS.appBarTitle),
          centerTitle: true,
        ),
        body: BlocBuilder<TodosBloc, TodosState>(builder: (context, state) {
          if (state is TodosLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is TodosLoaded) {
            return (ListView.builder(
              itemCount: state.todos.length,
              itemBuilder: (context, index) {
                return TodoItem(
                  todo: state.todos[index],
                );
              },
            ));
          } else {
            return Center(
                child: Text(
              'List is empty',
              style: FONTS.mediumStyle,
            ));
          }
        }),
        floatingActionButton: BlocListener<TodosBloc, TodosState>(
          listener: (context, state) {
            if (state is TodosLoaded) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Todo  updated"),
              ));
            }
          },
          child: FloatingActionButton(
            onPressed: () async {
              Todo? todo = await _displayDialog();
              if (todo != null) {
                context.read<TodosBloc>().add(
                      AddTodo(todo: todo),
                    );
              }
            },
            tooltip: 'Add Todo',
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            child: Icon(
              Icons.add,
              color: COLORS.gray,
            ),
          ),
        ));
  }

  Future<Todo?> _displayDialog() {
    return showDialog<Todo>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add a todo'),
          content: TextField(
            controller: _textFieldController,
            decoration: const InputDecoration(hintText: 'Type your todo'),
            autofocus: true,
          ),
          actions: <Widget>[
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _textFieldController.clear();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(Todo(
                  userId: 1,
                  id: Random().nextInt(100),
                  title: _textFieldController.text,
                  completed: false,
                ));
                _textFieldController.clear();
              },
              child: const Text('Add', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}
