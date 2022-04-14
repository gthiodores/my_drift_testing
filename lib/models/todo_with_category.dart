import 'package:drift_testing/database/database.dart';

class TodoWithCategory {
  final Todo todo;
  final Category? category;

  TodoWithCategory({required this.todo, this.category});
}
