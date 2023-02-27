import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../repositories/todo_repo.dart';

part 'delete_todo_event.dart';
part 'delete_todo_state.dart';

class DeleteTodoBloc extends Bloc<DeleteTodoEvent, DeleteTodoState> {
  final TodoRepository todoRepository;
  DeleteTodoBloc(this.todoRepository) : super(DeleteTodoInitial()) {
    on<deleteTodo>((event, emit) async {
      emit(todoDeleting());
      try {
        await todoRepository.deleteTodo(event.todoId);
        emit(todoDeleted());
        emit(DeleteTodoInitial());
      } catch (e) {
        emit(todoDeleteError(e.toString()));
      }
    });
  }
}
