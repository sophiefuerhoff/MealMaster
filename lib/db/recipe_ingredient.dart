import 'package:isar/isar.dart';
import 'package:mealmaster/db/recipe.dart';

import 'base/db_entry.dart';
import 'ingredient.dart';

part 'recipe_ingredient.g.dart';

@collection
class RecipeIngredient extends DbEntry {
  double? count;

  final recipe = IsarLink<Recipe>();

  @Backlink(to: 'recipeIngredients')
  final ingredient = IsarLink<Ingredient>();
}
