import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../repositories/todo_repo.dart';
part 'update_todo_event.dart';
part 'update_todo_state.dart';

class UpdateTodoBloc extends Bloc<UpdateTodoEvent, UpdateTodoState> {
  final TodoRepository todoRepository;
  UpdateTodoBloc(this.todoRepository) : super(UpdateTodoInitial()) {
    on<updateTodo>((event, emit) async {
      emit(todoUpdating());
      try {
        await todoRepository.updateTodo(
            description: event.description, todoId: event.todoId);
        emit(todoUpdated());
        emit(UpdateTodoInitial());
      } catch (e) {
        emit(todoUpdateError(e.toString()));
      }
    });
  }
}
