import 'package:flutter/material.dart';

import '../models/celora_models.dart';
import '../theme/celora_colors.dart';
import '../theme/celora_styles.dart';
import '../utils/celora_constants.dart';
import '../utils/celora_helpers.dart';
import '../widgets/celora_widgets.dart';
import '../widgets/pad_mix_bar.dart';
import 'checkout_sheet.dart';

class ShopScreen extends StatefulWidget {
  final PadMix mix;
  final SubscriptionPlan? owned;
  final ValueChanged<CheckoutItem> onPurchase;

  const ShopScreen({
    super.key,
    required this.mix,
    required this.owned,
    required this.onPurchase,
  });

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  String _selected = 'quarterly';

  void _openCheckout(CheckoutItem item) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return CheckoutSheet(
          item: item,
          onConfirm: () {
            widget.onPurchase(item);
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedPlan = subscriptionPlans[_selected]!;

    return CeloraPage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CeloraPageTitle(title: 'Subscribe'),
          Text(
            'Every kit is personalized to your flow and delivered to your door.',
            style: CeloraStyles.sans(fontSize: 13, color: CeloraColors.mute),
          ),
          const SizedBox(height: 16),
          CeloraCard(
            margin: const EdgeInsets.only(bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CeloraCardTitle(title: "Celora Kit — what's inside"),
                const SizedBox(height: 12),
                PadMixBar(mix: widget.mix),
                const SizedBox(height: 12),
                Text(
                  '12 personalized pads · biodegradable underwear · reusable heating pad',
                  style: CeloraStyles.sans(fontSize: 12, color: CeloraColors.mute),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          ...subscriptionPlans.values.map((plan) {
            final selected = _selected == plan.id;
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _PlanCard(
                plan: plan,
                selected: selected,
                onTap: () => setState(() => _selected = plan.id),
              ),
            );
          }),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _openCheckout(
                CheckoutItem(type: 'sub', plan: selectedPlan),
              ),
              style: CeloraStyles.primaryButtonStyle(),
              child: Text(
                'Subscribe — ${formatVnd(selectedPlan.price)}${selectedPlan.per}',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 22),
            child: Row(
              children: [
                Expanded(child: Container(height: 1, color: CeloraColors.light)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    'or buy once',
                    style: CeloraStyles.sans(fontSize: 11, color: CeloraColors.mute),
                  ),
                ),
                Expanded(child: Container(height: 1, color: CeloraColors.light)),
              ],
            ),
          ),
          CeloraCard(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dailyPadPackPlan.label,
                        style: CeloraStyles.sans(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: CeloraColors.ink,
                        ),
                      ),
                      Text(
                        dailyPadPackPlan.billed,
                        style: CeloraStyles.sans(
                          fontSize: 11.5,
                          color: CeloraColors.mute,
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _openCheckout(
                    const CheckoutItem(type: 'pack', plan: dailyPadPackPlan),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CeloraColors.dark,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                    textStyle: CeloraStyles.serif(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  child: Text(formatVnd(dailyPadPackPlan.price)),
                ),
              ],
            ),
          ),
          if (widget.owned != null) ...[
            const SizedBox(height: 16),
            CeloraCard(
              backgroundColor: CeloraColors.pale,
              child: Column(
                children: [
                  Text(
                    '✓ Active: ${widget.owned!.label}',
                    textAlign: TextAlign.center,
                    style: CeloraStyles.sans(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: CeloraColors.dark,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Next kit ships in 12 days',
                    textAlign: TextAlign.center,
                    style: CeloraStyles.sans(
                      fontSize: 11.5,
                      color: CeloraColors.mute,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  final SubscriptionPlan plan;
  final bool selected;
  final VoidCallback onTap;

  const _PlanCard({
    required this.plan,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: selected ? CeloraColors.mid : CeloraColors.light,
              width: 2,
            ),
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: CeloraColors.mid,
                      spreadRadius: 0,
                      blurRadius: 0,
                      offset: Offset.zero,
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          plan.label,
                          style: CeloraStyles.sans(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: CeloraColors.ink,
                          ),
                        ),
                        if (plan.save != null) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: CeloraColors.mid,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              plan.save!,
                              style: CeloraStyles.sans(
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      plan.billed,
                      style: CeloraStyles.sans(
                        fontSize: 11.5,
                        color: CeloraColors.mute,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    formatVnd(plan.price),
                    style: CeloraStyles.serif(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: CeloraColors.dark,
                    ),
                  ),
                  Text(
                    plan.per,
                    style: CeloraStyles.sans(
                      fontSize: 11,
                      color: CeloraColors.mute,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
