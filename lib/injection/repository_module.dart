import 'package:drift_testing/injection/persistance_module.dart';
import 'package:drift_testing/repository/category_repository.dart';
import 'package:drift_testing/repository/todos_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final todosRepositoryProvider = Provider((ref) {
  final todosDao = ref.read(todosDaoProvider);
  final todosWithCategoryDao = ref.read(todosWithCategoryProvider);

  return TodoRepositoryImpl(todosDao, todosWithCategoryDao);
});

final categoryRepositoryProvider = Provider((ref) {
  final categoriesDao = ref.read(categoriesDaoProvider);

  return CategoryRepositoryImpl(categoriesDao);
});
