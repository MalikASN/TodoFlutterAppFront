part of 'delete_todo_bloc.dart';

abstract class DeleteTodoState extends Equatable {
  const DeleteTodoState();
}

class DeleteTodoInitial extends DeleteTodoState {
  @override
  List<Object?> get props => [];
}

class todoDeleting extends DeleteTodoState {
  @override
  List<Object> get props => [];
}

class todoDeleted extends DeleteTodoState {
  @override
  List<Object> get props => [];
}

class todoDeleteError extends DeleteTodoState {
  final String error;

  todoDeleteError(this.error);
  @override
  List<Object> get props => [error];
}
