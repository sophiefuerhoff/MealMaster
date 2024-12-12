import 'package:flutter/material.dart';
import 'package:mealmaster/features/home/presentation/home_screen.dart';
import 'package:mealmaster/features/home/presentation/widgets/home_appbar.dart';
import 'package:mealmaster/features/shopping_list/presentation/shopping_list_screen.dart';
import 'package:mealmaster/features/shopping_list/presentation/widget/shopping_list_appbar.dart';
import 'package:mealmaster/features/user_profile/presentation/profile_screen.dart';
import 'package:mealmaster/features/user_profile/presentation/widgets/profile_appbar.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const ShoppingListScreen(),
    const HomeScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  PreferredSizeWidget? _buildAppBar(BuildContext context) {
    switch (_selectedIndex) {
      case 0:
        return ShoppingListAppBar();
      case 1:
        return null;
      case 2:
        return ProfileAppBar();
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    const double iconSize = 30;

    return Scaffold(
      appBar: _buildAppBar(context),
      body: _pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.shopping_bag_outlined, size: iconSize),
            label: 'Einkaufsliste',
          ),
          NavigationDestination(
            icon: Icon(Icons.home_outlined, size: iconSize),
            label: 'MealPlan',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline, size: iconSize),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
