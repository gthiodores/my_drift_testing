import 'package:drift/drift.dart' as drift;
import 'package:drift_testing/database/database.dart';
import 'package:drift_testing/injection/usecase_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodoDetailContent extends ConsumerWidget {
  final Todo? todo;
  final Function? onEditDone;

  const TodoDetailContent({
    Key? key,
    this.todo,
    this.onEditDone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final upsert = ref.read(upsertTodoUseCaseProvider);

    return Column(
      children: [
        Text(todo?.title ?? 'No title'),
        ElevatedButton(
          onPressed: () async {
            await upsert.execute(TodosCompanion(
              title: const drift.Value("lorem ipsum"),
              content: const drift.Value("lorem ipsum"),
              created: drift.Value(DateTime.now()),
              category: const drift.Value.absent(),
            ));
            onEditDone?.call();
          },
          child: const Text('Testing'),
        ),
      ],
    );
  }
}
