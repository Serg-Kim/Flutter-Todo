import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo/presentation/counter/screens/CounterScreen.dart';
import 'package:flutter_todo/presentation/counter/screens/CounterSubScreen.dart';
import 'package:flutter_todo/presentation/todos/navigation/TodosNavigator.dart';

import '../blocs/todos/todos_bloc.dart';
import '../repositories/todo_repository.dart';

class MainNavigator extends StatefulWidget{
  const MainNavigator({super.key});

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
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
        const CounterScreen(),
        const CounterSubScreen(),
      ][currentPageIndex],
    );
  }
}