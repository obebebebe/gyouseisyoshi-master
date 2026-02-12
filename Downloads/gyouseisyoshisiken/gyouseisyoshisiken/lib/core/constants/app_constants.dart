/// アプリケーション全体の定数
class AppConstants {
  AppConstants._();

  // アプリ情報
  static const String appName = '行政書士マスター2026';
  static const String appVersion = '1.0.0';

  // 問題数設定
  static const int defaultQuizCount = 10;
  static const int simulationFullQuestionCount = 60;
  static const int simulationHalfQuestionCount = 30;

  // 時間設定（分）
  static const int simulationFullTimeMinutes = 180;
  static const int simulationHalfTimeMinutes = 90;

  // 合格基準
  static const double passingRate = 0.6; // 行政書士試験は6割合格
  static const double weakCategoryThreshold = 0.6; // 弱点カテゴリの閾値

  // 課金商品ID
  static const String productIdMonthly = 'gyouseisyoshi_master_monthly';
  static const String productIdYearly = 'gyouseisyoshi_master_yearly';
  static const String productIdPremium = 'gyouseisyoshi_master_premium';

  // ストレージキー
  static const String keyPremiumStatus = 'premium_status';
  static const String keyUserProgress = 'user_progress';
  static const String keyLastStudyDate = 'last_study_date';
  static const String keyConsecutiveDays = 'consecutive_days';
  static const String keyLegacyMigrated = 'legacy_migrated';

  // 外部URL
  static const String playStoreUrl =
      'https://play.google.com/store/apps/details?id=com.gyouseisyoshi.master2026';
  // TODO: GitHub Pagesにデプロイ後、実際のURLに変更してください
  // 例: https://<あなたのユーザー名>.github.io/gyouseisyoshi-master/privacy-policy.html
  static const String privacyPolicyUrl =
      'https://yourusername.github.io/gyouseisyoshi-master/privacy-policy.html';
  // TODO: GitHub Pagesにデプロイ後、実際のURLに変更してください
  static const String termsUrl =
      'https://yourusername.github.io/gyouseisyoshi-master/terms.html';
}
