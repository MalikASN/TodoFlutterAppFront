part of 'update_todo_bloc.dart';

abstract class UpdateTodoEvent extends Equatable {
  @override
  List<Object> get props => [];
}

//event to update a todo
class updateTodo extends UpdateTodoEvent {
  final int todoId;
  final String description;

  updateTodo({
    required this.todoId,
    required this.description,
  });
}
