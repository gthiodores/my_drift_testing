import 'package:drift_testing/database/database.dart';
import 'package:drift_testing/injection/repository_module.dart';
import 'package:drift_testing/use_cases/delete_category_use_case.dart';
import 'package:drift_testing/use_cases/delete_todo_use_case.dart';
import 'package:drift_testing/use_cases/upsert_category_use_case.dart';
import 'package:drift_testing/use_cases/upsert_todo_use_case.dart';
import 'package:drift_testing/use_cases/watch_categories_like_description_use_case.dart';
import 'package:drift_testing/use_cases/watch_todos_in_category_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final watchTodosInCategoryUseCaseProvider = Provider.autoDispose((ref) {
  final repository = ref.read(todosRepositoryProvider);
  return WatchTodosInCategoryUseCase(repository);
});

final deleteTodoUseCaseProvider = Provider.autoDispose((ref) {
  final repository = ref.read(todosRepositoryProvider);
  return DeleteTodoUseCase(repository);
});

final upsertTodoUseCaseProvider = Provider.autoDispose((ref) {
  final repository = ref.read(todosRepositoryProvider);
  return UpsertTodoUseCase(repository);
});

final watchCategoriesLikeDescriptionUseCaseProvider =
    Provider.autoDispose((ref) {
  final repository = ref.read(categoryRepositoryProvider);
  return WatchCategoriesLikeDescriptionUseCase(repository);
});

final deleteCategoryUseCaseProvider = Provider.autoDispose((ref) {
  final repository = ref.read(categoryRepositoryProvider);
  return DeleteCategoryUseCase(repository);
});

final upsertCategoryUseCaseProvider = Provider.autoDispose((ref) {
  final repository = ref.read(categoryRepositoryProvider);
  return UpsertCategoryUseCase(repository);
});

final categoriesLikeDescriptionStreamProvider =
    StreamProvider.family.autoDispose<List<Category>, String>((ref, query) {
  final usecase = ref.read(watchCategoriesLikeDescriptionUseCaseProvider);
  return usecase.execute(query);
});
