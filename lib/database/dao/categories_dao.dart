import 'package:drift/drift.dart';
import 'package:drift_testing/database/database.dart';
import 'package:drift_testing/database/tables/categories.dart';

part 'categories_dao.g.dart';

@DriftAccessor(tables: [Categories])
class CategoriesDao extends DatabaseAccessor<TodoDatabase>
    with _$CategoriesDaoMixin {
  CategoriesDao(TodoDatabase database) : super(database);

  Stream<List<Category>> watchAllCategoriesLike(String query) {
    return (select(categories)
          ..where((category) => category.description.like('%$query%')))
        .watch();
  }

  Future deleteCategory(Category category) {
    return categories.deleteOne(category);
  }

  Future upsertCategory(CategoriesCompanion category) {
    return into(categories).insertOnConflictUpdate(category);
  }
}
