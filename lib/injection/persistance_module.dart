import 'package:drift_testing/database/dao/categories_dao.dart';
import 'package:drift_testing/database/dao/todos_dao.dart';
import 'package:drift_testing/database/dao/todos_with_category_dao.dart';
import 'package:drift_testing/database/database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final databaseProvider = Provider((ref) => TodoDatabase());

final categoriesDaoProvider = Provider((ref) {
  final database = ref.read(databaseProvider);

  return CategoriesDao(database);
});

final todosDaoProvider = Provider((ref) {
  final database = ref.read(databaseProvider);

  return TodosDao(database);
});

final todosWithCategoryProvider = Provider((ref) {
  final database = ref.read(databaseProvider);

  return TodosWithCategoryDao(database);
});
