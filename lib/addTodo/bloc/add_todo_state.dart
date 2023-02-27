part of 'add_todo_bloc.dart';

abstract class AddTodoState extends Equatable {
  const AddTodoState();

  @override
  List<Object> get props => [];
}

class AddTodoInitial extends AddTodoState {}

class todoAdding extends AddTodoState {
  @override
  List<Object> get props => [];
}

class todoAdded extends AddTodoState {
  @override
  List<Object> get props => [];
}

class todoAddError extends AddTodoState {
  final String error;

  todoAddError(this.error);
  @override
  List<Object> get props => [error];
}
