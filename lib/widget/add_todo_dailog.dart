import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/todo_bloc.dart';
import '../model/todo.dart';
import '../utils/date_formatter.dart';

class AddTodoDialog extends StatefulWidget {
  const AddTodoDialog({super.key});

  @override
  State<AddTodoDialog> createState() => _AddTodoDialogState();
}

class _AddTodoDialogState extends State<AddTodoDialog> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  DateTime? _selectedDate;

  void _addTodo() {
    context.read<TodoBloc>().add(AddTodo(
      Todo(
        title: _titleController.text,
        subtitle: _descController.text,
        dueDate: _selectedDate,
      ),
    ));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add a Task"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTextField(_titleController, "Task Title..."),
          const SizedBox(height: 10),
          _buildTextField(_descController, "Description..."),
          const SizedBox(height: 10),
          InkWell(
            onTap: () async {
              DateTime? picked = await showDatePicker(
                context: context,
                initialDate: _selectedDate ?? DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              if (picked != null) setState(() => _selectedDate = picked);
            },
            child: Container(
              width: 500,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.calendar_today, color: Colors.purple),
                  const SizedBox(width: 8),
                  Text(
                    _selectedDate == null ? "Select Due Date" : formatDate(_selectedDate!),
                    style: const TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(5),
          child: TextButton(
            onPressed: _addTodo,
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: const Icon(Icons.check, color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.grey),
        ),
      ),
    );
  }
}
