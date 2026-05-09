# Recipe Manager

A Flutter recipe manager app with a Tuscan restaurant-inspired visual theme. The app supports adding recipes, editing saved recipes, viewing recipe details, adding recipes to a shopping list, adjusting quantities, and generating a combined ingredient list.

## Features

- Custom light and dark mode themes
- Add and edit recipes
- Save ingredients and cooking instructions
- View saved recipes in styled recipe cards
- Add recipes to a shopping list
- Increase or decrease shopping list quantities
- Generate a consolidated ingredient list
- Responsive Flutter UI for mobile-style layouts

## Tools & Technologies

- Flutter
- Dart
- Material Design
- Android Studio
- Xcode / iOS Simulator support
- Git

## How To Run

Install Flutter, then run:

```bash
flutter pub get
flutter run
```

To check the project:

```bash
flutter analyze
flutter test
```

## Project Structure

- `lib/main.dart` starts the app.
- `lib/recipe_app.dart` wires the app theme and light/dark mode.
- `lib/models/` contains app data models.
- `lib/data/` contains the in-memory recipe and cart store.
- `lib/theme/` contains the Tuscan color palette, font styles, and app theme.
- `lib/screens/` contains the Home, Add Recipe, View Recipes, and Shopping List screens.
- `lib/widgets/` contains reusable UI widgets.
- `test/widget_test.dart` contains the widget smoke test.
- `android/`, `ios/`, `web/`, `macos/`, `linux/`, and `windows/` contain Flutter platform scaffolding.
