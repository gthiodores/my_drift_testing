import 'package:drift/drift.dart';
import 'package:drift_testing/database/database.dart';
import 'package:drift_testing/injection/usecase_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodoEditRoute extends ConsumerWidget {
  final Todo? todo;

  const TodoEditRoute({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final upsert = ref.read(upsertTodoUseCaseProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Todos"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await upsert.execute(TodosCompanion(
              title: const Value("lorem ipsum"),
              content: const Value("lorem ipsum"),
              created: Value(DateTime.now()),
              category: const Value.absent(),
            ));
            Navigator.pop(context);
          },
          child: const Text('Testing'),
        ),
      ),
    );
  }
}
