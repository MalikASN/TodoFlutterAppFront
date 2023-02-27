part of 'delete_todo_bloc.dart';

abstract class DeleteTodoEvent extends Equatable {
  @override
  List<Object> get props => [];
}

// event to delete a todo
class deleteTodo extends DeleteTodoEvent {
  final int todoId;

  deleteTodo(this.todoId);
}
