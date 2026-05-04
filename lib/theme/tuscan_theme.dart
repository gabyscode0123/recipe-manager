import 'package:flutter/material.dart';

class TuscanColors {
  static const cream = Color(0xFFF7E7CD);
  static const linen = Color(0xFFFFF6E8);
  static const parchment = Color(0xFFF1D7B6);
  static const bakedClay = Color(0xFFD9AE83);
  static const terracotta = Color(0xFFB84A2F);
  static const brightTerracotta = Color(0xFFE0865F);
  static const creamyTerracotta = Color(0xFFF0B58E);
  static const tomato = Color(0xFFD36135);
  static const olive = Color(0xFF657C43);
  static const deepOlive = Color(0xFF465B2F);
  static const basil = Color(0xFF3F5F3B);
  static const wine = Color(0xFF6D2635);
  static const brightWine = Color(0xFFD86A82);
  static const paleWine = Color(0xFFDFA8A3);
  static const night = Color(0xFF241A16);
  static const walnut = Color(0xFF3B2821);
  static const chestnut = Color(0xFF4D352D);
  static const toastedWalnut = Color(0xFF60453A);
  static const cafe = Color(0xFF806052);
  static const copper = Color(0xFFC96A3C);
  static const sage = Color(0xFF9AAA6F);
  static const lightSage = Color(0xFFAEBB82);
}

const tuscanFontFamily = 'Georgia';
const tuscanFontFallback = ['Times New Roman', 'Times', 'serif'];
const utilityFontFamily = 'Roboto';
const utilityFontFallback = ['Arial', 'Helvetica', 'sans-serif'];

TextStyle tuscanTextStyle({
  Color? color,
  double? fontSize,
  FontWeight? fontWeight,
  double? height,
  double? letterSpacing,
}) {
  return TextStyle(
    color: color,
    fontFamily: tuscanFontFamily,
    fontFamilyFallback: tuscanFontFallback,
    fontSize: fontSize,
    fontWeight: fontWeight,
    height: height,
    letterSpacing: letterSpacing,
  );
}

TextStyle utilityTextStyle({
  Color? color,
  double? fontSize,
  FontWeight? fontWeight,
  double? height,
  double? letterSpacing,
}) {
  return TextStyle(
    color: color,
    fontFamily: utilityFontFamily,
    fontFamilyFallback: utilityFontFallback,
    fontSize: fontSize,
    fontWeight: fontWeight,
    height: height,
    letterSpacing: letterSpacing,
  );
}

ButtonStyle creamWineButtonStyle() {
  return FilledButton.styleFrom(
    backgroundColor: TuscanColors.cream,
    foregroundColor: TuscanColors.wine,
    textStyle: utilityTextStyle(fontWeight: FontWeight.w700),
  );
}

ThemeData buildTuscanTheme(Brightness brightness) {
  final isDark = brightness == Brightness.dark;
  final scheme = ColorScheme(
    brightness: brightness,
    primary: TuscanColors.terracotta,
    onPrimary: TuscanColors.linen,
    secondary: isDark ? TuscanColors.sage : TuscanColors.olive,
    onSecondary: isDark ? TuscanColors.night : TuscanColors.linen,
    error: isDark ? const Color(0xFFFFB4A9) : TuscanColors.wine,
    onError: isDark ? TuscanColors.night : TuscanColors.linen,
    surface: isDark ? TuscanColors.cafe : TuscanColors.linen,
    onSurface: isDark ? TuscanColors.cream : TuscanColors.wine,
  );

  final base = ThemeData(
    useMaterial3: true,
    brightness: brightness,
    colorScheme: scheme,
    scaffoldBackgroundColor: isDark
        ? TuscanColors.walnut
        : TuscanColors.bakedClay,
    fontFamily: tuscanFontFamily,
    fontFamilyFallback: tuscanFontFallback,
  );

  return base.copyWith(
    textTheme: _buildTextTheme(base.textTheme, scheme.onSurface),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: scheme.onSurface,
      iconTheme: IconThemeData(
        color: isDark ? TuscanColors.cream : TuscanColors.wine,
      ),
      actionsIconTheme: IconThemeData(color: scheme.primary),
      elevation: 0,
      centerTitle: false,
      titleTextStyle: tuscanTextStyle(
        color: scheme.onSurface,
        fontSize: 22,
        fontWeight: FontWeight.w800,
      ),
    ),
    cardTheme: CardThemeData(
      color: scheme.surface,
      elevation: isDark ? 0 : 2,
      shadowColor: TuscanColors.wine.withValues(alpha: 0.18),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: (isDark ? TuscanColors.cream : TuscanColors.wine).withValues(
            alpha: isDark ? 0.08 : 0.10,
          ),
        ),
      ),
    ),
    iconTheme: IconThemeData(color: scheme.primary),
    listTileTheme: ListTileThemeData(
      iconColor: scheme.primary,
      textColor: scheme.onSurface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
        shape: const StadiumBorder(),
        textStyle: utilityTextStyle(fontWeight: FontWeight.w700),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
        shape: const StadiumBorder(),
        textStyle: utilityTextStyle(fontWeight: FontWeight.w700),
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        foregroundColor: scheme.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: scheme.surface,
      prefixIconColor: isDark ? TuscanColors.sage : TuscanColors.deepOlive,
      hintStyle: utilityTextStyle(
        color: scheme.onSurface.withValues(alpha: 0.55),
      ),
      labelStyle: utilityTextStyle(
        color: scheme.onSurface.withValues(alpha: 0.78),
        fontWeight: FontWeight.w700,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: scheme.onSurface.withValues(alpha: 0.12)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: scheme.onSurface.withValues(alpha: 0.12)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: TuscanColors.wine, width: 1.8),
      ),
    ),
    chipTheme: base.chipTheme.copyWith(
      backgroundColor: isDark ? TuscanColors.walnut : TuscanColors.parchment,
      selectedColor: scheme.secondary,
      labelStyle: utilityTextStyle(
        color: isDark ? TuscanColors.cream : TuscanColors.wine,
        fontWeight: FontWeight.w600,
      ),
      side: BorderSide.none,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: scheme.surface,
      surfaceTintColor: TuscanColors.cream.withValues(alpha: 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      titleTextStyle: tuscanTextStyle(
        color: scheme.onSurface,
        fontSize: 22,
        fontWeight: FontWeight.w800,
      ),
      contentTextStyle: utilityTextStyle(color: scheme.onSurface, height: 1.35),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: TuscanColors.wine,
      contentTextStyle: utilityTextStyle(color: TuscanColors.cream),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  );
}

TextTheme _buildTextTheme(TextTheme base, Color textColor) {
  return base
      .apply(bodyColor: textColor, displayColor: textColor)
      .copyWith(
        headlineMedium: base.headlineMedium?.copyWith(
          fontFamily: tuscanFontFamily,
          fontFamilyFallback: tuscanFontFallback,
          fontWeight: FontWeight.w900,
          letterSpacing: 0,
          height: 1.08,
        ),
        titleLarge: base.titleLarge?.copyWith(
          fontFamily: tuscanFontFamily,
          fontFamilyFallback: tuscanFontFallback,
          fontWeight: FontWeight.w800,
          letterSpacing: 0,
        ),
        titleMedium: base.titleMedium?.copyWith(
          fontFamily: tuscanFontFamily,
          fontFamilyFallback: tuscanFontFallback,
          fontWeight: FontWeight.w800,
          letterSpacing: 0,
        ),
        bodyLarge: base.bodyLarge?.copyWith(
          fontFamily: utilityFontFamily,
          fontFamilyFallback: utilityFontFallback,
          height: 1.35,
        ),
        bodyMedium: base.bodyMedium?.copyWith(
          fontFamily: utilityFontFamily,
          fontFamilyFallback: utilityFontFallback,
        ),
      );
}
