// 行政書士マスター2026 ウィジェットテスト

import 'package:flutter_test/flutter_test.dart';
import 'package:gyouseisyoshi_master/app.dart';

void main() {
  testWidgets('MyApp smoke test', (WidgetTester tester) async {
    // MyApp が正常にビルドできることを確認
    await tester.pumpWidget(const MyApp());
    // スプラッシュスクリーンが表示されるまで待機
    await tester.pump(const Duration(milliseconds: 100));
  });
}
