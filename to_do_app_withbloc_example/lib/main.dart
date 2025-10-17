import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app_withbloc_example/cubit/todo_cubit.dart';
import 'package:to_do_app_withbloc_example/cubit/todo_userform.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter ToDo with BLoC',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: BlocProvider(
        create: (context) => TodoCubit(),
        child: const MyHomePage(title: 'My Daily ToDo'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.withValues(alpha: 0.7),
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white, size: 30),
            onPressed: () {
              final todoCubit = context.read<TodoCubit>(); //  Safe call
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: todoCubit,
                    child: const TodoUserform(),
                  ),
                ),
              );
            },
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: BlocBuilder<TodoCubit, TodoInitial>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: state.todos.length,
            itemBuilder: (_, index) {
              return Card(
                elevation: 3,
                child: ListTile(
                  title: Text(state.todos[index]),
                  trailing: IconButton(
                    onPressed: () =>
                        BlocProvider.of<TodoCubit>(context).deleteTodo(index),
                    icon: const Icon(Icons.remove, color: Colors.red),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
