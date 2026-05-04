import 'package:flutter/material.dart';

import '../data/recipe_store.dart';
import '../models/recipe.dart';
import '../theme/tuscan_theme.dart';
import '../widgets/empty_state.dart';
import '../widgets/tuscan_background.dart';
import 'add_recipe_page.dart';

class ViewRecipesPage extends StatefulWidget {
  const ViewRecipesPage({super.key});

  @override
  State<ViewRecipesPage> createState() => _ViewRecipesPageState();
}

class _ViewRecipesPageState extends State<ViewRecipesPage> {
  void _deleteRecipe(int index) {
    setState(() {
      recipes.removeAt(index);
    });
  }

  Future<void> _editRecipe(Recipe recipe) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => AddRecipePage(recipe: recipe)),
    );

    if (mounted) setState(() {});
  }

  void _addToCart(Recipe recipe) {
    setState(() {
      cart[recipe] = (cart[recipe] ?? 0) + 1;
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('${recipe.name} added to cart.')));
  }

  void _showRecipeDetails(Recipe recipe) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final detailTitleColor = isDark ? TuscanColors.cream : TuscanColors.wine;
    final detailTextColor = isDark ? TuscanColors.cream : TuscanColors.wine;
    final dividerColor = detailTextColor.withValues(
      alpha: isDark ? 0.22 : 0.14,
    );
    final sectionStyle = utilityTextStyle(
      color: detailTextColor,
      fontWeight: FontWeight.w800,
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          recipe.name,
          style: tuscanTextStyle(
            color: detailTitleColor,
            fontWeight: FontWeight.w800,
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Ingredients', style: sectionStyle),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: recipe.ingredients
                    .map(
                      (ingredient) => Chip(
                        label: Text(
                          ingredient,
                          style: utilityTextStyle(color: detailTextColor),
                        ),
                      ),
                    )
                    .toList(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 18),
                child: Divider(color: dividerColor, height: 1),
              ),
              Text('Instructions', style: sectionStyle),
              const SizedBox(height: 6),
              Text(
                recipe.instructions,
                style: utilityTextStyle(color: detailTextColor, height: 1.35),
              ),
              const SizedBox(height: 28),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: detailTextColor,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 14,
                      ),
                      textStyle: utilityTextStyle(fontWeight: FontWeight.w600),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Close'),
                  ),
                  const SizedBox(width: 12),
                  FilledButton.icon(
                    style: isDark
                        ? creamWineButtonStyle()
                        : FilledButton.styleFrom(
                            backgroundColor: TuscanColors.wine,
                            foregroundColor: TuscanColors.linen,
                            textStyle: utilityTextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                    onPressed: () {
                      _addToCart(recipe);
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.shopping_basket),
                    label: const Text('Add to List'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final viewAccent = isDark ? TuscanColors.cream : TuscanColors.wine;

    return TuscanBackground(
      child: Scaffold(
        appBar: AppBar(title: const Text('View Recipes')),
        body: SafeArea(
          child: recipes.isEmpty
              ? EmptyState(
                  icon: Icons.restaurant_menu,
                  title: "No recipes yet — let's add some!",
                  iconColor: viewAccent,
                  showIconBackground: false,
                )
              : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(4, 8, 4, 24),
                  itemCount: recipes.length,
                  itemBuilder: (context, index) {
                    final recipe = recipes[index];

                    return Card(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () => _showRecipeDetails(recipe),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 46,
                                height: 46,
                                child: Icon(
                                  Icons.soup_kitchen,
                                  color: viewAccent,
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      recipe.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            color: viewAccent,
                                            fontWeight: FontWeight.w800,
                                          ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${recipe.ingredients.length} ingredients',
                                      style: utilityTextStyle(
                                        color: viewAccent.withValues(
                                          alpha: isDark ? 1 : 0.72,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                tooltip: 'Edit recipe',
                                icon: Icon(
                                  Icons.edit_outlined,
                                  color: viewAccent,
                                ),
                                onPressed: () => _editRecipe(recipe),
                              ),
                              IconButton(
                                tooltip: 'Delete recipe',
                                icon: Icon(
                                  Icons.delete_outline,
                                  color: viewAccent,
                                ),
                                onPressed: () => _deleteRecipe(index),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
