import 'package:flutter/material.dart';

/// アプリケーションのカラーパレット
class AppColors {
  AppColors._();

  // メインカラー（行政書士のイメージに合わせた紺色系）
  static const Color primary = Color(0xFF1A237E); // インディゴ
  static const Color primaryLight = Color(0xFF534BAE);
  static const Color primaryDark = Color(0xFF000051);

  // アクセントカラー
  static const Color accent = Color(0xFFFF6F00); // アンバー
  static const Color accentLight = Color(0xFFFFA040);
  static const Color accentDark = Color(0xFFC43E00);

  // セマンティックカラー
  static const Color success = Color(0xFF4CAF50); // 正解・合格
  static const Color warning = Color(0xFFFFC107); // 注意・警告
  static const Color error = Color(0xFFF44336); // 不正解・不合格
  static const Color info = Color(0xFF2196F3); // 情報

  // 背景色
  static const Color background = Color(0xFFF5F5F5);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color cardBackground = Color(0xFFFFFFFF);

  // テキストカラー
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textHint = Color(0xFFBDBDBD);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // 科目別カラー
  static const Color constitution = Color(0xFF1976D2); // 憲法 - 青
  static const Color administrativeLaw = Color(0xFF388E3C); // 行政法 - 緑
  static const Color civilLaw = Color(0xFFF57C00); // 民法 - オレンジ
  static const Color commercialLaw = Color(0xFF7B1FA2); // 商法 - 紫
  static const Color generalKnowledge = Color(0xFF00796B); // 一般知識 - ティール

  // 難易度別カラー
  static const Color difficultyEasy = Color(0xFF81C784);
  static const Color difficultyMedium = Color(0xFFFFB74D);
  static const Color difficultyHard = Color(0xFFE57373);

  // グラデーション
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient premiumGradient = LinearGradient(
    colors: [Color(0xFFFFD700), Color(0xFFFFA000)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
