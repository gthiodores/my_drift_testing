import 'package:drift_testing/database/database.dart';
import 'package:drift_testing/presentation/todos_list_notifier.dart';
import 'package:drift_testing/presentation/widgets/category_filter_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodoListContent extends ConsumerWidget {
  final Function(Todo?)? actionOnTodoSelected;

  const TodoListContent({
    Key? key,
    this.actionOnTodoSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoListNotifier = ref.watch(todoListStateNotifierProvider);
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Column(
          children: [
            CategoryFilterDropDown(onCategorySelected: (category) {
              ref.read(categoryFilterProvider.notifier).state = category;
            }),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  if (index == todoListNotifier.todos.length) {
                    return const SizedBox(height: 56.0 + 16.0);
                  }

                  final item = todoListNotifier.todos[index];
                  return ListTile(
                    title: Text(item.todo.title),
                    subtitle: Text(item.todo.content),
                    trailing: Text(item.category?.description ?? "No Category"),
                    onTap: () {
                      actionOnTodoSelected?.call(item.todo);
                    },
                  );
                },
                itemCount: todoListNotifier.todos.length + 1,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16, right: 16),
          child: FloatingActionButton(
            onPressed: () {
              actionOnTodoSelected?.call(null);
            },
            child: const Icon(Icons.add),
          ),
        )
      ],
    );
  }
}
