import 'dart:async';

import 'package:drift_testing/database/database.dart';
import 'package:drift_testing/injection/usecase_module.dart';
import 'package:drift_testing/models/todo_with_category.dart';
import 'package:drift_testing/presentation/todos_list_state.dart';
import 'package:drift_testing/use_cases/upsert_todo_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../use_cases/delete_todo_use_case.dart';

final categoryFilterProvider =
    StateProvider.autoDispose<Category?>((ref) => null);

final todosStreamProvider = StreamProvider.family
    .autoDispose<List<TodoWithCategory>, Category?>((ref, category) {
  final useCase = ref.read(watchTodosInCategoryUseCaseProvider);
  return useCase.execute(category);
});

final todoListStateNotifierProvider =
    StateNotifierProvider.autoDispose<TodosListStateNotifier, TodosListState>(
        (ref) {
  final deleteTodoUseCase = ref.read(deleteTodoUseCaseProvider);
  final upsertTodoUseCase = ref.read(upsertTodoUseCaseProvider);
  final stateNotifier = TodosListStateNotifier(
    deleteTodo: deleteTodoUseCase,
    upsertTodo: upsertTodoUseCase,
  );

  final selectedCategory = ref.watch(categoryFilterProvider);
  final todosStream = ref.watch(todosStreamProvider(selectedCategory));

  todosStream.when(
    data: (data) {
      stateNotifier.onListItemChanged(data);
    },
    error: (error, stack) {
      stateNotifier.onListItemChanged(null);
    },
    loading: () {
      stateNotifier.onListItemChanged(null);
    },
  );

  return stateNotifier;
});

class TodosListStateNotifier extends StateNotifier<TodosListState> {
  final DeleteTodoUseCase deleteTodo;
  final UpsertTodoUseCase upsertTodo;

  TodosListStateNotifier({
    required this.deleteTodo,
    required this.upsertTodo,
  }) : super(TodosListState(todos: []));

  void onListItemChanged(List<TodoWithCategory>? todos) {
    state = state.copyWith(todos: todos);
  }

  Future<void> onDeleteTodo(Todo todo) async {
    state = state.copyWith(previouslyDeleted: todo);
    await deleteTodo.execute(todo);
  }

  // Handles snack bar cancel delete
  Future<void> onRestoreTodo() async {
    if (state.previouslyDeleted == null) {
      return;
    }

    await upsertTodo.execute(state.previouslyDeleted!.toCompanion(true));
  }
}
