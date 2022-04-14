import 'package:drift_testing/database/dao/todos_dao.dart';
import 'package:drift_testing/database/dao/todos_with_category_dao.dart';
import 'package:drift_testing/database/database.dart';
import 'package:drift_testing/models/todo_with_category.dart';

abstract class TodosRepository {
  Stream<List<TodoWithCategory>> watchAllTodosInCategory(Category? category);

  Future<void> upsertTodo(TodosCompanion todo);

  Future<void> deleteTodo(Todo todo);
}

class TodoRepositoryImpl extends TodosRepository {
  final TodosWithCategoryDao _todosWithCategoryDao;
  final TodosDao _todosDao;

  TodoRepositoryImpl(this._todosDao, this._todosWithCategoryDao);

  @override
  Future<void> deleteTodo(Todo todo) async {
    await _todosDao.deleteTodo(todo);
  }

  @override
  Future<void> upsertTodo(TodosCompanion todo) async {
    await _todosDao.upsertTodo(todo);
  }

  @override
  Stream<List<TodoWithCategory>> watchAllTodosInCategory(Category? category) {
    return _todosWithCategoryDao.watchTodoWithCategory(category);
  }
}
