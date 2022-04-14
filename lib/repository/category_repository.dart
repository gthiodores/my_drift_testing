import 'package:drift_testing/database/dao/categories_dao.dart';
import 'package:drift_testing/database/database.dart';

abstract class CategoryRepository {
  Stream<List<Category>> watchAllCategoriesLike(String query);

  Future<void> upsertCategory(CategoriesCompanion category);

  Future<void> deleteCategory(Category category);
}

class CategoryRepositoryImpl extends CategoryRepository {
  final CategoriesDao _dao;

  CategoryRepositoryImpl(this._dao);

  @override
  Future<void> deleteCategory(Category category) async {
    await _dao.deleteCategory(category);
  }

  @override
  Future<void> upsertCategory(CategoriesCompanion category) async {
    await _dao.upsertCategory(category);
  }

  @override
  Stream<List<Category>> watchAllCategoriesLike(String query) {
    return _dao.watchAllCategoriesLike(query);
  }
}
