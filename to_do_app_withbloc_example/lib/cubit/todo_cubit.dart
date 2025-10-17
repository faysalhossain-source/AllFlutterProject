import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'todo_state.dart';

class Todo {
  static List<String> data = [
    'Flutter UI design complete করো',
    'Expense app-এর date picker ঠিক করো',
    'pubspec.yaml এ Roboto font add করো',
    'Firebase integration শেখো',
    'Animated button effect implement করো',
    'BLoC pattern practice করো',
    'Poem viewer app-এর Bengali localization polish করো',
    'Emulator storage optimize করো',
    'CV update করে internship apply করো',
    'VS Code extension error fix করো',
  ];
}

class TodoCubit extends Cubit<TodoInitial> {
  TodoCubit() : super(TodoInitial(todos: List.from(Todo.data)));

  addNewTodo(String todo) {
    if (todo.trim().isEmpty) return; // empty input handle
    final todoList = List<String>.from(state.todos);
    todoList.add(todo);
    emit(TodoInitial(todos: todoList));
  }

  deleteTodo(int index) {
    final todoList = List<String>.from(state.todos);
    todoList.removeAt(index);
    emit(TodoInitial(todos: todoList));
  }
}
