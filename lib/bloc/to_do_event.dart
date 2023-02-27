// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'to_do_bloc.dart';

@immutable
abstract class ToDoEvent extends Equatable {
  @override
  List<Object> get props => [];
}

// event to fetch todos
class getTodos extends ToDoEvent {}
