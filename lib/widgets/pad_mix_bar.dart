import 'package:flutter/material.dart';

import '../models/celora_models.dart';
import '../theme/celora_colors.dart';

class PadMixBar extends StatelessWidget {
  final PadMix mix;

  const PadMixBar({super.key, required this.mix});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 14,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black.withValues(alpha: 0.04)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: [
          Expanded(
            flex: mix.red,
            child: Container(color: CeloraColors.redDot),
          ),
          Expanded(
            flex: mix.yellow,
            child: Container(color: CeloraColors.yellowDot),
          ),
          Expanded(
            flex: mix.green,
            child: Container(color: CeloraColors.greenDot),
          ),
        ],
      ),
    );
  }
}
