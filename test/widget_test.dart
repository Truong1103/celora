import 'package:flutter_test/flutter_test.dart';
import 'package:celora/app.dart';

void main() {
  testWidgets('Celora app launches onboarding', (tester) async {
    await tester.pumpWidget(const CeloraApp());
    await tester.pumpAndSettle();

    expect(find.text('Welcome to Celora'), findsOneWidget);
    expect(find.text('CELORA'), findsOneWidget);
  });
}
