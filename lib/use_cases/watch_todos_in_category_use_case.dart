import 'package:drift_testing/database/database.dart';
import 'package:drift_testing/models/todo_with_category.dart';
import 'package:drift_testing/repository/todos_repository.dart';

class WatchTodosInCategoryUseCase {
  final TodosRepository _repository;

  WatchTodosInCategoryUseCase(this._repository);

  Stream<List<TodoWithCategory>> execute(Category? category) {
    return _repository.watchAllTodosInCategory(category);
  }
}
