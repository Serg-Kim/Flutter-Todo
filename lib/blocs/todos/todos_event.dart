part of 'todos_bloc.dart';

@immutable
abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class FetchTodos extends TodoEvent {
  const FetchTodos();

  @override
  List<Object> get props => [];
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

class DeleteAllTodo extends TodoEvent {
  const DeleteAllTodo();

  @override
  List<Object> get props => [];
}

class CompleteAllTodo extends TodoEvent {
  const CompleteAllTodo();

  @override
  List<Object> get props => [];
}
