import 'package:flutter/material.dart';

import '../theme/celora_colors.dart';
import '../theme/celora_styles.dart';

class CeloraCard extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  const CeloraCard({
    super.key,
    required this.child,
    this.backgroundColor,
    this.padding,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: margin,
      padding: padding ?? const EdgeInsets.all(18),
      decoration: CeloraStyles.cardDecoration(backgroundColor: backgroundColor),
      child: child,
    );
  }
}

class CeloraCardTitle extends StatelessWidget {
  final String title;

  const CeloraCardTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: CeloraStyles.sans(
        fontSize: 13,
        fontWeight: FontWeight.w800,
        color: CeloraColors.dark,
        letterSpacing: 0.3,
      ),
    );
  }
}

class CeloraPageTitle extends StatelessWidget {
  final String title;

  const CeloraPageTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: CeloraStyles.serif(
        fontSize: 26,
        fontWeight: FontWeight.w800,
        color: CeloraColors.ink,
      ),
    );
  }
}

class LegendItem extends StatelessWidget {
  final Color color;
  final Color borderColor;
  final String label;

  const LegendItem({
    super.key,
    required this.color,
    required this.label,
    this.borderColor = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(7),
            border: Border.all(color: borderColor, width: 2),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          label,
          style: CeloraStyles.sans(fontSize: 12.5, color: CeloraColors.ink),
        ),
      ],
    );
  }
}

class CheckoutRow extends StatelessWidget {
  final String label;
  final String value;
  final bool bold;
  final bool muted;

  const CheckoutRow({
    super.key,
    required this.label,
    required this.value,
    this.bold = false,
    this.muted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: CeloraStyles.sans(
            fontSize: bold ? 16 : 13.5,
            fontWeight: bold ? FontWeight.w800 : FontWeight.w500,
            color: muted ? CeloraColors.mute : CeloraColors.ink,
          ),
        ),
        Text(
          value,
          style: (bold ? CeloraStyles.serif : CeloraStyles.sans)(
            fontSize: bold ? 16 : 13.5,
            fontWeight: bold ? FontWeight.w800 : FontWeight.w600,
            color: bold
                ? CeloraColors.dark
                : muted
                    ? CeloraColors.mute
                    : CeloraColors.ink,
          ),
        ),
      ],
    );
  }
}

class CeloraPage extends StatelessWidget {
  final Widget child;

  const CeloraPage({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(22, 28, 22, 24),
      child: child,
    );
  }
}
