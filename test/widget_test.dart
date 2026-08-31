import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart';
import 'package:game/models/levels_data.dart';
import 'package:game/screens/game_screen.dart';
import 'package:game/screens/shop_screen.dart';
import 'package:game/utils/app_strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
    AppStrings.init();
  });

  testWidgets('CyberHex app splash screen launch test', (WidgetTester tester) async {
    await tester.pumpWidget(const CyberHexApp());
    expect(find.text(AppStrings.appTitle), findsOneWidget);
    expect(find.text(AppStrings.systemInitializing), findsOneWidget);
  });

  testWidgets('ShopScreen responsive rendering test without overflow', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(320, 600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(
      const MaterialApp(
        home: ShopScreen(),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text(AppStrings.systemUpgrades), findsOneWidget);
    expect(find.text(AppStrings.upgradeName('ram')), findsOneWidget);
  });

  testWidgets('Stage 10 GameScreen responsive auto-fit test', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(360, 640);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    final levels = LevelsData.getLevels();
    final stage10 = levels.firstWhere((l) => l.id == 10);

    await tester.pumpWidget(
      MaterialApp(
        home: GameScreen(level: stage10),
      ),
    );

    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('Stage 10'), findsOneWidget);
  });
}
