# 行政書士マスター2026 開発ガイド

> 詳細ルールは `.claude/rules/` に分割配置済み（自動読み込み）。

## プロジェクト概要

**プロジェクト名**: 行政書士マスター2026
**概要**: 行政書士試験対策アプリ（Flutter）

| カテゴリ | 技術 |
|---------|------|
| 言語 | Dart |
| フレームワーク | Flutter (Material 3) |
| 状態管理 | Provider (ChangeNotifier) |
| ルーティング | go_router |
| データ永続化 | SharedPreferences |
| モデル生成 | freezed + json_serializable |
| 課金 | in_app_purchase |
| テスト | flutter_test |

---

## 絶対遵守ルール（5原則）

### 0. 曖昧さの排除（最優先）
曖昧な要件は `AskUserQuestionTool` でヒアリングしてから作業開始。推測で実装しない。

### 1. 正直さ・誠実さ
嘘をつかない。わからないことは「わからない」と言う。エビデンスベースで回答。

### 2. ハードコーディング禁止
ビジネスロジックの判定をコードに埋め込むな。AI動的判定 or 設定ファイルを使用。
技術的定数(HTTP status等)と環境変数は許可。詳細は `.claude/rules/01-core-rules.md`。

### 3. データ層アクセス前にスキーマ確認
クエリを書く前に必ず `schema.prisma` 等のスキーマ定義を確認。推測でフィールド名を書かない。

### 4. 構造化データの原則
検索・集計するデータはJSON型ではなく個別カラムに。JSON型は不定構造データのみ。

---

## 開発フロー（オーケストレーターパターン）

マネージャーとして振る舞い、実装はSubAgentに委託。タスクは超細分化。

```
1. 要件確認 → 曖昧なら AskUserQuestionTool
2. Plan モード → Explore/Plan SubAgent
3. 軌道確認 → ユーザー承認
4. 実装 → TodoWrite + 専門SubAgent委託
5. TDD → @test-engineer
6. レビュー → @code-reviewer + @security-auditor
7. 完了 → CLAUDE.md記録
```

詳細は `.claude/rules/02-workflow.md`。

---

## NEVER / ALWAYS

**NEVER:**
- `--no-verify` でフックバイパス
- テスト無効化・スキップ
- 推測でコードを書く
- 3回同じ方法で失敗して続ける
- 応急処置（機能削除、try-catch握りつぶし、any キャスト等）
- 機密情報のハードコード

**ALWAYS:**
- 段階的にコミット、CLAUDE.md随時更新
- 3回失敗で再評価、外部入力は検証
- 問題解決できない場合はユーザーに報告
- 修正を受けたら失敗例をCLAUDE.mdに記録（自己学習）

詳細は `.claude/rules/07-prohibitions.md`。

---

## プロジェクト固有設定

### ディレクトリ構成
```
lib/
├── main.dart                    # エントリーポイント
├── app.dart                     # MaterialApp.router
├── core/
│   ├── constants/               # 定数（app_constants, colors）
│   ├── router/                  # GoRouter設定
│   └── theme/                   # Material 3テーマ
├── data/
│   ├── datasources/             # JSON読み込み、SharedPreferences
│   ├── models/                  # freezedモデル
│   └── repositories/            # データ取得ロジック
└── presentation/
    ├── providers/               # 状態管理
    ├── screens/                 # 画面
    └── widgets/                 # 共通ウィジェット

assets/
└── data/                        # 問題データJSON
```

### データ永続化
- **SharedPreferences のみ**（要件定義書に従う）
- クラウド同期・ログイン機能は不要

---

## 過去の失敗例と学び

### 要件にない機能を勝手に追加しようとした（2026-02-13）

**何をしたか:**
- ユーザーが「データベース設計はしなくていいのか？」と聞いた
- 私が勝手に「Supabaseを使った方がいい」と推奨
- Supabaseスキーマを設計し、認証情報を求め、ログイン機能まで提案した

**なぜ失敗したか:**
1. 要件定義書を確認せずに推奨した
2. ユーザーの質問を「依頼」と誤解した
3. 自分の提案をユーザーの要望と勘違いした

**正しい対処法:**
1. まず要件定義書を確認する
2. ユーザーの質問には質問で答える（「必要ですか？」→「要件にないので不要です」）
3. 機能追加を提案する前に要件との整合性を確認する

**教訓:**
- ユーザーの質問 ≠ 依頼。確認してから行動する。
- 要件にないものを勝手に追加しない。
- 自分が主導した提案を「ユーザーの要望」とすり替えない。

---

## 最新アップデート

### 不要なSupabase関連コードを削除（2026-02-13）

**削除したファイル:**
- `lib/data/datasources/supabase_service.dart`
- `lib/core/config/supabase_config.dart`
- `docs/supabase_schema.sql`
- `.env`

**変更したファイル:**
- `pubspec.yaml`: supabase_flutter 依存関係を削除
- `lib/main.dart`: Supabase初期化コードを削除

**理由:** 要件定義書に従い、データ永続化はSharedPreferencesのみで十分。

---

## トラブルシューティング

<!-- プロジェクト固有のエラーを追加 -->

---

## .claude/rules/ 構成

| ファイル | 内容 |
|---------|------|
| `01-core-rules.md` | 5原則の詳細（コード例・判断フロー付き） |
| `02-workflow.md` | Ralph-Loop、SubAgent委託、Git、デプロイ |
| `03-patterns.md` | API連携、ビジネスロジック、マルチテナント設計 |
| `04-quality.md` | テスト戦略、セキュリティ、CI/CD |
| `05-agents.md` | エージェント一覧、インストール、活用ルール |
| `06-documentation.md` | CLAUDE.md更新ルール、自己学習、Skill化 |
| `07-prohibitions.md` | 禁止事項詳細、応急処置禁止、判断基準 |
