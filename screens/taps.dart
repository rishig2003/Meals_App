import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
// import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/meals.dart';
// import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widget/main_drawer.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/favourites_provider.dart';
import 'package:meals_app/providers/filters_provider.dart';

const kInitialFilters = {
  Filter.glutenfree: false,
  Filter.lactosefree: false,
  Filter.vegan: false,
  Filter.vegetarian: false
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String val) async {
    Navigator.of(context).pop();
    if (val == "filters") {
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => const FilterScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filteredMealsProvider);

    Widget activePage = CategoriesScreen(
      availableMeals: availableMeals,
    );
    var activePageTitle = 'Categories';
    if (_selectedPageIndex == 1) {
      final favouriteMeals = ref.watch(favProvider);
      activePage = MealsScreen(
        meals: favouriteMeals,
      );
      activePageTitle = 'Your favourites';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favourites',
          ),
        ],
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
      ),
    );
  }
}
