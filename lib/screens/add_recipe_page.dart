import 'package:flutter/material.dart';

import '../data/recipe_store.dart';
import '../models/recipe.dart';
import '../theme/tuscan_theme.dart';
import '../widgets/section_label.dart';
import '../widgets/tuscan_background.dart';

class AddRecipePage extends StatefulWidget {
  final Recipe? recipe;

  const AddRecipePage({super.key, this.recipe});

  @override
  State<AddRecipePage> createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _instructionsController = TextEditingController();
  final TextEditingController _ingredientController = TextEditingController();
  final List<String> _ingredients = [];

  bool get _isEditing => widget.recipe != null;

  @override
  void initState() {
    super.initState();

    final recipe = widget.recipe;
    if (recipe == null) return;

    _nameController.text = recipe.name;
    _instructionsController.text = recipe.instructions;
    _ingredients.addAll(recipe.ingredients);
  }

  void _addIngredient() {
    final ingredient = _ingredientController.text.trim();
    if (ingredient.isNotEmpty) {
      setState(() {
        _ingredients.add(ingredient);
        _ingredientController.clear();
      });
    }
  }

  void _removeIngredient(int index) {
    setState(() {
      _ingredients.removeAt(index);
    });
  }

  void _saveRecipe() {
    final name = _nameController.text.trim();
    final instructions = _instructionsController.text.trim();

    if (name.isEmpty || instructions.isEmpty || _ingredients.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all fields and add ingredients.'),
        ),
      );
      return;
    }

    final editedRecipe = widget.recipe;
    if (editedRecipe == null) {
      recipes.add(
        Recipe(
          name: name,
          instructions: instructions,
          ingredients: List.from(_ingredients),
        ),
      );
    } else {
      editedRecipe
        ..name = name
        ..instructions = instructions
        ..ingredients = List.from(_ingredients);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(_isEditing ? 'Recipe updated!' : 'Recipe saved!')),
    );

    Navigator.pop(context);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _instructionsController.dispose();
    _ingredientController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const addRecipeFill = TuscanColors.cream;
    const addRecipeText = TuscanColors.wine;
    final addRecipeIcon = TuscanColors.wine;

    return TuscanBackground(
      child: Scaffold(
        appBar: AppBar(title: Text(_isEditing ? 'Edit Recipe' : 'Add Recipe')),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionLabel('Recipe Name'),
                const SizedBox(height: 8),
                TextField(
                  controller: _nameController,
                  cursorColor: addRecipeText,
                  style: utilityTextStyle(color: addRecipeText),
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: addRecipeFill,
                    hintText: 'Pappardelle al ragu',
                    hintStyle: utilityTextStyle(color: addRecipeText),
                    prefixIcon: const Icon(Icons.local_dining),
                    prefixIconColor: addRecipeIcon,
                  ),
                ),
                const SizedBox(height: 22),
                const SectionLabel('Cooking Instructions'),
                const SizedBox(height: 8),
                TextField(
                  controller: _instructionsController,
                  cursorColor: addRecipeText,
                  style: utilityTextStyle(color: addRecipeText),
                  maxLines: 5,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: addRecipeFill,
                    hintText: 'Brown, simmer, finish with fresh herbs...',
                    hintStyle: utilityTextStyle(color: addRecipeText),
                    prefixIcon: const Padding(
                      padding: EdgeInsets.only(left: 12, top: 14, right: 12),
                      child: Align(
                        alignment: Alignment.topLeft,
                        widthFactor: 1,
                        heightFactor: 1,
                        child: Icon(Icons.menu_book),
                      ),
                    ),
                    prefixIconColor: addRecipeIcon,
                    prefixIconConstraints: const BoxConstraints(
                      minWidth: 48,
                      minHeight: 48,
                    ),
                  ),
                ),
                const SizedBox(height: 22),
                const SectionLabel('Ingredients'),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _ingredientController,
                        cursorColor: addRecipeText,
                        style: utilityTextStyle(color: addRecipeText),
                        textCapitalization: TextCapitalization.sentences,
                        onSubmitted: (_) => _addIngredient(),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: addRecipeFill,
                          hintText: 'San Marzano tomatoes',
                          hintStyle: utilityTextStyle(color: addRecipeText),
                          prefixIcon: const Icon(Icons.spa),
                          prefixIconColor: addRecipeIcon,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      tooltip: 'Add ingredient',
                      icon: const Icon(Icons.add),
                      style: IconButton.styleFrom(
                        foregroundColor: isDark
                            ? TuscanColors.cream
                            : TuscanColors.wine,
                      ),
                      onPressed: _addIngredient,
                    ),
                  ],
                ),
                if (_ingredients.isNotEmpty) ...[
                  const SizedBox(height: 14),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _ingredients.asMap().entries.map((entry) {
                      final index = entry.key;
                      final ingredient = entry.value;

                      return InputChip(
                        label: Text(ingredient),
                        onDeleted: () => _removeIngredient(index),
                        deleteIcon: const Icon(Icons.close, size: 18),
                      );
                    }).toList(),
                  ),
                ],
                const SizedBox(height: 28),
                Center(
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
                    onPressed: _saveRecipe,
                    icon: const Icon(Icons.bookmark_add),
                    label: Text(_isEditing ? 'Update Recipe' : 'Save Recipe'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
