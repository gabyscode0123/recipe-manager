import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:recipe_manager/main.dart';

void main() {
  testWidgets('Recipe manager home shows primary actions', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const RecipeApp());

    expect(find.text('Trattoria Recipes'), findsNothing);
    expect(find.text('What shall we cook today?'), findsOneWidget);
    expect(find.text('View Recipes'), findsOneWidget);
    expect(find.text('Add Recipe'), findsOneWidget);
    expect(find.text('Shopping List'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.dark_mode));
    await tester.pump();

    expect(find.byIcon(Icons.light_mode), findsOneWidget);
  });
}
