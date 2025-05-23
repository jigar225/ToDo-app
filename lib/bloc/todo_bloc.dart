import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../model/todo.dart';
part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends HydratedBloc<TodoEvent, TodoState> {
  TodoBloc() : super(const TodoState()) {
    on<TodoStarted>(_onStarted);
    on<AddTodo>(_onAddTodo);
    on<RemoveTodo>(_onRemoveTodo);
    on<AlterTodo>(_onAlterTodo);
    on<SearchQueryChanged>(_onSearchQueryChanged);
    on<ModifyTodo>(_onModifyTodo);
  }
//i used Hydrated bloc to store and get back data of user
  void _onStarted(TodoStarted event, Emitter<TodoState> emit) {
    log("Todo Started");
    log("${state.status}");
    if (state.status == TodoStatus.success || state.todos.isNotEmpty) return;
      emit(state.copyWith(todos: state.todos, status: TodoStatus.success));
  }

  void _onAddTodo(AddTodo event,Emitter<TodoState> emit){
    emit(
      state.copyWith(
        status: TodoStatus.loading,
      ),
    );
    try{
      List<Todo> temp = [];
      temp.addAll(state.todos);
      temp.insert(0, event.todo);
      emit(
        state.copyWith(
          todos: temp,
          status: TodoStatus.success,
        )
      );
    }catch(e){
      emit(
        state.copyWith(
          status: TodoStatus.error,
        )
      );
    }
  }
  void _onRemoveTodo(RemoveTodo event,Emitter<TodoState> emit){
    emit(
      state.copyWith(
        status: TodoStatus.loading,
      ),
    );
    try{
      state.todos.remove(event.todo);
      emit(
          state.copyWith(
            todos:state.todos,
            status: TodoStatus.success,
          )
      );
    }catch(e){
      emit(
          state.copyWith(
            status: TodoStatus.error,
          )
      );
    }
  }

  void _onAlterTodo(AlterTodo event,Emitter<TodoState> emit){
    log("started");
    emit(
      state.copyWith(
        status: TodoStatus.loading,
      ),
    );
    log("goint in try bloc");
    try{
      state.todos[event.index].isDone = !state.todos[event.index].isDone;
      emit(
          state.copyWith(
            todos:state.todos,
            status: TodoStatus.success,
          )
      );
    }catch(e){
      emit(
          state.copyWith(
            status: TodoStatus.error,
          )
      );
    }
    log("completed");
  }

  void _onSearchQueryChanged(SearchQueryChanged event, Emitter<TodoState> emit) {
    emit(state.copyWith(
      searchQuery: event.query.toLowerCase(),
      status: TodoStatus.success,
    ));
  }

  void _onModifyTodo(ModifyTodo event,Emitter<TodoState> emit){
    emit(state.copyWith(status: TodoStatus.loading));
    try{
      List<Todo> updatedTodos = List.from(state.todos);
      updatedTodos[event.index] = event.updatedTodo;
      emit(state.copyWith(todos: updatedTodos, status: TodoStatus.success));
    }catch(e){
      emit(state.copyWith(status: TodoStatus.error));
    }
  }



  @override
  TodoState? fromJson(Map<String, dynamic> json) {
    return TodoState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(TodoState state) {
  return state.toJson();
  }
}
