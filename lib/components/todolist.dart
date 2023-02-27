import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_app/repositories/todo_repo.dart';

import '../addTodo/bloc/add_todo_bloc.dart';
import '../bloc/to_do_bloc.dart';
import '../deleteTodo/bloc/delete_todo_bloc.dart';
import '../models/ToDo.dart';
import '../updateTodo/bloc/update_todo_bloc.dart';
import './addTodo.dart';
import './updateTodo.dart';

class todoList extends StatefulWidget {
  const todoList({super.key});

  @override
  State<todoList> createState() => _todoListState();
}

class _todoListState extends State<todoList> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<ToDoBloc>(
            create: (BuildContext context) => ToDoBloc(
              RepositoryProvider.of<TodoRepository>(context),
            )..add(getTodos()),
          ),
          BlocProvider<AddTodoBloc>(
              create: (BuildContext context) => AddTodoBloc(
                    RepositoryProvider.of<TodoRepository>(context),
                  )),
          BlocProvider<DeleteTodoBloc>(
            create: (BuildContext context) =>
                DeleteTodoBloc(RepositoryProvider.of<TodoRepository>(context)),
          ),
        ],
        child: Scaffold(
            floatingActionButton: AddTodo(),
            body: BlocBuilder<ToDoBloc, ToDoState>(
              builder: (context, state) {
                final cxt = context;
                if (state is todoFetching) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is todoFetchError) {
                  return Center(child: Text(state.error));
                }

                if (state is todoFetched) {
                  List todoList = state.todoList;
                  return Center(
                    child: ListView.builder(
                      itemCount: state.todoList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                            onTap: (() => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          UpdateTodo(todoz: todoList[index])),
                                )),
                            key: Key(state.todoList[index].toString()),
                            title: Text(todoList[index].description.toString()),
                            subtitle:
                                Text(todoList[index].creationDate.toString()),
                            trailing:
                                BlocConsumer<DeleteTodoBloc, DeleteTodoState>(
                                    listener: (context, state) {
                              if (state is todoDeleted) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Todo deleted"),
                                  duration: Duration(seconds: 2),
                                ));

                                refresh(context);
                              }
                            }, builder: (context, state) {
                              if (state is DeleteTodoInitial) {
                                return FloatingActionButton(
                                    heroTag: '${todoList[index].id}',
                                    // ignore: avoid_print
                                    onPressed: () {
                                      context.read<DeleteTodoBloc>().add(
                                          deleteTodo(
                                              int.parse(todoList[index].id)));
                                    },
                                    child: const Icon(Icons.delete));
                              } else if (state is todoDeleting) {
                                return const CircularProgressIndicator();
                              } else if (state is todoDeleteError) {
                                return Text(state.error);
                              }

                              return Container();
                            }));
                      },
                    ),
                  );
                }
                return const Center(child: Text('default'));
              },
            )));
  }
}

void delete(BuildContext cxt) async {
  await DeleteTodoBloc(RepositoryProvider.of<TodoRepository>(cxt))
    ..add(deleteTodo(1));
}

refresh(BuildContext cxt) {
  cxt.read<ToDoBloc>().add(getTodos());
}
