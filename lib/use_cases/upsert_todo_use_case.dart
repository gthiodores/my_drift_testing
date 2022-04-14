import 'package:drift_testing/database/database.dart';
import 'package:drift_testing/repository/todos_repository.dart';

class UpsertTodoUseCase {
  final TodosRepository _repository;

  UpsertTodoUseCase(this._repository);

  Future<void> execute(TodosCompanion todo) async {
    await _repository.upsertTodo(todo);
  }
}
