import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/todos/todos_bloc.dart';
import '../repositories/todo_repository.dart';

import '../presentation/screens/todoList/widgets/TodoList.dart';

import '../utils/constants/colors.dart';

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: COLORS.lightBlue),
        useMaterial3: true,
      ),
      home: RepositoryProvider(
        create: (context) => TodoRepository(),
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (context) => TodosBloc(
                      RepositoryProvider.of<TodoRepository>(context),
                    )..add(const FetchTodos()))
          ],
          child: const TodoList(),
        ),
      ),
    );
  }
}
