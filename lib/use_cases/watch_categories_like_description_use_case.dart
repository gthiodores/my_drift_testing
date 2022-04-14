import 'package:drift_testing/database/database.dart';
import 'package:drift_testing/repository/category_repository.dart';

class WatchCategoriesLikeDescriptionUseCase {
  final CategoryRepository _repository;

  WatchCategoriesLikeDescriptionUseCase(this._repository);

  Stream<List<Category>> execute(String query) {
    return _repository.watchAllCategoriesLike(query);
  }
}
