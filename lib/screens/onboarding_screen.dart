import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/celora_models.dart';
import '../theme/celora_colors.dart';
import '../theme/celora_styles.dart';

class OnboardingScreen extends StatefulWidget {
  final ValueChanged<UserProfile> onDone;

  const OnboardingScreen({super.key, required this.onDone});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _step = 0;
  String _name = '';
  String? _flow;
  String? _length;
  String _lastStart = '';

  late final List<_OnboardingStep> _steps;

  @override
  void initState() {
    super.initState();
    _steps = [
      _OnboardingStep(
        title: 'Welcome to Celora',
        subtitle:
            'Period care, personalized to you — and kinder to the planet.',
        canNext: () => _name.trim().isNotEmpty,
        builder: _buildNameStep,
      ),
      _OnboardingStep(
        title: 'How would you describe your flow?',
        subtitle: "We'll tailor the mix of pads in every pack.",
        canNext: () => _flow != null,
        builder: _buildFlowStep,
      ),
      _OnboardingStep(
        title: 'How long is your period, usually?',
        subtitle: 'This fine-tunes your personalized pack.',
        canNext: () => _length != null,
        builder: _buildLengthStep,
      ),
      _OnboardingStep(
        title: 'When did your last period start?',
        subtitle: 'So we can predict your next one. (You can skip.)',
        canNext: () => true,
        builder: _buildLastStartStep,
      ),
    ];
  }

  void _next() {
    final isLast = _step == _steps.length - 1;
    if (isLast) {
      widget.onDone(
        UserProfile(
          name: _name.trim(),
          flow: _flow ?? 'medium',
          length: _length ?? 'average',
          lastStart: _lastStart,
        ),
      );
      return;
    }
    setState(() => _step++);
  }

  void _back() {
    if (_step > 0) {
      setState(() => _step--);
    }
  }

  @override
  Widget build(BuildContext context) {
    final current = _steps[_step];
    final canNext = current.canNext();
    final isLast = _step == _steps.length - 1;

    return Scaffold(
      backgroundColor: CeloraColors.paler,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: List.generate(_steps.length, (index) {
                      return Expanded(
                        child: Container(
                          height: 4,
                          margin: EdgeInsets.only(
                            right: index == _steps.length - 1 ? 0 : 6,
                          ),
                          decoration: BoxDecoration(
                            color: index <= _step
                                ? CeloraColors.mid
                                : CeloraColors.light,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 26),
                  Text(
                    'CELORA',
                    style: CeloraStyles.serif(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 3,
                      color: CeloraColors.mid,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    current.title,
                    style: CeloraStyles.serif(
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                      color: CeloraColors.ink,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    current.subtitle,
                    style: CeloraStyles.sans(
                      fontSize: 13.5,
                      color: CeloraColors.mute,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: current.builder(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  if (_step > 0) ...[
                    OutlinedButton(
                      onPressed: _back,
                      style: CeloraStyles.ghostButtonStyle(),
                      child: const Text('Back'),
                    ),
                    const SizedBox(width: 12),
                  ],
                  Expanded(
                    child: ElevatedButton(
                      onPressed: canNext ? _next : null,
                      style: CeloraStyles.primaryButtonStyle(
                        opacity: canNext ? 1 : 0.4,
                      ),
                      child: Text(
                        isLast ? 'See my personalized pack →' : 'Continue',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNameStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'What should we call you?',
          style: CeloraStyles.sans(
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
            color: CeloraColors.mute,
          ),
        ),
        const SizedBox(height: 8),
        Material(
          color: CeloraColors.white,
          borderRadius: BorderRadius.circular(12),
          child: TextField(
            decoration: CeloraStyles.inputDecoration(hintText: 'Your name'),
            style: CeloraStyles.sans(fontSize: 15, color: CeloraColors.ink),
            onChanged: (value) => setState(() => _name = value),
          ),
        ),
      ],
    );
  }

  Widget _buildFlowStep() {
    return Column(
      children: [
        _choiceButton(
          title: 'Heavy',
          subtitle: 'More red (heavy-flow) pads',
          selected: _flow == 'heavy',
          onTap: () => setState(() => _flow = 'heavy'),
        ),
        const SizedBox(height: 10),
        _choiceButton(
          title: 'Medium',
          subtitle: 'A balanced mix',
          selected: _flow == 'medium',
          onTap: () => setState(() => _flow = 'medium'),
        ),
        const SizedBox(height: 10),
        _choiceButton(
          title: 'Light',
          subtitle: 'More green (light-flow) pads',
          selected: _flow == 'light',
          onTap: () => setState(() => _flow = 'light'),
        ),
      ],
    );
  }

  Widget _buildLengthStep() {
    return Column(
      children: [
        _choiceButton(
          title: '3–4 days',
          subtitle: 'Shorter cycle',
          selected: _length == 'short',
          onTap: () => setState(() => _length = 'short'),
        ),
        const SizedBox(height: 10),
        _choiceButton(
          title: '5–6 days',
          subtitle: 'Average',
          selected: _length == 'average',
          onTap: () => setState(() => _length = 'average'),
        ),
        const SizedBox(height: 10),
        _choiceButton(
          title: '7+ days',
          subtitle: 'Longer cycle',
          selected: _length == 'long',
          onTap: () => setState(() => _length = 'long'),
        ),
      ],
    );
  }

  Widget _buildLastStartStep() {
    final displayDate = _lastStart.isEmpty
        ? 'Select date (optional)'
        : DateFormat.yMMMd().format(DateTime.parse(_lastStart));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Last period start date',
          style: CeloraStyles.sans(
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
            color: CeloraColors.mute,
          ),
        ),
        const SizedBox(height: 8),
        Material(
          color: CeloraColors.white,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2020),
                lastDate: DateTime.now(),
                builder: (context, child) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: const ColorScheme.light(
                        primary: CeloraColors.mid,
                        onPrimary: Colors.white,
                        surface: Colors.white,
                        onSurface: CeloraColors.ink,
                      ),
                    ),
                    child: child!,
                  );
                },
              );
              if (picked != null) {
                setState(() {
                  _lastStart = DateFormat('yyyy-MM-dd').format(picked);
                });
              }
            },
            borderRadius: BorderRadius.circular(12),
            child: InputDecorator(
              decoration: CeloraStyles.inputDecoration(),
              child: Text(
                displayDate,
                style: CeloraStyles.sans(fontSize: 15, color: CeloraColors.ink),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _choiceButton({
    required String title,
    required String subtitle,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return Material(
      color: selected ? CeloraColors.pale : CeloraColors.white,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: selected ? CeloraColors.mid : CeloraColors.light,
              width: 2,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: CeloraStyles.sans(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: CeloraColors.ink,
                ),
              ),
              Text(
                subtitle,
                style: CeloraStyles.sans(fontSize: 12, color: CeloraColors.mute),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnboardingStep {
  final String title;
  final String subtitle;
  final bool Function() canNext;
  final Widget Function() builder;

  const _OnboardingStep({
    required this.title,
    required this.subtitle,
    required this.canNext,
    required this.builder,
  });
}
