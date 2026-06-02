import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_provider.dart';
import '../theme/celora_colors.dart';
import '../theme/celora_styles.dart';
import '../utils/celora_constants.dart';
import 'home_screen.dart';
import 'impact_screen.dart';
import 'onboarding_screen.dart';
import 'profile_screen.dart';
import 'shop_screen.dart';
import 'tracker_screen.dart';

class MainShell extends StatelessWidget {
  const MainShell({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, app, _) {
        if (!app.hasProfile) {
          return OnboardingScreen(onDone: app.completeOnboarding);
        }

        final profile = app.profile!;

        final screens = <String, Widget>{
          'home': HomeScreen(
            profile: profile,
            mix: app.mix,
            prediction: app.cyclePrediction,
            impact: app.impact,
          ),
          'tracker': TrackerScreen(
            cycleLen: cycleLengthDays,
            periodLen: app.periodLen,
            lastStart: profile.lastStart,
          ),
          'shop': ShopScreen(
            mix: app.mix,
            owned: app.owned,
            onPurchase: app.handlePurchase,
          ),
          'impact': ImpactScreen(impact: app.impact),
          'profile': ProfileScreen(
            profile: profile,
            mix: app.mix,
            onReset: app.resetProfile,
          ),
        };

        return Scaffold(
          backgroundColor: CeloraColors.paler,
          body: SafeArea(
            child: IndexedStack(
              index: appTabs.indexWhere((tab) => tab.$1 == app.tab),
              children: appTabs.map((tab) => screens[tab.$1]!).toList(),
            ),
          ),
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: CeloraColors.pale),
              ),
            ),
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: appTabs.map((tab) {
                    final selected = app.tab == tab.$1;
                    return Expanded(
                      child: InkWell(
                        onTap: () => app.setTab(tab.$1),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                tab.$3,
                                style: TextStyle(
                                  fontSize: 19,
                                  color: selected
                                      ? CeloraColors.dark
                                      : CeloraColors.mute.withValues(alpha: 0.7),
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                tab.$2,
                                style: CeloraStyles.sans(
                                  fontSize: 10,
                                  fontWeight:
                                      selected ? FontWeight.w700 : FontWeight.w500,
                                  color: selected
                                      ? CeloraColors.dark
                                      : CeloraColors.mute,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
