part of 'update_todo_bloc.dart';

abstract class UpdateTodoState extends Equatable {
  const UpdateTodoState();
}

class UpdateTodoInitial extends UpdateTodoState {
  @override
  List<Object?> get props => [];
}

class todoUpdating extends UpdateTodoState {
  @override
  List<Object> get props => [];
}

class todoUpdated extends UpdateTodoState {
  @override
  List<Object> get props => [];
}

class todoUpdateError extends UpdateTodoState {
  final String error;

  todoUpdateError(this.error);
  @override
  List<Object> get props => [error];
}
