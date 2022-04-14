import 'package:drift/drift.dart';
import 'package:drift_testing/database/database.dart';
import 'package:drift_testing/database/tables/categories.dart';
import 'package:drift_testing/database/tables/todos.dart';
import 'package:drift_testing/models/todo_with_category.dart';

part 'todos_with_category_dao.g.dart';

@DriftAccessor(tables: [Todos, Categories])
class TodosWithCategoryDao extends DatabaseAccessor<TodoDatabase>
    with _$TodosWithCategoryDaoMixin {
  TodosWithCategoryDao(TodoDatabase database) : super(database);

  Stream<List<TodoWithCategory>> watchTodoWithCategory(Category? category) {
    JoinedSelectStatement query;

    // Adapt the query to the selected category
    if (category == null) {
      query = select(todos).join([
        leftOuterJoin(categories, categories.id.equalsExp(todos.category)),
      ]);
    } else {
      query = select(todos).join([
        leftOuterJoin(categories, categories.id.equalsExp(todos.category)),
      ])
        ..where(todos.category.equals(category.id));
    }

    // Map the stream into ui models before returning it
    return query.watch().map((rows) {
      return rows.map((row) {
        return TodoWithCategory(
          todo: row.readTable(todos),
          category: row.readTableOrNull(categories),
        );
      }).toList();
    });
  }
}
