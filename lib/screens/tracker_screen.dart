import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../theme/celora_colors.dart';
import '../theme/celora_styles.dart';
import '../utils/celora_helpers.dart';
import '../widgets/celora_widgets.dart';

class TrackerScreen extends StatefulWidget {
  final int cycleLen;
  final int periodLen;
  final String lastStart;

  const TrackerScreen({
    super.key,
    required this.cycleLen,
    required this.periodLen,
    required this.lastStart,
  });

  @override
  State<TrackerScreen> createState() => _TrackerScreenState();
}

class _TrackerScreenState extends State<TrackerScreen> {
  late DateTime _viewMonth;

  @override
  void initState() {
    super.initState();
    final today = DateTime.now();
    _viewMonth = DateTime(today.year, today.month);
  }

  void _changeMonth(int delta) {
    setState(() {
      _viewMonth = DateTime(_viewMonth.year, _viewMonth.month + delta);
    });
  }

  @override
  Widget build(BuildContext context) {
    final today = dateOnly(DateTime.now());
    final monthName = DateFormat.yMMMM().format(_viewMonth);
    final firstDay = DateTime(_viewMonth.year, _viewMonth.month, 1);
    final daysInMonth =
        DateTime(_viewMonth.year, _viewMonth.month + 1, 0).day;
    final leadingEmpty = firstDay.weekday % 7;

    final periodDays = widget.lastStart.isNotEmpty
        ? buildPeriodDays(
            lastStart: widget.lastStart,
            cycleLen: widget.cycleLen,
            periodLen: widget.periodLen,
          )
        : <String>{};

    final fertileDays = widget.lastStart.isNotEmpty
        ? buildFertileDays(
            lastStart: widget.lastStart,
            cycleLen: widget.cycleLen,
          )
        : <String>{};

    return CeloraPage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CeloraPageTitle(title: 'Cycle tracker'),
          const SizedBox(height: 16),
          CeloraCard(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _navButton('‹', () => _changeMonth(-1)),
                    Text(
                      monthName,
                      style: CeloraStyles.serif(
                        fontWeight: FontWeight.w700,
                        color: CeloraColors.ink,
                      ),
                    ),
                    _navButton('›', () => _changeMonth(1)),
                  ],
                ),
                const SizedBox(height: 14),
                Row(
                  children: ['S', 'M', 'T', 'W', 'T', 'F', 'S']
                      .map(
                        (day) => Expanded(
                          child: Center(
                            child: Text(
                              day,
                              style: CeloraStyles.sans(
                                fontSize: 10.5,
                                fontWeight: FontWeight.w700,
                                color: CeloraColors.mute,
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 6),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                  ),
                  itemCount: leadingEmpty + daysInMonth,
                  itemBuilder: (context, index) {
                    if (index < leadingEmpty) {
                      return const SizedBox.shrink();
                    }

                    final dayNumber = index - leadingEmpty + 1;
                    final date = DateTime(
                      _viewMonth.year,
                      _viewMonth.month,
                      dayNumber,
                    );
                    final key = dateKey(date);
                    final isToday = dateOnly(date) == today;
                    final isPeriod = periodDays.contains(key);
                    final isFertile = fertileDays.contains(key);

                    Color background = Colors.transparent;
                    Color textColor = CeloraColors.ink;
                    Color borderColor = Colors.transparent;

                    if (isPeriod) {
                      background = CeloraColors.dark;
                      textColor = Colors.white;
                    } else if (isFertile) {
                      background = CeloraColors.pale;
                      textColor = CeloraColors.dark;
                    }

                    if (isToday) {
                      borderColor = CeloraColors.mid;
                    }

                    return Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: background,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: borderColor, width: 2),
                      ),
                      child: Text(
                        '$dayNumber',
                        style: CeloraStyles.sans(
                          fontSize: 12.5,
                          fontWeight:
                              isPeriod ? FontWeight.w700 : FontWeight.w500,
                          color: textColor,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          CeloraCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CeloraCardTitle(title: 'Legend'),
                const SizedBox(height: 12),
                const LegendItem(
                  color: CeloraColors.dark,
                  label: 'Predicted period days',
                ),
                const SizedBox(height: 10),
                const LegendItem(
                  color: CeloraColors.pale,
                  label: 'Fertile window (estimated)',
                ),
                const SizedBox(height: 10),
                const LegendItem(
                  color: Colors.transparent,
                  borderColor: CeloraColors.mid,
                  label: 'Today',
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 14),
                  child: Text(
                    'Predictions assume a ${widget.cycleLen}-day cycle and ${widget.periodLen}-day period. They improve as you log real dates.',
                    style: CeloraStyles.sans(
                      fontSize: 11.5,
                      color: CeloraColors.mute,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _navButton(String label, VoidCallback onTap) {
    return Material(
      color: CeloraColors.pale,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: SizedBox(
          width: 32,
          height: 32,
          child: Center(
            child: Text(
              label,
              style: CeloraStyles.sans(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: CeloraColors.dark,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
