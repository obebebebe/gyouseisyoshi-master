import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../data/models/license_type.dart';
import '../../data/models/premium_status.dart';
import '../../presentation/screens/splash/splash_screen.dart';
import '../../presentation/screens/home/home_screen.dart';
import '../../presentation/screens/menu/learning_menu_screen.dart';
import '../../presentation/screens/quiz/multiple_choice_screen.dart';
import '../../presentation/screens/quiz/true_false_screen.dart';
import '../../presentation/screens/quiz/category_study_screen.dart';
import '../../presentation/screens/quiz/weakness_screen.dart';
import '../../presentation/screens/quiz/simulation_screen.dart';
import '../../presentation/screens/result/result_screen.dart';
import '../../presentation/screens/result/simulation_result_screen.dart';
import '../../presentation/screens/stats/stats_screen.dart';
import '../../presentation/screens/settings/settings_screen.dart';
import '../../presentation/screens/purchase/purchase_screen.dart';

/// アプリケーションのルーター定義
class AppRouter {
  AppRouter._();

  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>();

  static GoRouter get router => _router;

  /// 無効なルートパラメータ用のエラー画面
  static Widget _buildInvalidRouteScreen(BuildContext context, String message) {
    return Scaffold(
      appBar: AppBar(title: const Text('エラー')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.orange),
            const SizedBox(height: 16),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go('/home'),
              child: const Text('ホームへ戻る'),
            ),
          ],
        ),
      ),
    );
  }

  static final GoRouter _router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    debugLogDiagnostics: true,
    routes: [
      // スプラッシュ画面
      GoRoute(
        path: '/',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),

      // ホーム画面（BottomNavigationBar付き）
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),

      // 統計画面
      GoRoute(
        path: '/stats',
        name: 'stats',
        builder: (context, state) => const StatsScreen(),
      ),

      // 設定画面
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) => const SettingsScreen(),
      ),

      // プレミアム購入画面
      GoRoute(
        path: '/purchase',
        name: 'purchase',
        builder: (context, state) => const PurchaseScreen(),
      ),

      // 学習メニュー画面
      GoRoute(
        path: '/menu/:type',
        name: 'menu',
        builder: (context, state) {
          final typeId = state.pathParameters['type'];
          if (typeId == null) {
            return _buildInvalidRouteScreen(context, '科目が指定されていません');
          }
          final licenseType = LicenseType.fromId(typeId);
          if (licenseType == null) {
            return _buildInvalidRouteScreen(context, '無効な科目: $typeId');
          }
          return LearningMenuScreen(licenseType: licenseType);
        },
      ),

      // 択一問題クイズ
      GoRoute(
        path: '/quiz/multiple/:type',
        name: 'quiz-multiple',
        builder: (context, state) {
          final typeId = state.pathParameters['type'];
          if (typeId == null) {
            return _buildInvalidRouteScreen(context, '科目が指定されていません');
          }
          final licenseType = LicenseType.fromId(typeId);
          if (licenseType == null) {
            return _buildInvalidRouteScreen(context, '無効な科目: $typeId');
          }
          return MultipleChoiceScreen(licenseType: licenseType);
        },
      ),

      // 一問一答クイズ
      GoRoute(
        path: '/quiz/truefalse/:type',
        name: 'quiz-truefalse',
        builder: (context, state) {
          final typeId = state.pathParameters['type'];
          if (typeId == null) {
            return _buildInvalidRouteScreen(context, '科目が指定されていません');
          }
          final licenseType = LicenseType.fromId(typeId);
          if (licenseType == null) {
            return _buildInvalidRouteScreen(context, '無効な科目: $typeId');
          }
          return TrueFalseScreen(licenseType: licenseType);
        },
      ),

      // カテゴリ別学習
      GoRoute(
        path: '/quiz/category/:type',
        name: 'quiz-category',
        builder: (context, state) {
          final typeId = state.pathParameters['type'];
          if (typeId == null) {
            return _buildInvalidRouteScreen(context, '科目が指定されていません');
          }
          final licenseType = LicenseType.fromId(typeId);
          if (licenseType == null) {
            return _buildInvalidRouteScreen(context, '無効な科目: $typeId');
          }
          final category = state.uri.queryParameters['category'];
          return CategoryStudyScreen(
            licenseType: licenseType,
            category: category,
          );
        },
      ),

      // 弱点克服モード
      GoRoute(
        path: '/quiz/weakness/:type',
        name: 'quiz-weakness',
        builder: (context, state) {
          final typeId = state.pathParameters['type'];
          if (typeId == null) {
            return _buildInvalidRouteScreen(context, '科目が指定されていません');
          }
          final licenseType = LicenseType.fromId(typeId);
          if (licenseType == null) {
            return _buildInvalidRouteScreen(context, '無効な科目: $typeId');
          }
          return WeaknessScreen(licenseType: licenseType);
        },
      ),

      // 模擬試験
      GoRoute(
        path: '/quiz/simulation/:type',
        name: 'quiz-simulation',
        builder: (context, state) {
          final typeId = state.pathParameters['type'];
          if (typeId == null) {
            return _buildInvalidRouteScreen(context, '科目が指定されていません');
          }
          final licenseType = LicenseType.fromId(typeId);
          if (licenseType == null) {
            return _buildInvalidRouteScreen(context, '無効な科目: $typeId');
          }
          final isHalf = state.uri.queryParameters['half'] == 'true';
          return SimulationScreen(
            licenseType: licenseType,
            isHalfMode: isHalf,
          );
        },
      ),

      // 結果画面
      GoRoute(
        path: '/result/:type',
        name: 'result',
        builder: (context, state) {
          final typeId = state.pathParameters['type'];
          if (typeId == null) {
            return _buildInvalidRouteScreen(context, '科目が指定されていません');
          }
          final licenseType = LicenseType.fromId(typeId);
          if (licenseType == null) {
            return _buildInvalidRouteScreen(context, '無効な科目: $typeId');
          }
          final mode = state.extra as QuizMode?;
          return ResultScreen(
            licenseType: licenseType,
            quizMode: mode ?? QuizMode.multipleChoice,
          );
        },
      ),

      // 模擬試験結果画面
      GoRoute(
        path: '/result/simulation/:type',
        name: 'result-simulation',
        builder: (context, state) {
          final typeId = state.pathParameters['type'];
          if (typeId == null) {
            return _buildInvalidRouteScreen(context, '科目が指定されていません');
          }
          final licenseType = LicenseType.fromId(typeId);
          if (licenseType == null) {
            return _buildInvalidRouteScreen(context, '無効な科目: $typeId');
          }
          final isHalf = state.uri.queryParameters['half'] == 'true';
          return SimulationResultScreen(
            licenseType: licenseType,
            isHalfMode: isHalf,
          );
        },
      ),
    ],

    // エラーページ
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('エラー')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text('ページが見つかりません: ${state.uri}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go('/home'),
              child: const Text('ホームへ戻る'),
            ),
          ],
        ),
      ),
    ),
  );
}
