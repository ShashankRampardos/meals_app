import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/widgets/filter_switch_tile.dart';
import 'package:meals_app/provider/filters_provider.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentFilters = ref.watch(filtersProvider);
    final filtersModifier = ref.watch(filtersProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.black.withAlpha(150),
      appBar: AppBar(title: const Text('Your filters')),
      body: Column(
        children: [
          FilterSwitchTile(
            title: 'Gluten-free',
            subtitle: 'Only include gluten-free meals.',
            value: currentFilters[Filters.glutenFree]!,
            onChanged: (newVal) {
              filtersModifier.setFilter(Filters.glutenFree, newVal);
            },
          ),
          FilterSwitchTile(
            title: 'Lactose-free',
            subtitle: 'Only include lactose-free meals.',
            value: currentFilters[Filters.lactoseFree]!,
            onChanged: (newVal) {
              filtersModifier.setFilter(Filters.lactoseFree, newVal);
            },
          ),
          FilterSwitchTile(
            title: 'Vegetarian',
            subtitle: 'Only include vegetarian meals.',
            value: currentFilters[Filters.vegetarian]!,
            onChanged: (newVal) {
              filtersModifier.setFilter(Filters.vegetarian, newVal);
            },
          ),
          FilterSwitchTile(
            title: 'Vegan',
            subtitle: 'Only include vegan meals.',
            value: currentFilters[Filters.vegan]!,
            onChanged: (newVal) {
              filtersModifier.setFilter(Filters.vegan, newVal);
            },
          ),
        ],
      ),
    );
  }
}
