import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './components/todolist.dart';
import './repositories/todo_repo.dart';
import './bloc/to_do_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Todo List App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RepositoryProvider(
          create: (context) => TodoRepository(),
          child: Scaffold(
              appBar: AppBar(
                title: Text('Todo App'),
              ),
              body: const todoList())),
    );
  }
}
