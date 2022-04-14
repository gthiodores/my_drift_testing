import 'package:drift_testing/database/database.dart';
import 'package:drift_testing/models/todo_with_category.dart';

class TodosListState {
  List<TodoWithCategory> todos = [];
  Todo? previouslyDeleted;

  TodosListState({
    required this.todos,
    this.previouslyDeleted,
  });

  TodosListState copyWith({
    List<TodoWithCategory>? todos,
    Todo? previouslyDeleted,
  }) =>
      TodosListState(
        todos: todos ?? this.todos,
        previouslyDeleted: previouslyDeleted ?? this.previouslyDeleted,
      );
}
