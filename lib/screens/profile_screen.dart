import 'package:flutter/material.dart';

import '../models/celora_models.dart';
import '../theme/celora_colors.dart';
import '../theme/celora_styles.dart';
import '../widgets/celora_widgets.dart';
import '../widgets/pad_mix_bar.dart';
import '../widgets/pad_mix_legend.dart';

class ProfileScreen extends StatelessWidget {
  final UserProfile profile;
  final PadMix mix;
  final VoidCallback onReset;

  const ProfileScreen({
    super.key,
    required this.profile,
    required this.mix,
    required this.onReset,
  });

  String get _periodLengthLabel {
    switch (profile.length) {
      case 'short':
        return '3–4 days';
      case 'long':
        return '7+ days';
      default:
        return '5–6 days';
    }
  }

  @override
  Widget build(BuildContext context) {
    final initial = profile.name.isNotEmpty
        ? profile.name.substring(0, 1).toUpperCase()
        : '?';

    return CeloraPage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CeloraPageTitle(title: 'Profile'),
          const SizedBox(height: 16),
          CeloraCard(
            child: Row(
              children: [
                Container(
                  width: 54,
                  height: 54,
                  decoration: const BoxDecoration(
                    color: CeloraColors.mid,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    initial,
                    style: CeloraStyles.serif(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      profile.name,
                      style: CeloraStyles.sans(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: CeloraColors.ink,
                      ),
                    ),
                    Text(
                      'Celora member',
                      style: CeloraStyles.sans(
                        fontSize: 12,
                        color: CeloraColors.mute,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          CeloraCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CeloraCardTitle(title: 'Your cycle profile'),
                const SizedBox(height: 12),
                CheckoutRow(
                  label: 'Flow',
                  value: profile.flow[0].toUpperCase() + profile.flow.substring(1),
                ),
                const SizedBox(height: 10),
                CheckoutRow(label: 'Period length', value: _periodLengthLabel),
                const SizedBox(height: 10),
                CheckoutRow(
                  label: 'Last period',
                  value: profile.lastStart.isEmpty ? 'Not set' : profile.lastStart,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          CeloraCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CeloraCardTitle(title: 'Your pad mix'),
                const SizedBox(height: 12),
                PadMixBar(mix: mix),
                PadMixLegend(mix: mix),
              ],
            ),
          ),
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: onReset,
              style: CeloraStyles.ghostButtonStyle(),
              child: const Text('Restart onboarding'),
            ),
          ),
        ],
      ),
    );
  }
}
