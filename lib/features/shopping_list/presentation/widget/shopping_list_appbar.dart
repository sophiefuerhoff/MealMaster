import 'package:flutter/material.dart';
import 'package:mealmaster/features/home/presentation/controller/edit_mode_controller.dart';
import 'package:provider/provider.dart';

class ShoppingListAppBar extends StatefulWidget implements PreferredSizeWidget {
  const ShoppingListAppBar({super.key});

  @override
  State<ShoppingListAppBar> createState() => _HomeAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _HomeAppBarState extends State<ShoppingListAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      centerTitle: true,
      title: Text(
        'MealList',
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.white,
            ),
      ),
    );
  }
}
