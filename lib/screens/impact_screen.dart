import 'package:flutter/material.dart';

import '../models/celora_models.dart';
import '../theme/celora_colors.dart';
import '../theme/celora_styles.dart';
import '../utils/celora_helpers.dart';
import '../widgets/celora_widgets.dart';

class ImpactScreen extends StatelessWidget {
  final ImpactStats impact;

  const ImpactScreen({super.key, required this.impact});

  @override
  Widget build(BuildContext context) {
    final stats = [
      ('🩸', '${impact.padsReplaced}', 'plastic pads replaced', CeloraColors.dark),
      (
        '🌱',
        '${(impact.plasticAvoided / 1000).toStringAsFixed(2)}kg',
        'plastic waste avoided',
        CeloraColors.mid,
      ),
      (
        '💗',
        formatVnd(impact.socialFund),
        'given to social fund',
        CeloraColors.rose,
      ),
      (
        '👧',
        '${impact.girlsReached}',
        'girls reached with access',
        CeloraColors.dark,
      ),
    ];

    final progress =
        (impact.girlsReached / 2000 * 100).clamp(0.0, 100.0).toDouble();

    return CeloraPage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CeloraPageTitle(title: 'Your impact'),
          Text(
            '1% of everything you spend funds menstrual-health access for girls in Vietnam.',
            style: CeloraStyles.sans(fontSize: 13, color: CeloraColors.mute),
          ),
          const SizedBox(height: 16),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.95,
            children: stats.map((stat) {
              return CeloraCard(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(stat.$1, style: const TextStyle(fontSize: 26)),
                    const SizedBox(height: 6),
                    Text(
                      stat.$2,
                      style: CeloraStyles.serif(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: stat.$4,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      stat.$3,
                      style: CeloraStyles.sans(
                        fontSize: 11.5,
                        color: CeloraColors.mute,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          CeloraCard(
            backgroundColor: CeloraColors.dark,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Community goal — 2026',
                  style: CeloraStyles.sans(
                    fontSize: 12,
                    color: Colors.white.withValues(alpha: 0.85),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Reach 2,000 girls',
                  style: CeloraStyles.serif(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: LinearProgressIndicator(
                    value: progress / 100,
                    minHeight: 10,
                    backgroundColor: Colors.white.withValues(alpha: 0.25),
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${impact.girlsReached} / 2,000 reached',
                  style: CeloraStyles.sans(
                    fontSize: 11.5,
                    color: Colors.white.withValues(alpha: 0.85),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          CeloraCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CeloraCardTitle(title: 'How it works'),
                const SizedBox(height: 8),
                Text(
                  'Every Celora pad replaces a conventional plastic-based one. We divert ~48g of plastic per pack, and direct 1% of revenue into education and product access for underserved communities.',
                  style: CeloraStyles.sans(
                    fontSize: 12.5,
                    color: CeloraColors.mute,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
