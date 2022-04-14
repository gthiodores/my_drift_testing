import 'package:drift_testing/database/database.dart';

class TodoMasterDetailState {
  final Todo? selectedTodo;
  final bool isEditing;

  TodoMasterDetailState({this.selectedTodo, required this.isEditing});

  TodoMasterDetailState copy({
    Todo? selectedTodo,
    bool? isEditing,
  }) =>
      TodoMasterDetailState(
        selectedTodo: selectedTodo,
        isEditing: isEditing ?? this.isEditing,
      );
}
