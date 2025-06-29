import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/provider/meals_provider.dart';

enum Filters { glutenFree, lactoseFree, vegetarian, vegan }

class FiltersNotifier extends StateNotifier<Map<Filters, bool>> {
  FiltersNotifier()
    : super({
        Filters.glutenFree: false,
        Filters.lactoseFree: false,
        Filters.vegetarian: false,
        Filters.vegan: false,
      });

  void setFilter(Filters filter, bool isActive) {
    state = {...state, filter: isActive};
  }

  void setFilters(Map<Filters, bool> setFilters) {
    state = setFilters;
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filters, bool>>(
      (ref) => FiltersNotifier(),
    );

final filteredMeal = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final currentFilters = ref.watch(filtersProvider);

  return meals.where((meal) {
    //if any category is present in the current meal exclude it,
    if (currentFilters[Filters.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (currentFilters[Filters.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (currentFilters[Filters.vegan]! && !meal.isVegan) {
      return false;
    }
    if (currentFilters[Filters.vegetarian]! && !meal.isVegetarian) {
      return false;
    }
    //if all if statement goes false then this default true
    return true;
  }).toList();
});
