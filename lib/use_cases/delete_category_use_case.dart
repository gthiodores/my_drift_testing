import 'package:drift_testing/database/database.dart';
import 'package:drift_testing/repository/category_repository.dart';

class DeleteCategoryUseCase {
  final CategoryRepository _repository;

  DeleteCategoryUseCase(this._repository);

  Future<void> execute(Category category) async {
    await _repository.deleteCategory(category);
  }
}
