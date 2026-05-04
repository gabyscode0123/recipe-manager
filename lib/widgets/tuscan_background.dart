import 'package:flutter/material.dart';

import '../theme/tuscan_theme.dart';

class TuscanBackground extends StatelessWidget {
  final Widget child;

  const TuscanBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ColoredBox(
      color: isDark ? TuscanColors.walnut : TuscanColors.bakedClay,
      child: child,
    );
  }
}
