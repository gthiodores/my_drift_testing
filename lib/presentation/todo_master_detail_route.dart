import 'package:drift_testing/database/database.dart';
import 'package:drift_testing/presentation/todo_master_detail_notifier.dart';
import 'package:drift_testing/presentation/widgets/todo_detail_content.dart';
import 'package:drift_testing/presentation/widgets/todo_list_content.dart';
import 'package:drift_testing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodoMasterDetailRoute extends ConsumerWidget {
  const TodoMasterDetailRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(todoMasterDetailNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos'),
        leading: _buildActionButton(
          context,
          isEditing: state.isEditing,
          onPressed: () {
            ref.read(todoMasterDetailNotifierProvider.notifier).onEditingDone();
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, CATEGORY_LIST_ROUTE);
            },
            icon: const Icon(Icons.category_outlined),
          ),
        ],
      ),
      body: MediaQuery.of(context).size.width < 600
          ? WillPopScope(
              onWillPop: () async {
                if (state.isEditing) {
                  ref
                      .read(todoMasterDetailNotifierProvider.notifier)
                      .onEditingDone();
                  return false;
                }

                return true;
              },
              child: _buildMobileLayout(
                isEditing: state.isEditing,
                actionOnTodoSelected: (todo) {
                  ref
                      .read(todoMasterDetailNotifierProvider.notifier)
                      .onTodoSelected(todo);
                },
                onEditingDone: ref
                    .read(todoMasterDetailNotifierProvider.notifier)
                    .onEditingDone,
                selectedTodo: state.selectedTodo,
              ),
            )
          : _buildTabletLayout(
              selectedTodo: state.selectedTodo,
              actionOnTodoSelected: (todo) {
                ref
                    .read(todoMasterDetailNotifierProvider.notifier)
                    .onTodoSelected(todo);
              },
              onEditingDone: ref
                  .read(todoMasterDetailNotifierProvider.notifier)
                  .onEditingDone,
            ),
    );
  }

  Widget? _buildActionButton(
    BuildContext context, {
    required bool isEditing,
    required Function onPressed,
  }) {
    if (MediaQuery.of(context).size.width > 600 || !isEditing) {
      return null;
    }

    return IconButton(
      onPressed: () {
        onPressed();
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  Widget _buildMobileLayout({
    required bool isEditing,
    required Function(Todo?) actionOnTodoSelected,
    required Function onEditingDone,
    Todo? selectedTodo,
  }) {
    if (isEditing) {
      return TodoDetailContent(
        todo: selectedTodo,
        onEditDone: onEditingDone,
      );
    }

    return TodoListContent(actionOnTodoSelected: actionOnTodoSelected);
  }

  Widget _buildTabletLayout({
    required Function(Todo?) actionOnTodoSelected,
    required Function onEditingDone,
    Todo? selectedTodo,
  }) {
    return Row(
      children: [
        Flexible(
          child: TodoListContent(actionOnTodoSelected: actionOnTodoSelected),
        ),
        Flexible(
          flex: 2,
          child: TodoDetailContent(
            todo: selectedTodo,
            onEditDone: onEditingDone,
          ),
        ),
      ],
    );
  }
}
