import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/TodoDialog.dart';
import 'widgets/TodoItem.dart';

import '../../../../blocs/todos/todos_bloc.dart';
import '../../../../model/entity/todo.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/fonts.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListStateScreen();
}

class _TodoListStateScreen extends State<TodoListScreen> {
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
          actions: [
            IconButton(
              onPressed: () {
                context.read<TodosBloc>().add(const CompleteAllTodo());
                setState(() {});
              },
              icon: const Icon(Icons.checklist),
            ),
            IconButton(
                onPressed: () {
                  context.read<TodosBloc>().add(const DeleteAllTodo());
                },
                icon: const Icon(Icons.delete_forever),
            )
          ],
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
        floatingActionButton:
          FloatingActionButton(
            onPressed: () async {
              String? title = await TodoDialog.displayDialog(context, true);
              if (title != null && mounted) {
                context.read<TodosBloc>().add(
                      AddTodo(todo:
                        Todo(
                          userId: 1,
                          id: Random().nextInt(100),
                          title: title,
                          completed: false,
                        )),
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
        );
  }
}
