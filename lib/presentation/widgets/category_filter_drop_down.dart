import 'package:drift_testing/database/database.dart';
import 'package:drift_testing/injection/usecase_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoriesFilterDropDownStateProvider = StateNotifierProvider.autoDispose<
    CategoryFilterDropDownStateNotifier, CategoryFilterDropDownState>((ref) {
  final state = CategoryFilterDropDownStateNotifier();
  final stream = ref.watch(categoriesLikeDescriptionStreamProvider(""));

  stream.when(
    data: (data) {
      final List<Category?> mappedData = [null];
      mappedData.addAll(data);
      state.onValuesChanged(mappedData);
    },
    error: (err, stack) {
      state.onValuesChanged([null]);
    },
    loading: () {
      state.onValuesChanged([null]);
    },
  );

  return state;
});

class CategoryFilterDropDownState {
  final Category? value;
  final List<Category?> items;

  CategoryFilterDropDownState({
    this.value,
    this.items = const [null],
  });

  CategoryFilterDropDownState copy({
    Category? value,
    List<Category?>? items,
  }) =>
      CategoryFilterDropDownState(
        value: value,
        items: items ?? this.items,
      );
}

class CategoryFilterDropDownStateNotifier
    extends StateNotifier<CategoryFilterDropDownState> {
  CategoryFilterDropDownStateNotifier() : super(CategoryFilterDropDownState());

  void onCategorySelectedChanged(Category? category) {
    state = state.copy(value: category);
  }

  void onValuesChanged(List<Category?> categories) {
    state = state.copy(value: state.value, items: categories);
  }
}

class CategoryFilterDropDown extends ConsumerWidget {
  final Function(Category?) onCategorySelected;

  const CategoryFilterDropDown({
    Key? key,
    required this.onCategorySelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(categoriesFilterDropDownStateProvider);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Filter By Category'),
          DropdownButton<Category?>(
            isExpanded: true,
            items: state.items.map<DropdownMenuItem<Category?>>((category) {
              return DropdownMenuItem(
                child: Text(category?.description ?? "All Category"),
                value: category,
              );
            }).toList(),
            value: state.value,
            onChanged: (Category? newValue) {
              ref
                  .read(categoriesFilterDropDownStateProvider.notifier)
                  .onCategorySelectedChanged(newValue);
              onCategorySelected(newValue);
            },
          ),
        ],
      ),
    );
  }
}
