import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:todo_app/bloc/to_do_bloc.dart';
import '../models/ToDo.dart';

class TodoRepository {
// method to get a list of todos
  final client = Dio();
  Future<List<ToDo>> getToDoList() async {
    String endpoint = "http://localhost:8080/rest/api/getAllTodos";

    final response = await client.get(endpoint);
    // print(response);
    if (response.statusCode == 200) {
      // final List result = jsonDecode(response.data);
      // print(result);
      return response.data.map<ToDo>(((todo) => ToDo.fromJson(todo))).toList();
    } else {
      throw Exception(response.statusMessage);
    }
  }

// method to add a todo

  Future<void> addTodo(String description) async {
    String endpoint = "http://localhost:8080/rest/api/addTodo";

    var response = await client.post(endpoint,
        options: Options(
          headers: {"content-type": "application/json"},
        ),
        data: jsonEncode(<String, String>{
          'description': description,
        }));
    if (response.statusCode != 201) {
      throw Exception(response.statusMessage);
    }
  }

// method to update a todo

  Future<void> updateTodo(
      {required int todoId, required String description}) async {
    String endpoint = "http://localhost:8080/rest/api/updateTodo";

    var response = await client
        .put(endpoint, data: {'id': todoId, 'description': description});

    if (response.statusCode != 201) {
      throw Exception(response.statusMessage);
    }
  }

// method to delete a todo

  Future<void> deleteTodo(int todoId) async {
    String endpoint = "http://localhost:8080/rest/api/DeleteTodo/${todoId}";
    var response = await client.put(endpoint);
    if (response.statusCode != 200) {
      throw Exception(response.statusMessage);
    }
  }
}
