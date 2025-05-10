import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import '../bloc/todo_bloc.dart';
import '../model/todo.dart';
import 'add_todo_dailog.dart';

class TodoCard extends StatelessWidget {
  final int index;
  final Todo todo;

  const TodoCard({required this.index, required this.todo, super.key});

  @override
  Widget build(BuildContext context) {
    void removeTodo() => context.read<TodoBloc>().add(RemoveTodo(todo));
    void alterTodo() => context.read<TodoBloc>().add(AlterTodo(index));

    return Card(
      color: const Color(0xFF1B1A1A),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Slidable(
        key: ValueKey(todo.title),
        startActionPane: ActionPane(
          extentRatio: 0.3,
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (_) => removeTodo(),
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
            SlidableAction(
              onPressed: (_) {
                showDialog(
                  context: context,
                  builder: (_) => BlocProvider.value(
                    value: context.read<TodoBloc>(),
                    child: AddTodoDialog(
                      isEdit: true,
                      todo: todo,
                      index: index,
                    ),
                  ),
                );
              },
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Edit',
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        todo.title,
                        style: TextStyle(
                            fontSize: 20, color: Colors.white,
                            fontWeight: FontWeight.bold,
                          decoration: todo.isDone ? TextDecoration.lineThrough : TextDecoration.none,
                          decorationColor: Colors.white,
                          decorationThickness: 2.5,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 4),
                      Text(todo.subtitle,
                          style:  TextStyle(
                              color: Colors.white70,
                            decoration: todo.isDone ? TextDecoration.lineThrough : TextDecoration.none,
                            decorationColor: Colors.white,
                            decorationThickness: 2.5,
                          )),
                      if (todo.dueDate != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          'Due: ${DateFormat('dd MMM yyyy').format(todo.dueDate!)}',
                          style: TextStyle(color: Colors.grey[400], fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ],
                  ),
                ),
                Checkbox(
                  value: todo.isDone,
                  activeColor: Colors.black,
                  onChanged: (_) => alterTodo(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
