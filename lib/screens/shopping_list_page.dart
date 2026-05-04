import 'package:flutter/material.dart';

import '../data/recipe_store.dart';
import '../models/recipe.dart';
import '../theme/tuscan_theme.dart';
import '../widgets/empty_state.dart';
import '../widgets/tuscan_background.dart';

class ShoppingListPage extends StatefulWidget {
  const ShoppingListPage({super.key});

  @override
  State<ShoppingListPage> createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  void _increment(Recipe recipe) {
    setState(() {
      cart[recipe] = (cart[recipe] ?? 0) + 1;
    });
  }

  void _decrement(Recipe recipe) {
    setState(() {
      if (cart[recipe] == null) return;

      if (cart[recipe]! > 1) {
        cart[recipe] = cart[recipe]! - 1;
      } else {
        cart.remove(recipe);
      }
    });
  }

  void _generateShoppingList() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final shoppingForeground = isDark ? TuscanColors.cream : TuscanColors.wine;
    final allIngredients = <String>[];

    cart.forEach((recipe, qty) {
      for (int i = 0; i < qty; i++) {
        allIngredients.addAll(recipe.ingredients);
      }
    });

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Shopping List',
          style: tuscanTextStyle(color: shoppingForeground),
        ),
        content: SingleChildScrollView(
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: allIngredients
                .map(
                  (ingredient) => Chip(
                    label: Text(
                      ingredient,
                      style: utilityTextStyle(color: shoppingForeground),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: shoppingForeground,
              textStyle: utilityTextStyle(fontWeight: FontWeight.w600),
            ),
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final shoppingForeground = isDark ? TuscanColors.cream : TuscanColors.wine;

    return TuscanBackground(
      child: Scaffold(
        appBar: AppBar(title: const Text('Shopping List')),
        body: SafeArea(
          child: cart.isEmpty
              ? EmptyState(
                  icon: Icons.shopping_basket,
                  title: 'Your basket is empty — add a recipe to your cart!',
                  iconColor: shoppingForeground,
                  showIconBackground: false,
                )
              : ListView(
                  padding: const EdgeInsets.fromLTRB(4, 8, 4, 24),
                  children: [
                    ...cart.entries.map((entry) {
                      final recipe = entry.key;
                      final qty = entry.value;

                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(14),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 46,
                                height: 46,
                                child: Icon(
                                  Icons.local_grocery_store,
                                  color: shoppingForeground,
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
                                            color: shoppingForeground,
                                            fontWeight: FontWeight.w800,
                                          ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Quantity: $qty',
                                      style: utilityTextStyle(
                                        color: shoppingForeground,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                tooltip: 'Remove one',
                                icon: Icon(
                                  Icons.remove,
                                  color: shoppingForeground,
                                ),
                                onPressed: () => _decrement(recipe),
                              ),
                              IconButton(
                                tooltip: 'Add one',
                                icon: Icon(
                                  Icons.add,
                                  color: shoppingForeground,
                                ),
                                onPressed: () => _increment(recipe),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                      child: Center(
                        child: FilledButton.icon(
                          style: isDark
                              ? creamWineButtonStyle()
                              : FilledButton.styleFrom(
                                  backgroundColor: TuscanColors.wine,
                                  foregroundColor: TuscanColors.linen,
                                  textStyle: utilityTextStyle(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                          onPressed: _generateShoppingList,
                          icon: const Icon(Icons.receipt_long),
                          label: const Text('Generate Shopping List'),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
