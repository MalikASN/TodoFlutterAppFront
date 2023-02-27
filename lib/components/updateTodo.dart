import 'dart:js_util';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/updateTodo/bloc/update_todo_bloc.dart';

import '../bloc/to_do_bloc.dart';
import '../models/ToDo.dart';
import '../repositories/todo_repo.dart';

class UpdateTodo extends HookWidget {
  const UpdateTodo({Key? key, required this.todoz}) : super(key: key);
  final ToDo todoz;

  @override
  Widget build(BuildContext context) {
    final modifier = useState<bool>(false);
    final todo = useState<ToDo>(todoz);
    final TextEditingController descriptionController = TextEditingController();
    descriptionController.text = todo.value.description.toString();
    return RepositoryProvider(
        create: (context) => TodoRepository(),
        child: MultiBlocProvider(
            providers: [
              BlocProvider<UpdateTodoBloc>(
                create: (BuildContext context) => UpdateTodoBloc(
                    RepositoryProvider.of<TodoRepository>(context)),
              ),
              BlocProvider<ToDoBloc>(
                create: (BuildContext context) =>
                    ToDoBloc(RepositoryProvider.of<TodoRepository>(context)),
              ),
            ],
            child: Scaffold(
                appBar: AppBar(title: const Text('go back')),
                body: Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      height: 200.0,
                      child: modifier.value == false
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Description:',
                                        style: TextStyle(fontSize: 18)),
                                    Text(todo.value.description.toString()),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Date de creation:',
                                        style: TextStyle(fontSize: 18)),
                                    Text(todo.value.creationDate.toString()),
                                  ],
                                ),
                                Padding(
                                    padding:
                                        const EdgeInsets.only(top: 10, left: 0),
                                    child: ElevatedButton.icon(
                                        onPressed: () =>
                                            {modifier.value = !modifier.value},
                                        icon: const Icon(Icons.update),
                                        label: const Text('update')))
                              ],
                            )
                          : BlocConsumer<UpdateTodoBloc, UpdateTodoState>(
                              listener: ((context, state) {
                                if (state is todoUpdated) {
                                  todo.value.description =
                                      descriptionController.text;
                                  descriptionController.text = "";
                                  modifier.value = !modifier.value;
                                }
                              }),
                              builder: (context, state) {
                                if (state is UpdateTodoInitial) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text('Description:',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18)),
                                      TextField(
                                        controller: descriptionController,
                                        decoration: const InputDecoration(
                                            labelText: 'Description'),
                                      ),
                                      Container(
                                          margin:
                                              const EdgeInsets.only(top: 15),
                                          child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10, left: 0),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  ElevatedButton.icon(
                                                      onPressed: () {
                                                        if (descriptionController
                                                                .text !=
                                                            '') {
                                                          context
                                                              .read<
                                                                  UpdateTodoBloc>()
                                                              .add(updateTodo(
                                                                  description:
                                                                      descriptionController
                                                                          .text
                                                                          .toString(),
                                                                  todoId: int
                                                                      .parse(todo
                                                                          .value
                                                                          .id
                                                                          .toString())));
                                                        } else {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                                  const SnackBar(
                                                            content: Text(
                                                                "field is empty !"),
                                                            duration: Duration(
                                                                seconds: 2),
                                                          ));
                                                        }
                                                      },
                                                      icon: const Icon(
                                                          Icons.check),
                                                      label: const Text(
                                                          'Confirm')),
                                                  ElevatedButton.icon(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        primary: const Color
                                                                .fromARGB(
                                                            255, 208, 36, 14),
                                                      ),
                                                      onPressed: () {
                                                        modifier.value =
                                                            !modifier.value;
                                                      },
                                                      icon: const Icon(
                                                        Icons.cancel,
                                                      ),
                                                      label:
                                                          const Text('cancel'))
                                                ],
                                              )))
                                    ],
                                  );
                                }
                                if (state is todoUpdating) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }

                                if (state is todoUpdateError) {
                                  return Center(
                                      child: Text(state.error.toString(),
                                          style: const TextStyle(
                                              color: Colors.red)));
                                } else {
                                  return const Text('iuhhuho');
                                }
                              },
                            ),
                    )))));
  }
}
