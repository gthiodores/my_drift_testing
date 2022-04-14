import 'package:drift_testing/database/database.dart';
import 'package:drift_testing/repository/todos_repository.dart';

class DeleteTodoUseCase {
  final TodosRepository _repository;

  DeleteTodoUseCase(this._repository);

  Future<void> execute(Todo todo) async {
    await _repository.deleteTodo(todo);
  }
}
