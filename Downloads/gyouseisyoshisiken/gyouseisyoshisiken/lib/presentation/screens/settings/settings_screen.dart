import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/colors.dart';
import '../../providers/purchase_provider.dart';
import '../../providers/progress_provider.dart';

/// 設定画面
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final purchaseProvider = context.watch<PurchaseProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('設定'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: ListView(
        children: [
          // プレミアム
          _buildSectionHeader('プレミアム'),
          _SettingsTile(
            icon: Icons.workspace_premium,
            iconColor: Colors.amber,
            title: 'プレミアムプラン',
            subtitle: purchaseProvider.isPremium
                ? 'プレミアム会員です'
                : 'アップグレードで全機能解放',
            trailing: purchaseProvider.isPremium
                ? const Chip(
                    label: Text('有効'),
                    backgroundColor: AppColors.success,
                    labelStyle: TextStyle(color: Colors.white),
                  )
                : null,
            onTap: () => context.push('/purchase'),
          ),

          // デバッグ（開発時のみ）
          if (kDebugMode) ...[
            _SettingsTile(
              icon: Icons.bug_report,
              iconColor: Colors.purple,
              title: 'プレミアム切り替え（デバッグ）',
              subtitle: purchaseProvider.isPremium ? 'ON' : 'OFF',
              trailing: Switch(
                value: purchaseProvider.isPremium,
                onChanged: (_) => purchaseProvider.debugTogglePremium(),
              ),
              onTap: () => purchaseProvider.debugTogglePremium(),
            ),
            _SettingsTile(
              icon: Icons.delete_forever,
              iconColor: Colors.red,
              title: '進捗をリセット（デバッグ）',
              subtitle: '全ての学習データを削除',
              onTap: () => _showResetDialog(context),
            ),
          ],

          const Divider(),

          // アプリ情報
          _buildSectionHeader('アプリ情報'),
          _SettingsTile(
            icon: Icons.info,
            iconColor: AppColors.info,
            title: 'バージョン',
            subtitle: AppConstants.appVersion,
          ),

          const Divider(),

          // サポート
          _buildSectionHeader('サポート'),
          _SettingsTile(
            icon: Icons.help,
            iconColor: AppColors.primary,
            title: 'ヘルプ・よくある質問',
            onTap: () => _showFaqDialog(context),
          ),
          _SettingsTile(
            icon: Icons.star_rate,
            iconColor: Colors.amber,
            title: 'アプリを評価する',
            onTap: () => _openPlayStore(),
          ),

          const Divider(),

          // 法的情報
          _buildSectionHeader('法的情報'),
          _SettingsTile(
            icon: Icons.description,
            iconColor: Colors.grey,
            title: '利用規約',
            onTap: () => _showTermsDialog(context),
          ),
          _SettingsTile(
            icon: Icons.privacy_tip,
            iconColor: Colors.grey,
            title: 'プライバシーポリシー',
            onTap: () => _showPrivacyDialog(context),
          ),
          _SettingsTile(
            icon: Icons.code,
            iconColor: Colors.grey,
            title: 'オープンソースライセンス',
            onTap: () => showLicensePage(
              context: context,
              applicationName: AppConstants.appName,
              applicationVersion: AppConstants.appVersion,
            ),
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),
      ),
    );
  }

  void _showFaqDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('よくある質問'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _FaqItem(
                question: 'Q. オフラインでも使えますか？',
                answer: 'A. はい、一度データをダウンロードすればオフラインでも学習できます。',
              ),
              _FaqItem(
                question: 'Q. プレミアムは何が違いますか？',
                answer: 'A. 弱点克服モード、本番模擬試験、ミニ模擬試験が利用可能になります。',
              ),
              _FaqItem(
                question: 'Q. 購入を復元したい',
                answer: 'A. プレミアム購入画面の「購入を復元」ボタンから復元できます。',
              ),
              _FaqItem(
                question: 'Q. データを引き継ぎたい',
                answer: 'A. 現在、データは端末に保存されており、クラウド同期には対応していません。',
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('閉じる'),
          ),
        ],
      ),
    );
  }

  void _showTermsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('利用規約'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                '行政書士マスター2026 利用規約\n',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Text(
                '第1条（適用）',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Text(
                '本規約は、本アプリの利用に関する条件を定めます。'
                'ユーザーは、本アプリをダウンロードまたは使用することにより、本規約に同意したものとみなされます。\n',
              ),
              const Text(
                '第2条（利用条件）',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Text(
                'ユーザーは、本規約に同意の上、自己の責任において本アプリを利用するものとします。\n',
              ),
              const Text(
                '第3条（禁止事項）',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Text(
                '・法令または公序良俗に違反する行為\n'
                '・本アプリの運営を妨害する行為\n'
                '・本アプリの逆コンパイル、リバースエンジニアリング等の行為\n'
                '・本アプリのコンテンツを無断で複製、転載、販売等する行為\n'
                '・他のユーザーに不利益、損害を与える行為\n',
              ),
              const Text(
                '第4条（アプリ内課金）',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Text(
                '本アプリには有料のプレミアム機能があります。'
                '購入はGoogle Play / App Storeの規約に従います。'
                '返金については各ストアの返金ポリシーに従います。\n',
              ),
              const Text(
                '第5条（知的財産権）',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Text(
                '本アプリに含まれるすべてのコンテンツの知的財産権は、運営者または正当な権利者に帰属します。\n',
              ),
              const Text(
                '第6条（免責事項）',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Text(
                '・本アプリは学習支援を目的としており、試験の合格を保証するものではありません。\n'
                '・法令改正等により内容が変更される場合があります。最新情報は公式の情報源をご確認ください。\n'
                '・運営者は、本アプリの利用により生じた損害について、故意または重過失がある場合を除き責任を負いません。\n',
              ),
              const Text(
                '第7条（サービスの変更・終了）',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Text(
                '運営者は、事前の通知なく本アプリの内容変更または提供終了ができるものとします。\n',
              ),
              const Text(
                '第8条（準拠法）',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Text(
                '本規約は日本法を準拠法とします。\n',
              ),
              const Text(
                '最終更新日: 2026年2月13日',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () async {
                  final uri = Uri.parse(AppConstants.termsUrl);
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri, mode: LaunchMode.externalApplication);
                  }
                },
                child: const Text(
                  '詳細な利用規約はこちら',
                  style: TextStyle(
                    color: Color(0xFF1A237E),
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('閉じる'),
          ),
        ],
      ),
    );
  }

  void _showPrivacyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('プライバシーポリシー'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                '行政書士マスター2026 プライバシーポリシー\n',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Text(
                '1. 収集する情報',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Text(
                '本アプリは、ユーザーの個人を特定できる情報（氏名、住所、電話番号、メールアドレス等）を収集しません。\n'
                '学習進捗データ（回答履歴、正答率、学習時間等）は端末内にのみ保存され、外部サーバーに送信されることはありません。\n',
              ),
              const Text(
                '2. 第三者サービスの利用',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Text(
                '・Google Fonts：フォント取得時にGoogleサーバーへの接続が発生し、IPアドレスが送信される可能性があります。\n'
                '・Google Play / App Store：アプリ内課金の決済処理に利用します。本アプリが決済情報を直接収集することはありません。\n',
              ),
              const Text(
                '3. 広告・アナリティクス',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Text(
                '本アプリは広告を表示せず、アナリティクスツールも使用していません。\n',
              ),
              const Text(
                '4. データの削除',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Text(
                '以下の方法でデータを削除できます。\n'
                '・アプリのアンインストール\n'
                '・端末の設定 → アプリ → 行政書士マスター2026 → ストレージ → データを消去\n'
                'データは端末内にのみ存在するため、削除後の復元はできません。\n',
              ),
              const Text(
                '5. 子どものプライバシー',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Text(
                '本アプリは13歳未満の子どもから意図的に個人情報を収集しません。\n',
              ),
              const Text(
                '6. お問い合わせ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Text(
                'メール: battleshiptubo2@gmail.com\n',
              ),
              const Text(
                '最終更新日: 2026年2月13日',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () async {
                  final uri = Uri.parse(AppConstants.privacyPolicyUrl);
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri, mode: LaunchMode.externalApplication);
                  }
                },
                child: const Text(
                  '詳細なプライバシーポリシーはこちら',
                  style: TextStyle(
                    color: Color(0xFF1A237E),
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('閉じる'),
          ),
        ],
      ),
    );
  }

  Future<void> _openPlayStore() async {
    final uri = Uri.parse(AppConstants.playStoreUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void _showResetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('進捗をリセット'),
        content: const Text('全ての学習データが削除されます。この操作は取り消せません。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('キャンセル'),
          ),
          TextButton(
            onPressed: () async {
              await context.read<ProgressProvider>().resetAllProgress();
              if (context.mounted) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('進捗をリセットしました')),
                );
              }
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('リセット'),
          ),
        ],
      ),
    );
  }
}

/// 設定タイル
class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _SettingsTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: iconColor.withAlpha(25),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: iconColor),
      ),
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      trailing: trailing ?? (onTap != null ? const Icon(Icons.chevron_right) : null),
      onTap: onTap,
    );
  }
}

/// FAQアイテム
class _FaqItem extends StatelessWidget {
  final String question;
  final String answer;

  const _FaqItem({
    required this.question,
    required this.answer,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            answer,
            style: TextStyle(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}
