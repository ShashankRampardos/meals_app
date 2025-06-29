import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/provider/favorites_provider.dart';

import 'package:meals_app/screens/categorys.dart';
import 'package:meals_app/screens/filters_screen.dart';

import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';
import 'package:meals_app/provider/filters_provider.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(
      context,
    ).pop(); //go on category screen by only popping the side drawer

    if (identifier == 'filters') {
      //else go to the filter screen
      Navigator.of(context).push<Map<Filters, bool>>(
        PageRouteBuilder(
          opaque: false,
          barrierColor: Colors.black.withAlpha(150), // optional background dim
          pageBuilder: (_, __, ___) => const FiltersScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filteredMeal);

    Widget activePage = CategoriesScreen(
      availableMeals: availableMeals,
    ); //by default _selectedPageIndex is 0
    String activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(meals: ref.read(favoriteMealsProvider));
      activePageTitle = 'Your Favourate';
    }

    return Scaffold(
      appBar: AppBar(title: Text(activePageTitle)),
      drawer: MainDrawer(onSetScreen: _setScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: (index) {
          _selectPage(index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dining_sharp),
            label: 'Categories',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
      ),
    );
  }
}
