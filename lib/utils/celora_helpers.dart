import '../models/celora_models.dart';
import 'celora_constants.dart';

String formatVnd(int n) {
  final formatted = n.toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (match) => '${match[1]},',
      );
  return '$formatted₫';
}

PadMix computeMix(String flow, String length) {
  var mix = const PadMix(red: 4, yellow: 4, green: 4);

  switch (flow) {
    case 'heavy':
      mix = const PadMix(red: 6, yellow: 4, green: 2);
      break;
    case 'medium':
      mix = const PadMix(red: 4, yellow: 5, green: 3);
      break;
    case 'light':
      mix = const PadMix(red: 2, yellow: 4, green: 6);
      break;
  }

  if (length == 'long') {
    mix = mix.copyWith(red: mix.red + 1, green: mix.green - 1);
  } else if (length == 'short') {
    mix = mix.copyWith(
      green: mix.green + 1,
      red: mix.red > 1 ? mix.red - 1 : 1,
    );
  }

  var total = mix.total;
  var red = mix.red;
  var yellow = mix.yellow;
  var green = mix.green;

  while (total > 12) {
    if (green > yellow) {
      green--;
    } else {
      yellow--;
    }
    total--;
  }

  while (total < 12) {
    yellow++;
    total++;
  }

  return PadMix(red: red, yellow: yellow, green: green);
}

CyclePrediction computeCyclePrediction(String? lastStart, {int cycleLen = 28}) {
  if (lastStart == null || lastStart.isEmpty) {
    return const CyclePrediction();
  }

  final start = DateTime.parse(lastStart);
  final today = DateTime.now();
  final todayMidnight = DateTime(today.year, today.month, today.day);

  var next = DateTime(start.year, start.month, start.day);
  while (next.isBefore(todayMidnight)) {
    next = next.add(Duration(days: cycleLen));
  }

  final days = next.difference(todayMidnight).inDays;
  return CyclePrediction(nextDate: next, daysUntil: days);
}

int periodLengthForProfile(String? length) {
  switch (length) {
    case 'short':
      return 4;
    case 'long':
      return 7;
    default:
      return 5;
  }
}

ImpactStats computeImpact({
  required int purchases,
  SubscriptionPlan? owned,
}) {
  final packs = 3 + purchases * 3;
  final spend = 3 * dailyPackPrice + purchases * (owned?.price ?? 150000);

  return ImpactStats(
    padsReplaced: packs * 12,
    plasticAvoided: packs * 48,
    socialFund: (spend * 0.01).round(),
    girlsReached: [
      ((spend * 0.01) / 10000000 * 120).round() + purchases * 4 + 6,
      1,
    ].reduce((a, b) => a > b ? a : b),
  );
}

Set<String> buildPeriodDays({
  required String lastStart,
  required int cycleLen,
  required int periodLen,
  int cycles = 6,
}) {
  final periodDays = <String>{};
  final start = DateTime.parse(lastStart);

  for (var c = 0; c < cycles; c++) {
    final cycleStart = start.add(Duration(days: c * cycleLen));
    for (var d = 0; d < periodLen; d++) {
      final day = cycleStart.add(Duration(days: d));
      periodDays.add(dateKey(day));
    }
  }

  return periodDays;
}

Set<String> buildFertileDays({
  required String lastStart,
  required int cycleLen,
  int cycles = 6,
}) {
  final fertileDays = <String>{};
  final start = DateTime.parse(lastStart);

  for (var c = 0; c < cycles; c++) {
    final cycleStart = start.add(Duration(days: c * cycleLen));
    for (var d = 10; d < 16; d++) {
      final day = cycleStart.add(Duration(days: d));
      fertileDays.add(dateKey(day));
    }
  }

  return fertileDays;
}

String dateKey(DateTime date) {
  return dateOnly(date).toIso8601String();
}

DateTime dateOnly(DateTime date) {
  return DateTime(date.year, date.month, date.day);
}

String formatDisplayDate(DateTime date) {
  const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  const months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  final weekday = weekdays[date.weekday - 1];
  return '$weekday ${months[date.month - 1]} ${date.day} ${date.year}';
}
