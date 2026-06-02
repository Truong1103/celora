import 'package:flutter/foundation.dart';

import '../models/celora_models.dart';
import '../utils/celora_constants.dart';
import '../utils/celora_helpers.dart';

class AppProvider extends ChangeNotifier {
  UserProfile? _profile;
  String _tab = 'home';
  SubscriptionPlan? _owned;
  int _purchases = 0;

  UserProfile? get profile => _profile;
  String get tab => _tab;
  SubscriptionPlan? get owned => _owned;
  int get purchases => _purchases;

  bool get hasProfile => _profile != null;

  PadMix get mix {
    if (_profile == null) {
      return const PadMix(red: 4, yellow: 4, green: 4);
    }
    return computeMix(_profile!.flow, _profile!.length);
  }

  int get periodLen => periodLengthForProfile(_profile?.length);

  CyclePrediction get cyclePrediction =>
      computeCyclePrediction(_profile?.lastStart, cycleLen: cycleLengthDays);

  ImpactStats get impact => computeImpact(purchases: _purchases, owned: _owned);

  void completeOnboarding(UserProfile profile) {
    _profile = profile;
    _tab = 'home';
    notifyListeners();
  }

  void setTab(String tab) {
    if (_tab == tab) return;
    _tab = tab;
    notifyListeners();
  }

  void handlePurchase(CheckoutItem checkout) {
    if (checkout.type == 'sub') {
      _owned = checkout.plan;
    }
    _purchases++;
    _tab = 'impact';
    notifyListeners();
  }

  void resetProfile() {
    _profile = null;
    _tab = 'home';
    _owned = null;
    _purchases = 0;
    notifyListeners();
  }
}
