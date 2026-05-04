import 'package:flutter/material.dart';

import '../data/recipe_store.dart';
import '../theme/tuscan_theme.dart';
import '../widgets/home_action_card.dart';
import '../widgets/tuscan_background.dart';
import 'add_recipe_page.dart';
import 'shopping_list_page.dart';
import 'view_recipes_page.dart';

class HomePage extends StatefulWidget {
  final bool isDark;
  final VoidCallback toggleTheme;

  const HomePage({super.key, required this.isDark, required this.toggleTheme});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> _openPage(Widget page) async {
    await Navigator.push(context, MaterialPageRoute(builder: (_) => page));

    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final savedRecipeText = recipes.length == 1
        ? '1 saved recipe'
        : '${recipes.length} saved recipes';
    final queuedRecipeCount = cart.values.fold<int>(
      0,
      (total, qty) => total + qty,
    );
    final queuedRecipeText = queuedRecipeCount == 1
        ? '1 recipe queued'
        : '$queuedRecipeCount recipes queued';

    return TuscanBackground(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: IconButton(
                tooltip: widget.isDark
                    ? 'Use light palette'
                    : 'Use evening palette',
                icon: Icon(widget.isDark ? Icons.light_mode : Icons.dark_mode),
                onPressed: widget.toggleTheme,
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'What shall we cook today?',
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(
                                fontWeight: FontWeight.w900,
                                letterSpacing: 0,
                              ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Save recipes, gather ingredients, and plan the next table with a little trattoria warmth.',
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                color: colorScheme.onSurface.withValues(
                                  alpha: 0.72,
                                ),
                                height: 1.35,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 22),
                HomeActionCard(
                  icon: Icons.restaurant_menu,
                  title: 'View Recipes',
                  subtitle: savedRecipeText,
                  accentColor: TuscanColors.terracotta,
                  onTap: () => _openPage(const ViewRecipesPage()),
                ),
                HomeActionCard(
                  icon: Icons.add_circle_outline,
                  title: 'Add Recipe',
                  subtitle: 'Capture a new favorite',
                  accentColor: TuscanColors.olive,
                  onTap: () => _openPage(const AddRecipePage()),
                ),
                HomeActionCard(
                  icon: Icons.shopping_basket,
                  title: 'Shopping List',
                  subtitle: queuedRecipeText,
                  accentColor: TuscanColors.wine,
                  onTap: () => _openPage(const ShoppingListPage()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
