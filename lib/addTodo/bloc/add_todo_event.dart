part of 'add_todo_bloc.dart';

abstract class AddTodoEvent extends Equatable {
  const AddTodoEvent();

  @override
  List<Object> get props => [];
}

//event to create a new todo
class createTodo extends AddTodoEvent {
  final String description;

  createTodo(this.description);
}
