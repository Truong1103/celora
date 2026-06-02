import 'package:flutter/material.dart';

import '../models/celora_models.dart';
import '../theme/celora_colors.dart';
import '../theme/celora_styles.dart';
import '../utils/celora_helpers.dart';
import '../widgets/celora_widgets.dart';
import '../widgets/pad_mix_bar.dart';
import '../widgets/pad_mix_legend.dart';

class HomeScreen extends StatelessWidget {
  final UserProfile profile;
  final PadMix mix;
  final CyclePrediction prediction;
  final ImpactStats impact;

  const HomeScreen({
    super.key,
    required this.profile,
    required this.mix,
    required this.prediction,
    required this.impact,
  });

  @override
  Widget build(BuildContext context) {
    return CeloraPage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hi ${profile.name} 👋',
            style: CeloraStyles.sans(fontSize: 13, color: CeloraColors.mute),
          ),
          const SizedBox(height: 4),
          const CeloraPageTitle(title: 'Your cycle'),
          const SizedBox(height: 16),
          CeloraCard(
            backgroundColor: CeloraColors.dark,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Next period predicted',
                  style: CeloraStyles.sans(
                    fontSize: 12,
                    color: Colors.white.withValues(alpha: 0.85),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  prediction.daysUntil != null
                      ? 'in ${prediction.daysUntil} days'
                      : '—',
                  style: CeloraStyles.serif(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                Text(
                  prediction.nextDate != null
                      ? formatDisplayDate(prediction.nextDate!)
                      : 'Add your last period in profile',
                  style: CeloraStyles.sans(
                    fontSize: 12.5,
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
                const CeloraCardTitle(title: 'Your personalized 12-pad mix'),
                const SizedBox(height: 12),
                PadMixBar(mix: mix),
                PadMixLegend(mix: mix),
                Padding(
                  padding: const EdgeInsets.only(top: 14),
                  child: Text.rich(
                    TextSpan(
                      style: CeloraStyles.sans(
                        fontSize: 11.5,
                        color: CeloraColors.mute,
                        height: 1.5,
                      ),
                      children: [
                        const TextSpan(
                          text:
                              'Tailored to your ',
                        ),
                        TextSpan(
                          text: profile.flow,
                          style: CeloraStyles.sans(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w700,
                            color: CeloraColors.dark,
                          ),
                        ),
                        const TextSpan(
                          text:
                              ' flow. Each pack ships with this exact ratio so you carry only what you need.',
                        ),
                      ],
                    ),
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
                const CeloraCardTitle(title: "This month's kit"),
                const SizedBox(height: 12),
                _kitItem(
                  emoji: '🩸',
                  title: '12 personalized pads',
                  subtitle: 'Your custom red / yellow / green mix',
                ),
                const SizedBox(height: 10),
                _kitItem(
                  emoji: '🩲',
                  title: 'Biodegradable underwear',
                  subtitle: '1 pair, compostable',
                ),
                const SizedBox(height: 10),
                _kitItem(
                  emoji: '♨️',
                  title: 'Reusable heating pad',
                  subtitle: 'Eases cramps naturally',
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          CeloraCard(
            backgroundColor: CeloraColors.pale,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your impact so far',
                        style: CeloraStyles.sans(
                          fontSize: 12,
                          color: CeloraColors.mute,
                        ),
                      ),
                      Text(
                        '${impact.plasticAvoided}g plastic avoided',
                        style: CeloraStyles.serif(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: CeloraColors.dark,
                        ),
                      ),
                    ],
                  ),
                ),
                const Text('🌱', style: TextStyle(fontSize: 30)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _kitItem({
    required String emoji,
    required String title,
    required String subtitle,
  }) {
    return Row(
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: CeloraColors.pale,
            borderRadius: BorderRadius.circular(11),
          ),
          alignment: Alignment.center,
          child: Text(emoji, style: const TextStyle(fontSize: 18)),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: CeloraStyles.sans(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                  color: CeloraColors.ink,
                ),
              ),
              Text(
                subtitle,
                style: CeloraStyles.sans(
                  fontSize: 11.5,
                  color: CeloraColors.mute,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
