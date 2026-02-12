import 'dart:math';
import '../models/question.dart';
import '../models/license_type.dart';
import '../datasources/json_loader.dart';

/// 問題データリポジトリ
class QuestionRepository {
  QuestionRepository._();

  static final QuestionRepository _instance = QuestionRepository._();
  static QuestionRepository get instance => _instance;

  final Random _random = Random();

  /// 指定科目の全問題を取得
  Future<List<Question>> getAllQuestions(LicenseType licenseType) async {
    final data = await JsonLoader.loadQuestions(licenseType);
    return data.questions;
  }

  /// ランダムに指定数の問題を取得
  Future<List<Question>> getRandomQuestions(
    LicenseType licenseType, {
    required int count,
  }) async {
    final questions = await getAllQuestions(licenseType);
    if (questions.isEmpty) return [];

    final shuffled = List<Question>.from(questions)..shuffle(_random);
    return shuffled.take(count).toList();
  }

  /// カテゴリ別に問題を取得
  Future<List<Question>> getQuestionsByCategory(
    LicenseType licenseType,
    String category, {
    int? count,
  }) async {
    final questions = await getAllQuestions(licenseType);
    final filtered = questions.where((q) => q.category == category).toList();

    if (count == null || count >= filtered.length) {
      return filtered;
    }

    final shuffled = List<Question>.from(filtered)..shuffle(_random);
    return shuffled.take(count).toList();
  }

  /// 弱点カテゴリから問題を取得
  Future<List<Question>> getWeaknessQuestions(
    LicenseType licenseType,
    List<String> weakCategories, {
    required int count,
  }) async {
    final questions = await getAllQuestions(licenseType);

    // 弱点カテゴリの問題を抽出
    final weakQuestions = questions
        .where((q) => weakCategories.contains(q.category))
        .toList();

    if (weakQuestions.isEmpty) {
      // 弱点がなければランダムに取得
      return getRandomQuestions(licenseType, count: count);
    }

    final shuffled = List<Question>.from(weakQuestions)..shuffle(_random);
    return shuffled.take(count).toList();
  }

  /// 模擬試験用の問題を取得（本番と同じ配分）
  Future<List<Question>> getSimulationQuestions(
    LicenseType licenseType, {
    required int totalCount,
  }) async {
    // 全科目から問題を取得
    final allQuestions = <Question>[];

    for (final type in LicenseType.values) {
      try {
        final questions = await getAllQuestions(type);
        allQuestions.addAll(questions);
      } catch (_) {
        // データがない科目はスキップ
      }
    }

    if (allQuestions.isEmpty) return [];

    // シャッフルして指定数を取得
    final shuffled = List<Question>.from(allQuestions)..shuffle(_random);
    return shuffled.take(totalCount).toList();
  }

  /// 難易度別に問題を取得
  Future<List<Question>> getQuestionsByDifficulty(
    LicenseType licenseType,
    int difficulty, {
    int? count,
  }) async {
    final questions = await getAllQuestions(licenseType);
    final filtered = questions.where((q) => q.difficulty == difficulty).toList();

    if (count == null || count >= filtered.length) {
      return filtered;
    }

    final shuffled = List<Question>.from(filtered)..shuffle(_random);
    return shuffled.take(count).toList();
  }

  /// 全科目のカテゴリ一覧を取得
  Future<Map<LicenseType, List<String>>> getAllCategories() async {
    final result = <LicenseType, List<String>>{};

    for (final licenseType in LicenseType.values) {
      try {
        final questions = await getAllQuestions(licenseType);
        final categories = questions.map((q) => q.category).toSet().toList();
        result[licenseType] = categories;
      } catch (_) {
        result[licenseType] = [];
      }
    }

    return result;
  }

  /// 科目の問題数を取得
  Future<int> getQuestionCount(LicenseType licenseType) async {
    try {
      final questions = await getAllQuestions(licenseType);
      return questions.length;
    } catch (_) {
      return 0;
    }
  }
}
