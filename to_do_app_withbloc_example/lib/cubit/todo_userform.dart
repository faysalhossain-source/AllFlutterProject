import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app_withbloc_example/cubit/todo_cubit.dart';

class TodoUserform extends StatefulWidget {
  const TodoUserform({super.key});

  @override
  State<TodoUserform> createState() => _TodoUserformState();
}

class _TodoUserformState extends State<TodoUserform> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add your new ToDo',
          style: TextStyle(color: Color(0xffFFFFFF)),
        ),
        backgroundColor: Colors.deepPurple,
        actions: const [
          Icon(Icons.task_alt, color: Colors.white),
          SizedBox(width: 12),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Enter new ToDo",
              ),
            ),
          ),
          SizedBox(
            width: 350,
            child: ElevatedButton(
              onPressed: () {
                BlocProvider.of<TodoCubit>(
                  context,
                ).addNewTodo(_controller.text);
                _controller.clear();
                Navigator.pop(context); // go back to main list
              },
              child: const Text('Add New ToDo'),
            ),
          ),
        ],
      ),
    );
  }
}
