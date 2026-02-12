import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';

/// 試験科目の種別
enum LicenseType {
  constitution('憲法', 'constitution'),
  administrativeLaw('行政法', 'administrative_law'),
  civilLaw('民法', 'civil_law'),
  commercialLaw('商法・会社法', 'commercial_law'),
  generalKnowledge('一般知識', 'general_knowledge');

  const LicenseType(this.displayName, this.id);

  final String displayName;
  final String id;

  /// 科目に対応するアイコン
  IconData get icon {
    switch (this) {
      case LicenseType.constitution:
        return Icons.account_balance;
      case LicenseType.administrativeLaw:
        return Icons.gavel;
      case LicenseType.civilLaw:
        return Icons.people;
      case LicenseType.commercialLaw:
        return Icons.business;
      case LicenseType.generalKnowledge:
        return Icons.school;
    }
  }

  /// 科目に対応する絵文字
  String get emoji {
    switch (this) {
      case LicenseType.constitution:
        return '🏛️';
      case LicenseType.administrativeLaw:
        return '⚖️';
      case LicenseType.civilLaw:
        return '👥';
      case LicenseType.commercialLaw:
        return '🏢';
      case LicenseType.generalKnowledge:
        return '📚';
    }
  }

  /// 科目に対応するカラー
  Color get color {
    switch (this) {
      case LicenseType.constitution:
        return AppColors.constitution;
      case LicenseType.administrativeLaw:
        return AppColors.administrativeLaw;
      case LicenseType.civilLaw:
        return AppColors.civilLaw;
      case LicenseType.commercialLaw:
        return AppColors.commercialLaw;
      case LicenseType.generalKnowledge:
        return AppColors.generalKnowledge;
    }
  }

  /// 科目の簡単な説明
  String get description {
    switch (this) {
      case LicenseType.constitution:
        return '国家の基本法、人権保障、統治機構';
      case LicenseType.administrativeLaw:
        return '行政手続法、行政不服審査法、行政事件訴訟法など';
      case LicenseType.civilLaw:
        return '総則、物権、債権、親族、相続';
      case LicenseType.commercialLaw:
        return '商法総則、会社法';
      case LicenseType.generalKnowledge:
        return '政治・経済・社会、情報通信、文章理解';
    }
  }

  /// 本番試験での問題数（目安）
  int get examQuestionCount {
    switch (this) {
      case LicenseType.constitution:
        return 6;
      case LicenseType.administrativeLaw:
        return 22;
      case LicenseType.civilLaw:
        return 11;
      case LicenseType.commercialLaw:
        return 5;
      case LicenseType.generalKnowledge:
        return 14;
    }
  }

  /// IDから種別を取得
  static LicenseType? fromId(String id) {
    try {
      return LicenseType.values.firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
  }
}
