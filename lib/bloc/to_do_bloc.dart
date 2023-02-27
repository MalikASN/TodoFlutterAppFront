import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import '../models/ToDo.dart';
import '../repositories/todo_repo.dart';
part 'to_do_event.dart';
part 'to_do_state.dart';

class ToDoBloc extends Bloc<ToDoEvent, ToDoState> {
  final TodoRepository todoRepository;

  ToDoBloc(this.todoRepository) : super(todoFetching()) {
    on<getTodos>((event, emit) async {
      emit(todoFetching());
      try {
        final todoList = await todoRepository.getToDoList();
        emit(todoFetched(todoList));
        print(state);
      } catch (e) {
        emit(todoFetchError(e.toString()));
      }
    });
  }
}
