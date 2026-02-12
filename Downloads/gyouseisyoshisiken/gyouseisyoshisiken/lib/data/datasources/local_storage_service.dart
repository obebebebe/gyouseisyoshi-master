import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/app_constants.dart';
import '../models/premium_status.dart';
import '../models/user_progress.dart';

/// ローカルストレージサービス（SharedPreferencesのシングルトンラッパー）
class LocalStorageService {
  LocalStorageService._();

  static LocalStorageService? _instance;
  static SharedPreferences? _prefs;

  /// シングルトンインスタンスを取得
  static Future<LocalStorageService> getInstance() async {
    _instance ??= LocalStorageService._();
    _prefs ??= await SharedPreferences.getInstance();
    return _instance!;
  }

  /// プレミアム状態を保存
  Future<void> savePremiumStatus(PremiumStatus status) async {
    final json = jsonEncode(status.toJson());
    await _prefs!.setString(AppConstants.keyPremiumStatus, json);
  }

  /// プレミアム状態を読み込み
  PremiumStatus loadPremiumStatus() {
    final json = _prefs!.getString(AppConstants.keyPremiumStatus);
    if (json == null) {
      return const PremiumStatus();
    }
    try {
      return PremiumStatus.fromJson(jsonDecode(json));
    } catch (e, stackTrace) {
      debugPrint('Error loading premium status: $e');
      debugPrint('Stack trace: $stackTrace');
      return const PremiumStatus();
    }
  }

  /// 学習進捗を保存
  Future<void> saveUserProgress(String licenseType, UserProgress progress) async {
    final key = '${AppConstants.keyUserProgress}_$licenseType';
    final json = jsonEncode(progress.toJson());
    await _prefs!.setString(key, json);
  }

  /// 学習進捗を読み込み
  UserProgress loadUserProgress(String licenseType) {
    final key = '${AppConstants.keyUserProgress}_$licenseType';
    final json = _prefs!.getString(key);
    if (json == null) {
      return UserProgress(licenseType: licenseType);
    }
    try {
      return UserProgress.fromJson(jsonDecode(json));
    } catch (e, stackTrace) {
      debugPrint('Error loading user progress for $licenseType: $e');
      debugPrint('Stack trace: $stackTrace');
      return UserProgress(licenseType: licenseType);
    }
  }

  /// 全科目の進捗を読み込み
  Map<String, UserProgress> loadAllProgress() {
    final result = <String, UserProgress>{};
    final keys = _prefs!.getKeys();

    for (final key in keys) {
      if (key.startsWith('${AppConstants.keyUserProgress}_')) {
        final licenseType = key.replaceFirst('${AppConstants.keyUserProgress}_', '');
        result[licenseType] = loadUserProgress(licenseType);
      }
    }
    return result;
  }

  /// 最終学習日を保存
  Future<void> saveLastStudyDate(DateTime date) async {
    await _prefs!.setString(
      AppConstants.keyLastStudyDate,
      date.toIso8601String(),
    );
  }

  /// 最終学習日を読み込み
  DateTime? loadLastStudyDate() {
    final dateStr = _prefs!.getString(AppConstants.keyLastStudyDate);
    if (dateStr == null) return null;
    try {
      return DateTime.parse(dateStr);
    } catch (e, stackTrace) {
      debugPrint('Error parsing last study date: $e');
      debugPrint('Stack trace: $stackTrace');
      return null;
    }
  }

  /// 連続日数を保存
  Future<void> saveConsecutiveDays(int days) async {
    await _prefs!.setInt(AppConstants.keyConsecutiveDays, days);
  }

  /// 連続日数を読み込み
  int loadConsecutiveDays() {
    return _prefs!.getInt(AppConstants.keyConsecutiveDays) ?? 0;
  }

  /// レガシーマイグレーション済みフラグを保存
  Future<void> saveLegacyMigrated(bool migrated) async {
    await _prefs!.setBool(AppConstants.keyLegacyMigrated, migrated);
  }

  /// レガシーマイグレーション済みフラグを読み込み
  bool loadLegacyMigrated() {
    return _prefs!.getBool(AppConstants.keyLegacyMigrated) ?? false;
  }

  /// 全データをクリア（デバッグ用）
  Future<void> clearAll() async {
    await _prefs!.clear();
  }

  /// 特定のキーを削除
  Future<void> remove(String key) async {
    await _prefs!.remove(key);
  }
}
