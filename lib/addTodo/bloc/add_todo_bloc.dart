import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../repositories/todo_repo.dart';
part 'add_todo_event.dart';
part 'add_todo_state.dart';

class AddTodoBloc extends Bloc<AddTodoEvent, AddTodoState> {
  final TodoRepository todoRepository;
  AddTodoBloc(this.todoRepository) : super(AddTodoInitial()) {
    on<createTodo>((event, emit) async {
      print(event.description.toString());
      emit(todoAdding());
      try {
        await todoRepository.addTodo(event.description.toString());
        emit(todoAdded());
        emit(AddTodoInitial());
      } catch (e) {
        emit(todoAddError(e.toString()));
      }
    });
  }
}
