import 'package:drift_testing/injection/usecase_module.dart';
import 'package:drift_testing/presentation/widgets/category_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'categories_edit_route.dart';

class CategoryListRoute extends ConsumerWidget {
  CategoryListRoute({Key? key}) : super(key: key);

  final queryProvider = StateProvider<String>((ref) => "");

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredCategoriesStream = ref.watch(
        categoriesLikeDescriptionStreamProvider(ref.watch(queryProvider)));

    return Scaffold(
      appBar: AppBar(title: const Text('Categories')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(label: Text('Filter')),
              maxLines: 1,
              onChanged: (query) {
                ref.read(queryProvider.state).update((state) => query);
              },
            ),
            filteredCategoriesStream.when(
              data: (categories) {
                return Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      if (index == categories.length) {
                        // 56 is the default FAB size, 16 is the padding
                        // amount we want from the FAB
                        return const SizedBox(height: 56.0 + 16.0);
                      }
                      final item = categories[index];
                      return CategoryListItem(category: item);
                    },
                    itemCount: categories.length + 1,
                  ),
                );
              },
              error: (err, stack) {
                return const Center(child: Text('Failed to load data'));
              },
              loading: () {
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              useSafeArea: false,
              context: context,
              builder: (context) {
                return CategoriesEditRoute(category: null);
              });
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
