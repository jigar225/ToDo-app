// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_bloc/bloc/todo_bloc.dart';
import 'package:to_do_bloc/widget/add_todo_dailog.dart';
import 'package:to_do_bloc/widget/todo_card.dart';

class HomeScreen extends StatelessWidget {
const HomeScreen({super.key});
  void _showAddDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<TodoBloc>(),
        child: const AddTodoDialog(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Color(0xFF15CD83),
        foregroundColor: Colors.black,
        centerTitle: true,
        title: Text("To-Do List", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocBuilder<TodoBloc, TodoState>(
          builder: (context, state) {
            if (state.status == TodoStatus.success) {
              return ListView.builder(
                itemCount: state.todos.length,
                itemBuilder: (context, i) => TodoCard(index: i, todo: state.todos[i]),
              );
            } else if (state.status == TodoStatus.initial) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Container();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(context),
        shape: CircleBorder(),
        backgroundColor: Color(0xFF15CD83),
        foregroundColor: Colors.black,
        child: Icon(Icons.add),
      ),
    );
  }
}
