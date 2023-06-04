import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';

class FavNotifier extends StateNotifier<List<Meal>> {
  FavNotifier() : super([]);

  bool toggleMealFavStatus(Meal meal) {
    final mealIsFav = state.contains(meal);

    if (mealIsFav) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favProvider = StateNotifierProvider<FavNotifier, List<Meal>>((ref) {
  return FavNotifier();
});
