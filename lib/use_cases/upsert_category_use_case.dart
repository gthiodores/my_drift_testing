import 'package:drift_testing/database/database.dart';
import 'package:drift_testing/repository/category_repository.dart';

class UpsertCategoryUseCase {
  final CategoryRepository _repository;

  UpsertCategoryUseCase(this._repository);

  Future<void> execute(CategoriesCompanion category) async {
    await _repository.upsertCategory(category);
  }
}
