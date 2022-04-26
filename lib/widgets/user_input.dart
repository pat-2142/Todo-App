import 'package:flutter/material.dart';
import 'package:flutter_todo_app/models/todo_model.dart';

class UserInput extends StatelessWidget {
  final textController = TextEditingController();
  final Function insertFunction;
  UserInput({required this.insertFunction, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 35, vertical: 1),
      child: Row(
        children: [
          // the input box
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                controller: textController,
                decoration: const InputDecoration(
                  hintText: 'Create a new todo...',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          // this will be the button
          GestureDetector(
            onTap: () {
              // this creates a new todo
              var myTodo = Todo(title: textController.text, isChecked: false);
              insertFunction(myTodo);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 18),
              child: const Text(
                'Add',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
