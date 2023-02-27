// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'to_do_bloc.dart';

@immutable
abstract class ToDoState extends Equatable {}

// fetch states

class todoFetching extends ToDoState {
  @override
  List<Object> get props => [];
}

class todoFetched extends ToDoState {
  final List<ToDo> todoList;
  todoFetched(this.todoList);

  @override
  List<Object> get props => [todoList];
}

class todoFetchError extends ToDoState {
  final String error;

  todoFetchError(this.error);
  @override
  List<Object> get props => [error];
}
