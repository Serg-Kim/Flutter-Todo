import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmkv/mmkv.dart';

import '../../model/entity/todo.dart';
import '../../repositories/todo_repository.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodoEvent, TodosState> {
  final TodoRepository _todoRepository;

  var mmkv = MMKV('todos');

  TodosBloc(this._todoRepository) : super(const TodosLoaded()) {
    on<FetchTodos>(_onFetchTodos);
    on<AddTodo>(_onAddTodo);
    on<DeleteTodo>(_onDeleteTodo);
    on<UpdateTodo>(_onUpdateTodo);
    on<CompleteTodo>(_onCompleteTodo);
  }

  Future<void> _onFetchTodos(FetchTodos event, Emitter<TodosState> emit) async {
    emit(TodosLoading());
    try {
      List<Todo> fetchedTodos = await _todoRepository.getTodos();

      List<dynamic> storedTodosFromJSON = [];

      if (mmkv.decodeString('todos').runtimeType == String) {
        storedTodosFromJSON = jsonDecode(mmkv.decodeString('todos')!);
      }

      List<Todo> storedTodos = storedTodosFromJSON
          .map((todo) => Todo(
          userId: todo["userId"],
          title: todo["title"],
          completed: todo["completed"],
          id: todo["id"]))
          .toList();

      Iterable<int> storedTodosIDs = storedTodos.map((todo) {
        return todo.id;
      });

      fetchedTodos = fetchedTodos.where((todo) {
        return !storedTodosIDs.contains(todo.id);
      }).toList();

      List<Todo> todos = [...fetchedTodos, ...storedTodos];

      final List<Todo> completedTodos =
          todos.where((e) => e.completed == true).toList();
      final List<Todo> uncompletedTodos =
          todos.where((e) => e.completed == false).toList();

      todos = [...uncompletedTodos, ...completedTodos];

      // This method for sorting of todos has only iOS specific
      // const channel = MethodChannel('todosChannel');
      // final String todosFromJSON = await channel.invokeMethod('sortTodos', json.encode(todos));
      // List<dynamic> encodedTodos = jsonDecode(todosFromJSON);
      //
      // todos = encodedTodos
      //     .map((todo) => Todo(
      //     userId: todo["userId"],
      //     title: todo["title"],
      //     completed: todo["completed"],
      //     id: todo["id"]))
      //     .toList();

      mmkv.encodeString('todos', json.encode(todos));

      emit(TodosLoaded(todos: todos));
    } catch (e) {
      emit(TodosError(e.toString()));
    }
  }

  void _onAddTodo(AddTodo event, Emitter<TodosState> emit) {
    final state = this.state;

    if (state is TodosLoaded) {
      // This method return todo with title == "New Todo" and hs only iOS specific
      // const channel = MethodChannel('todosChannel');
      // final String todo = await channel.invokeMethod('printNewTodo', json.encode(event.todo));
      // dynamic encodedTodo = jsonDecode(todo);
      //
      // emit(TodosLoaded(todos: List.from(state.todos)..insert(0, Todo.convertFromJson(
      //     id: encodedTodo["id"],
      //     userId: encodedTodo["userId"],
      //     title: encodedTodo["title"],
      //     completed: encodedTodo["completed"])
      // )));

      List<Todo> todos = List.from(state.todos)..insert(0, event.todo);

      mmkv.encodeString('todos', json.encode(todos));

      emit(TodosLoaded(todos: todos));
    }
  }

  void _onDeleteTodo(DeleteTodo event, Emitter<TodosState> emit) {
    final state = this.state;

    if (state is TodosLoaded) {
      List<Todo> todos = state.todos.where((todo) {
        return todo.id != event.todo.id;
      }).toList();

      mmkv.encodeString('todos', json.encode(todos));

      emit(TodosLoaded(todos: todos));
    }
  }

  void _onCompleteTodo(CompleteTodo event, Emitter<TodosState> emit) {
    final state = this.state;

    if (state is TodosLoaded) {
      List<Todo> todos = state.todos;

      final int currentIndex =
          todos.indexWhere((element) => element.id == event.todo.id);
      int completedIndex =
          todos.indexWhere((element) => element.completed == true);

      if (completedIndex == -1) completedIndex = todos.length;

      todos = (state.todos.map((todo) {
        return todo.id == event.todo.id ? event.todo : todo;
      })).toList();

      if (event.todo.completed == true) {
        todos.insert(completedIndex, event.todo);
        todos.removeAt(currentIndex);
      } else {
        todos.removeAt(currentIndex);
        todos.insert(0, event.todo);
      }

      // This method for sorting of todos has only iOS specific
      // const channel = MethodChannel('todosChannel');
      // final String todosFromJSON = await channel.invokeMethod('sortTodos', json.encode(todos));
      // List<dynamic> encodedTodos = jsonDecode(todosFromJSON);
      //
      // todos = encodedTodos
      //     .map((todo) => Todo(
      //     userId: todo["userId"],
      //     title: todo["title"],
      //     completed: todo["completed"],
      //     id: todo["id"]))
      //     .toList();

      mmkv.encodeString('todos', json.encode(todos));

      emit(TodosLoaded(todos: todos));
    }
  }

  void _onUpdateTodo(UpdateTodo event, Emitter<TodosState> emit) {
    final state = this.state;

    if (state is TodosLoaded) {
      List<Todo> todos = state.todos;

      todos = (state.todos.map((todo) {
        return todo.id == event.todo.id ? event.todo : todo;
      })).toList();

      mmkv.encodeString('todos', json.encode(todos));

      emit(TodosLoaded(todos: todos));
    }
  }
}
