part of 'todos_bloc.dart';

@immutable
abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class FetchTodos extends TodoEvent {
  final List<Todo> todos;

  const FetchTodos({this.todos = const <Todo>[]});

  @override
  List<Object> get props => [todos];
}

class SortTodos extends TodoEvent {
  final List<Todo> todos;

  const SortTodos({this.todos = const <Todo>[]});

  @override
  List<Object> get props => [todos];
}

class AddTodo extends TodoEvent {
  final Todo todo;

  const AddTodo({required this.todo});

  @override
  List<Object> get props => [todo];
}

class UpdateTodo extends TodoEvent {
  final Todo todo;

  const UpdateTodo({required this.todo});

  @override
  List<Object> get props => [todo];
}

class CompleteTodo extends TodoEvent {
  final Todo todo;

  const CompleteTodo({required this.todo});

  @override
  List<Object> get props => [todo];
}

class DeleteTodo extends TodoEvent {
  final Todo todo;

  const DeleteTodo({required this.todo});

  @override
  List<Object> get props => [todo];
}
