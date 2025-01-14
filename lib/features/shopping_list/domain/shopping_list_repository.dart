import 'dart:async';

import 'package:isar/isar.dart';

import '../../../db/ingredient.dart';
import '../../../db/isar_factory.dart';
import '../../../db/shopping_list_entry.dart';

class ShoppingListRepository {
  static final ShoppingListRepository _instance =
      ShoppingListRepository._internal();
  late Future<Isar> isarInstance = IsarFactory().db;

  factory ShoppingListRepository() {
    return _instance;
  }

  ShoppingListRepository._internal();

  Future<List<ShoppingListEntry>> getShoppingListEntries() async {
    final db = await isarInstance;
    final shoppingListEntries = await db.shoppingListEntrys.where().findAll();
    return shoppingListEntries;
  }

  Future<ShoppingListEntry> createShoppingListEntry(
      Ingredient ingredient, double count) async {
    final isar = await isarInstance;
    return await isar.writeTxn(() async {
      final shoppingListEntry = ShoppingListEntry()
        ..ingredient.value = ingredient
        ..count = count;
      await isar.shoppingListEntrys.put(shoppingListEntry);
      await shoppingListEntry.ingredient.save();
      return shoppingListEntry;
    });
  }

  void clearShoppingList() async {
    final isar = await isarInstance;

    await isar.writeTxn(() async {
      await isar.shoppingListEntrys.clear();
    });
  }

  Future<void> updateShoppingListEntryById(count, id) async {
    final isar = await isarInstance;
    final item =
        await isar.shoppingListEntrys.where().idEqualTo(id).findFirst();
    if (item != null) {
      item.count = count;
      await isar.writeTxn(() async {
        await isar.shoppingListEntrys.put(item);
      });
    }
  }

  Future<Ingredient> findOrCreateIngredient(
    String name,
    String unit,
    List<Ingredient> existingIngredients,
    Isar isar,
  ) async {
    return await isar.writeTxn(() async {
      Ingredient ingredient = existingIngredients.firstWhere(
          (i) => i.name == name && i.unit == unit,
          orElse: () => Ingredient()
            ..name = name
            ..unit = unit);

      if (ingredient.id == Isar.autoIncrement) {
        await isar.ingredients.put(ingredient);
      }
      return ingredient;
    });
  }

  Future<void> addShoppingListEntry(
      String name, double count, String unit) async {
    final isar = await isarInstance;
    final existingIngredients = await isar.ingredients.where().findAll();
    final ingredient =
        await findOrCreateIngredient(name, unit, existingIngredients, isar);

    return await isar.writeTxn(() async {
      final shoppingListEntry = ShoppingListEntry()
        ..ingredient.value = ingredient
        ..count = count;
      await isar.shoppingListEntrys.put(shoppingListEntry);
      await shoppingListEntry.ingredient.save();
    });
  }

  Future<void> removeEntryFromShoppingList(int id) async {
    final isar = await isarInstance;

    await isar.writeTxn(() async {
      await isar.shoppingListEntrys.delete(id);
    });
  }

  Future<void> addEntryToShoppingList(ShoppingListEntry entry) async {
    final isar = await isarInstance;

    await isar.writeTxn(() async {
      final shoppingListEntry = ShoppingListEntry()
        ..ingredient.value = entry.ingredient.value
        ..count = entry.count;

      shoppingListEntry.ingredient.value =
          entry.ingredient.value; // Setzt die Verknüpfung

      await isar.shoppingListEntrys.put(shoppingListEntry);
      await shoppingListEntry.ingredient.save(); // Speichert die Verknüpfung
    });
  }
}
