import 'package:flutter/material.dart';

import '../theme/tuscan_theme.dart';

class HomeActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color accentColor;
  final VoidCallback onTap;

  const HomeActionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.accentColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final displayAccent = isDark ? _nightAccent(accentColor) : accentColor;

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: displayAccent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: TuscanColors.linen, size: 26),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurface.withValues(alpha: 0.64),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: isDark ? TuscanColors.cream : TuscanColors.wine,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _nightAccent(Color color) {
    if (color == TuscanColors.terracotta) return TuscanColors.copper;
    if (color == TuscanColors.olive) return TuscanColors.sage;
    if (color == TuscanColors.wine) return const Color(0xFFB7435E);

    return color;
  }
}
