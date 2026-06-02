class PadMix {
  final int red;
  final int yellow;
  final int green;

  const PadMix({
    required this.red,
    required this.yellow,
    required this.green,
  });

  int get total => red + yellow + green;

  PadMix copyWith({int? red, int? yellow, int? green}) {
    return PadMix(
      red: red ?? this.red,
      yellow: yellow ?? this.yellow,
      green: green ?? this.green,
    );
  }
}

class FlowType {
  final String key;
  final String name;
  final String sub;
  final int dotColorValue;

  const FlowType({
    required this.key,
    required this.name,
    required this.sub,
    required this.dotColorValue,
  });
}

class UserProfile {
  final String name;
  final String flow;
  final String length;
  final String lastStart;

  const UserProfile({
    required this.name,
    required this.flow,
    required this.length,
    required this.lastStart,
  });
}

class SubscriptionPlan {
  final String id;
  final String label;
  final int price;
  final String per;
  final String billed;
  final String? save;

  const SubscriptionPlan({
    required this.id,
    required this.label,
    required this.price,
    required this.per,
    required this.billed,
    this.save,
  });
}

class CheckoutItem {
  final String type;
  final SubscriptionPlan plan;

  const CheckoutItem({
    required this.type,
    required this.plan,
  });
}

class ImpactStats {
  final int padsReplaced;
  final int plasticAvoided;
  final int socialFund;
  final int girlsReached;

  const ImpactStats({
    required this.padsReplaced,
    required this.plasticAvoided,
    required this.socialFund,
    required this.girlsReached,
  });
}

class CyclePrediction {
  final DateTime? nextDate;
  final int? daysUntil;

  const CyclePrediction({
    this.nextDate,
    this.daysUntil,
  });
}
