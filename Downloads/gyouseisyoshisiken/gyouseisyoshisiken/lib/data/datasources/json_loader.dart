import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import '../models/question.dart';
import '../models/license_type.dart';

/// JSON データローダー
class JsonLoader {
  JsonLoader._();

  static final Map<String, QuestionData> _cache = {};

  /// 科目の問題データを読み込み
  static Future<QuestionData> loadQuestions(LicenseType licenseType) async {
    // キャッシュチェック
    if (_cache.containsKey(licenseType.id)) {
      return _cache[licenseType.id]!;
    }

    // アセットから読み込み
    final jsonString = await rootBundle.loadString(
      'assets/data/questions_${licenseType.id}.json',
    );
    final jsonData = jsonDecode(jsonString) as Map<String, dynamic>;
    final questionData = QuestionData.fromJson(jsonData);

    // キャッシュに保存
    _cache[licenseType.id] = questionData;

    return questionData;
  }

  /// 全科目の問題データを読み込み
  static Future<Map<LicenseType, QuestionData>> loadAllQuestions() async {
    final result = <LicenseType, QuestionData>{};

    for (final licenseType in LicenseType.values) {
      try {
        result[licenseType] = await loadQuestions(licenseType);
      } catch (e, stackTrace) {
        // 問題データが存在しない場合はスキップ
        debugPrint('Failed to load questions for ${licenseType.id}: $e');
        debugPrint('Stack trace: $stackTrace');
      }
    }

    return result;
  }

  /// キャッシュをクリア
  static void clearCache() {
    _cache.clear();
  }

  /// 特定科目のキャッシュをクリア
  static void clearCacheFor(LicenseType licenseType) {
    _cache.remove(licenseType.id);
  }
}
