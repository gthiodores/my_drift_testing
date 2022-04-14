import 'package:drift_testing/database/database.dart';
import 'package:drift_testing/injection/usecase_module.dart';
import 'package:drift_testing/presentation/todo_master_detail_state.dart';
import 'package:drift_testing/use_cases/delete_todo_use_case.dart';
import 'package:drift_testing/use_cases/upsert_todo_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final todoMasterDetailNotifierProvider = StateNotifierProvider.autoDispose<
    TodoMasterDetailNotifier, TodoMasterDetailState>(
  (ref) => TodoMasterDetailNotifier(
    upsertTodo: ref.read(upsertTodoUseCaseProvider),
    deleteTodo: ref.read(deleteTodoUseCaseProvider),
  ),
);

class TodoMasterDetailNotifier extends StateNotifier<TodoMasterDetailState> {
  final UpsertTodoUseCase upsertTodo;
  final DeleteTodoUseCase deleteTodo;

  TodoMasterDetailNotifier({
    required this.upsertTodo,
    required this.deleteTodo,
  }) : super(TodoMasterDetailState(isEditing: false));

  void onEditingDone() {
    state = state.copy(isEditing: false, selectedTodo: null);
  }

  void onTodoSelected(Todo? todo) {
    state = state.copy(selectedTodo: todo, isEditing: true);
  }
}
