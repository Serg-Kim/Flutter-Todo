import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo/presentation/todos/navigators/TodosNavigator.dart';

import '../blocs/todos/todos_bloc.dart';
import '../repositories/todo_repository.dart';

class RootNavigator extends StatefulWidget{
  const RootNavigator({super.key});

  @override
  State<RootNavigator> createState() => _RootNavigatorState();
}

class _RootNavigatorState extends State<RootNavigator> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Theme.of(context).colorScheme.inversePrimary,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.note_alt_outlined),
            icon: Icon(Icons.note_alt_rounded),
            label: 'Todo List',
          ),
          NavigationDestination(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.school),
            icon: Icon(Icons.school_outlined),
            label: 'School',
          ),
        ],
      ),
      body: <Widget>[
        RepositoryProvider(
          create: (context) => TodoRepository(),
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (context) => TodosBloc(
                    RepositoryProvider.of<TodoRepository>(context),
                  )..add(const FetchTodos()))
            ],
            child: const TodosNavigator(),
          ),
        ),
        Container(
          color: Colors.green,
          alignment: Alignment.center,
          child: const Text('Page 2'),
        ),
        Container(
          color: Colors.blue,
          alignment: Alignment.center,
          child: const Text('Page 3'),
        ),
      ][currentPageIndex],
    );
  }
}