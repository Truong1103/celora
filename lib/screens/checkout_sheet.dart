import 'package:flutter/material.dart';

import '../models/celora_models.dart';
import '../theme/celora_colors.dart';
import '../theme/celora_styles.dart';
import '../utils/celora_helpers.dart';
import '../widgets/celora_widgets.dart';

class CheckoutSheet extends StatefulWidget {
  final CheckoutItem item;
  final VoidCallback onConfirm;

  const CheckoutSheet({
    super.key,
    required this.item,
    required this.onConfirm,
  });

  @override
  State<CheckoutSheet> createState() => _CheckoutSheetState();
}

class _CheckoutSheetState extends State<CheckoutSheet> {
  bool _done = false;

  @override
  Widget build(BuildContext context) {
    final plan = widget.item.plan;
    final social = (plan.price * 0.01).round();
    final vat = (plan.price - plan.price / 1.08).round();

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
        boxShadow: [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 40,
            offset: Offset(0, -10),
          ),
        ],
      ),
      padding: EdgeInsets.fromLTRB(
        22,
        20,
        22,
        28 + MediaQuery.of(context).padding.bottom,
      ),
      child: SingleChildScrollView(
        child: _done ? _buildSuccess(social) : _buildCheckout(plan, social, vat),
      ),
    );
  }

  Widget _buildCheckout(SubscriptionPlan plan, int social, int vat) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: CeloraColors.light,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
        const SizedBox(height: 18),
        Text(
          'Confirm purchase',
          style: CeloraStyles.serif(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: CeloraColors.ink,
          ),
        ),
        const SizedBox(height: 18),
        CheckoutRow(
          label: '${plan.label}${plan.per}',
          value: formatVnd(plan.price),
        ),
        const SizedBox(height: 12),
        CheckoutRow(
          label: 'VAT (8%, included)',
          value: formatVnd(vat),
          muted: true,
        ),
        const SizedBox(height: 12),
        CheckoutRow(
          label: '🌱 To social impact (1%)',
          value: formatVnd(social),
          muted: true,
        ),
        const SizedBox(height: 12),
        Container(height: 1, color: CeloraColors.light),
        const SizedBox(height: 12),
        CheckoutRow(
          label: 'Total today',
          value: formatVnd(plan.price),
          bold: true,
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: CeloraColors.paler,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: CeloraColors.pale),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pay with',
                style: CeloraStyles.sans(fontSize: 12, color: CeloraColors.mute),
              ),
              const SizedBox(height: 8),
              Row(
                children: ['Momo', 'ZaloPay', 'Card'].asMap().entries.map((entry) {
                  final selected = entry.key == 0;
                  return Expanded(
                    child: Container(
                      margin: EdgeInsets.only(right: entry.key < 2 ? 8 : 0),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: selected ? CeloraColors.mid : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: CeloraColors.light),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        entry.value,
                        style: CeloraStyles.sans(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w700,
                          color: selected ? Colors.white : CeloraColors.ink,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        ElevatedButton(
          onPressed: () => setState(() => _done = true),
          style: CeloraStyles.primaryButtonStyle(),
          child: Text('Pay ${formatVnd(plan.price)}'),
        ),
        const SizedBox(height: 10),
        Text(
          'Prototype — no real payment is processed',
          textAlign: TextAlign.center,
          style: CeloraStyles.sans(fontSize: 10.5, color: CeloraColors.mute),
        ),
      ],
    );
  }

  Widget _buildSuccess(int social) {
    final plan = widget.item.plan;
    final typeLabel =
        widget.item.type == 'sub' ? 'subscription' : 'pack';

    return Column(
      children: [
        const Text('🎉', style: TextStyle(fontSize: 54)),
        const SizedBox(height: 8),
        Text(
          "You're all set!",
          style: CeloraStyles.serif(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: CeloraColors.ink,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Your personalized ${plan.label} $typeLabel is confirmed.\n'
          '${formatVnd(social)} goes to the Celora social-impact fund.',
          textAlign: TextAlign.center,
          style: CeloraStyles.sans(
            fontSize: 13,
            color: CeloraColors.mute,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 22),
        ElevatedButton(
          onPressed: widget.onConfirm,
          style: CeloraStyles.primaryButtonStyle(),
          child: const Text('Done'),
        ),
      ],
    );
  }
}
