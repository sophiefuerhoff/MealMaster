import 'package:isar/isar.dart';

import 'base/db_entry.dart';
import 'ingredient.dart';

part 'shopping_list_entry.g.dart';

@collection
class ShoppingListEntry extends DbEntry {
  double? count;

  final ingredient = IsarLink<Ingredient>();
}
