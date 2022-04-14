import 'package:drift/drift.dart';
import 'package:drift_testing/database/tables/categories.dart';

class Todos extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text().withLength(min: 6, max: 32)();

  TextColumn get content => text()();

  IntColumn get category => integer().nullable().references(
        Categories,
        #id,
        onDelete: KeyAction.setNull,
        onUpdate: KeyAction.cascade,
      )();

  DateTimeColumn get created => dateTime()();
}
