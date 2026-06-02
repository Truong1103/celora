import 'package:flutter/material.dart';

import '../models/celora_models.dart';
import '../theme/celora_colors.dart';
import '../theme/celora_styles.dart';
import '../utils/celora_constants.dart';
import 'celora_dot.dart';

class PadMixLegend extends StatelessWidget {
  final PadMix mix;

  const PadMixLegend({super.key, required this.mix});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        children: flowTypes.map((type) {
          final count = mixCountForKey(mix, type.key);
          final dotColor = Color(type.dotColorValue);

          return Expanded(
            child: Column(
              children: [
                Text(
                  '$count',
                  style: CeloraStyles.serif(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: CeloraColors.ink,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CeloraDot(color: dotColor),
                    const SizedBox(width: 5),
                    Text(
                      type.name,
                      style: CeloraStyles.sans(
                        fontSize: 11,
                        color: CeloraColors.mute,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
