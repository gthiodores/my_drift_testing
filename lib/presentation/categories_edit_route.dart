import 'package:drift/drift.dart' as drift;
import 'package:drift_testing/database/database.dart';
import 'package:drift_testing/injection/usecase_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoriesEditRoute extends ConsumerWidget {
  final Category? category;

  final textFieldProvider = StateProvider.autoDispose<String>((ref) => '');

  CategoriesEditRoute({Key? key, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final description = ref.watch(textFieldProvider);
    final upsert = ref.read(upsertCategoryUseCaseProvider);

    return Dialog(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextFormField(
                initialValue: category?.description ?? '',
                onChanged: (desc) {
                  ref.read(textFieldProvider.state).update((state) => desc);
                },
                decoration: const InputDecoration(
                  label: Text('Description'),
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  await upsert.execute(
                    CategoriesCompanion(
                      description: drift.Value(description),
                      id: category == null
                          ? const drift.Value.absent()
                          : drift.Value(category!.id),
                    ),
                  );
                  Navigator.pop(context);
                },
                child: Text(category == null ? 'Create' : 'Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
