import 'package:drift_testing/database/database.dart';
import 'package:drift_testing/injection/usecase_module.dart';
import 'package:drift_testing/presentation/categories_edit_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryListItem extends ConsumerWidget {
  final Category category;

  const CategoryListItem({Key? key, required this.category}) : super(key: key);

  void _onTapListItem(BuildContext context, Category? category) {
    showDialog(
      context: context,
      builder: (context) {
        return CategoriesEditRoute(category: category);
      },
      useSafeArea: false,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dismissible(
      key: Key(category.id.toString()),
      onDismissed: (_) async {
        ref.read(deleteCategoryUseCaseProvider).execute(category);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Deleted ${category.description}'),
          ),
        );
      },
      child: ListTile(
        title: Text(category.description),
        onTap: () {
          _onTapListItem(context, category);
        },
      ),
    );
  }
}
