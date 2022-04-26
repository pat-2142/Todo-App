import 'package:flutter/material.dart';
import 'package:flutter_todo_app/models/db_model.dart';
import 'package:flutter_todo_app/widgets/user_input.dart';
import '../models/todo_model.dart';
import '../widgets/todo_list.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  // this is a database object that allows access to database functions
  var db = DatabaseConnect();

  // this function allows the insertion of Todo items
  void addItem(Todo todo) async {
    await db.insertTodo(todo);
    setState(() {});
  }

  // this function allows the deletion of Todo items
  void deleteItem(Todo todo) async {
    await db.deleteTodo(todo);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TODO'),
      ),
      backgroundColor: const Color(0xFFF5EBFF),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          UserInput(
            insertFunction: addItem,
          ),
          const SizedBox(
            height: 20,
          ),
          Todolist(insertFunction: addItem, deleteFunction: deleteItem),
        ],
      ),
    );
  }
}
