import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_app/repositories/todo_repo.dart';
import '../addTodo/bloc/add_todo_bloc.dart';
import '../bloc/to_do_bloc.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({super.key});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Icon(Icons.add),
      autofocus: false,
      onPressed: () {
        _create();
      },
    );
  }

  refresh() {
    context.read<ToDoBloc>().add(getTodos());
  }

  void _create() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (modal) {
          return BlocProvider.value(
              value: BlocProvider.of<AddTodoBloc>(context),
              child: Padding(
                padding: EdgeInsets.only(
                    top: 20,
                    left: 20,
                    right: 20,
                    bottom: MediaQuery.of(modal).viewInsets.bottom + 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 17),
                      child: Text('Ajouter un todo',
                          style: TextStyle(
                            fontSize: 18,
                          )),
                    ),
                    TextField(
                      controller: _descriptionController,
                      decoration:
                          const InputDecoration(labelText: 'Description'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    BlocConsumer<AddTodoBloc, AddTodoState>(
                      listener: ((context, state) {
                        if (state is todoAdded) {
                          Navigator.of(context).pop();
                          refresh();
                          // context.read<ToDoBloc>().add(getTodos());

                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Todo added successfully !"),
                            duration: Duration(seconds: 2),
                          ));
                        }
                      }),
                      builder: (context, state) {
                        if (state is AddTodoInitial) {
                          return ElevatedButton(
                            child: const Text('Ajouter'),
                            onPressed: () {
                              final String description =
                                  _descriptionController.text;

                              // ignore: unnecessary_null_comparison

                              context
                                  .read<AddTodoBloc>()
                                  .add(createTodo(description));
                              _descriptionController.text = '';
                            },
                          );
                        }

                        if (state is todoAdding) {
                          return const CircularProgressIndicator();
                        }

                        if (state is todoAddError) {
                          return Row(
                            children: [
                              ElevatedButton(
                                child: const Text('Ajouter'),
                                onPressed: () async {
                                  final String description =
                                      _descriptionController.text;

                                  if (_descriptionController != null) {
                                    context
                                        .read<AddTodoBloc>()
                                        .add(createTodo(description));
                                    _descriptionController.text = '';

                                    Navigator.of(context).pop();
                                  }
                                },
                              ),
                              Text(state.error.toString(),
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 198, 49, 11)))
                            ],
                          );
                        }

                        return Container();
                      },
                    )
                  ],
                ),
              ));
          // return Text('efew');
          // throw Exception();
        });
  }
}
