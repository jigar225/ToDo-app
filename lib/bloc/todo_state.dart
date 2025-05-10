part of 'todo_bloc.dart';

enum TodoStatus { initial, loading, success, error }

class TodoState extends Equatable {
  final List<Todo> todos;
  final TodoStatus status;
  final String searchQuery;

  const TodoState({
    this.todos = const <Todo>[],
    this.status = TodoStatus.initial,
    this.searchQuery = "",
  });

  TodoState copyWith({TodoStatus? status, List<Todo>? todos,String? searchQuery}) {
    debugPrint("Search query in copywith :$searchQuery");
    return TodoState(todos: todos ?? this.todos, status: status ?? this.status,searchQuery: searchQuery ?? this.searchQuery);
  }
  List<Todo> get filteredTodos {
    debugPrint("search query is: ${searchQuery}");
    if (searchQuery.isEmpty) return todos;  // If the search query is empty, return the full todo list.
    return todos
        .where((todo) => todo.title.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }

  factory TodoState.fromJson(Map<String,dynamic>json){
    try{
      var listOfTodos = (json['todo'] as List<dynamic>).map((e)=>Todo.fromJson(e as Map<String,dynamic>)).toList();
      return TodoState(
        todos: listOfTodos,
        status: TodoStatus.values.firstWhere((element)=> element.name.toString() == json['status']),
      );
    }catch(e){
      rethrow;
    }
  }
  Map<String,dynamic>toJson(){
   return {
     'todo':todos,
     'status':status.name,
   };
  }
  @override
  List<Object?> get props => [todos,status,searchQuery];
}
