import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/entity/todo.dart';
import '../../repositories/todo_repository.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodoEvent, TodosState> {
  final TodoRepository _todoRepository;

  TodosBloc(this._todoRepository) : super(TodosLoaded()) {
    on<FetchTodos>(_onFetchTodos);
    on<AddTodo>(_onAddTodo);
    on<DeleteTodo>(_onDeleteTodo);
    on<UpdateTodo>(_onUpdateTodo);
    on<CompleteTodo>(_onCompleteTodo);
  }

  Future<void> _onFetchTodos(FetchTodos event, Emitter<TodosState> emit) async {
    emit(TodosLoading());
    try {
      List<Todo> todos = await _todoRepository.getTodos();

      final List<Todo> completedTodos =
          todos.where((e) => e.completed == true).toList();
      final List<Todo> uncompletedTodos =
          todos.where((e) => e.completed == false).toList();

      todos = [...uncompletedTodos, ...completedTodos];

      emit(TodosLoaded(todos: todos));
    } catch (e) {
      emit(TodosError(e.toString()));
    }
  }

  void _onAddTodo(AddTodo event, Emitter<TodosState> emit) {
    final state = this.state;

    if (state is TodosLoaded) {
      emit(TodosLoaded(todos: List.from(state.todos)..insert(0, event.todo)));
    }
  }

  void _onDeleteTodo(DeleteTodo event, Emitter<TodosState> emit) {
    final state = this.state;

    if (state is TodosLoaded) {
      List<Todo> todos = state.todos.where((todo) {
        return todo.id != event.todo.id;
      }).toList();

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

      emit(TodosLoaded(todos: todos));
    }
  }
}
