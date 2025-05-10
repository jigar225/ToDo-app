part of 'todo_bloc.dart';

 sealed class TodoEvent extends Equatable {
   const TodoEvent();
   @override
   List<Object?> get props => [];
 }

class TodoStarted extends TodoEvent{

}

class AddTodo extends TodoEvent{
final Todo todo;
const AddTodo(this.todo);
@override
List<Object?> get props => [todo];
}

class RemoveTodo extends TodoEvent{
   final Todo todo;
   const RemoveTodo(this.todo);
   @override
   List<Object?> get props => [todo];
}

class AlterTodo extends TodoEvent{
  final int index;
  const AlterTodo(this.index);
  @override
  List<Object?> get props => [index];
}

class SearchQueryChanged extends TodoEvent {
  final String query;
  const SearchQueryChanged(this.query);

  @override
  List<Object?> get props => [query];
}

class ModifyTodo extends TodoEvent {
  final int index;
  final Todo updatedTodo;

  const ModifyTodo({required this.index, required this.updatedTodo});

  @override
  List<Object?> get props => [index, updatedTodo];
}
