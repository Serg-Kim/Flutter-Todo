import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_todo/services/api/todo/todo.dart';
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
  List<Todo> _todos = <Todo>[];
  final TextEditingController _textFieldController = TextEditingController();

  void sortTodos() {
    final List<Todo> completedTodos = _todos.where((e) => e.completed == true).toList();
    final List<Todo> uncompletedTodos = _todos.where((e) => e.completed == false).toList();

    setState(() {
      _todos = [...uncompletedTodos, ...completedTodos];
    });
  }

  void _addTodoItem(String name) {
    setState(() {
      _todos.insert(0, Todo(userId: 1, title: name, completed: false, id: Random().nextInt(100)));
    });
    _textFieldController.clear();
  }

  void _handleTodoChange(Todo todo) {
    final int currentIndex = _todos.indexWhere((element) => element.id == todo.id);
    int completedIndex = _todos.indexWhere((element) => element.completed == true);

    if (completedIndex == -1) completedIndex = _todos.length;

    setState(() {
      todo.completed = !todo.completed;

      if (todo.completed == true) {
        _todos.insert(completedIndex, todo);
       _todos.removeAt(currentIndex);
      } else {
        _todos.removeAt(currentIndex);
        _todos.insert(0, todo);
      }
    });
  }

  void _deleteTodo(Todo todo) {
    setState(() {
      _todos.removeWhere((element) => element.id == todo.id);
    });
  }

  void fetchTodos() async {
    final fetchedTodos = await getTodos();

    setState(() {
      for (var element in fetchedTodos!) {
        _todos.add(element);
      }
    });

    sortTodos();
  }

  @override
  void initState() {
    super.initState();

    fetchTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Todo List', style: FONTS.appBarTitle),
        centerTitle: true,
      ),
      body: _todos.isNotEmpty
          ? (ListView.builder(
        itemCount: _todos.length,
        itemBuilder: (context, index) {
          return TodoItem(
            todo: _todos[index],
            onTodoChanged: _handleTodoChange,
            removeTodo: _deleteTodo,
          );
        },
    ))
      //   padding: const EdgeInsets.symmetric(vertical: 8.0),
      //   }).toList(),
      // ))
          : Center(
          child: Text(
            'List is empty',
            style: FONTS.mediumStyle,
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _displayDialog(),
        tooltip: 'Add Todo',
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        child: Icon(Icons.add, color: COLORS.gray,),
      ),
    );
  }

  Future<void> _displayDialog() async {
    return showDialog<void>(
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
                Navigator.of(context).pop();
                _addTodoItem(_textFieldController.text);
              },
              child: const Text('Add', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}