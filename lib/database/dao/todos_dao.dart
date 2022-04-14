import 'package:drift/drift.dart';
import 'package:drift_testing/database/database.dart';
import 'package:drift_testing/database/tables/todos.dart';

part 'todos_dao.g.dart';

@DriftAccessor(tables: [Todos])
class TodosDao extends DatabaseAccessor<TodoDatabase> with _$TodosDaoMixin {
  TodosDao(TodoDatabase db) : super(db);

  Future upsertTodo(TodosCompanion todo) {
    return into(todos).insertOnConflictUpdate(todo);
  }

  Future<void> deleteTodo(Todo todo) {
    return todos.deleteOne(todo);
  }
}
