# Claude Code エージェント

## エージェント活用ルール

**インストール済みエージェントを積極的に活用せよ。以下の場面で自動的に適切なエージェントを呼び出すこと:**

| 場面・タスク | 使用するエージェント |
|-------------|---------------------|
| コード実装完了時 | `@code-reviewer` でレビュー実施 |
| エラー・バグ発生時 | `@debugger` または `@error-detective` で調査 |
| テスト作成時 | `@test-engineer` でテスト設計・実装 |
| DB スキーマ設計・変更時 | `@database-architect` で設計レビュー |
| SQL クエリ作成時 | `@sql-pro` で最適化確認 |
| パフォーマンス問題時 | `@database-optimization` で分析 |
| セキュリティ懸念時 | `@security-auditor` で監査 |
| UI/UX 改善時 | `@ui-ux-designer` で提案 |
| API 設計時 | `@backend-architect` で設計レビュー |
| 複雑なタスク時 | `@task-decomposition-expert` で分解 |
| アーキテクチャ決定時 | `@architect-review` でレビュー |
| CI/CD・デプロイ設定時 | `@devops-engineer` で設計 |
| API ドキュメント作成時 | `@api-documenter` で生成 |
| Next.js 特有の問題時 | `@nextjs-architecture-expert` で相談 |
| Supabase 設定時 | `@supabase-schema-architect` で設計 |
| AI/ML 実装時 | `@ai-engineer` で実装支援 |

**重要**: エージェントがインストールされていない場合は、ユーザーにインストールを提案すること。

---

## インストール方法

```bash
npx claude-code-templates@latest --agent=<カテゴリ>/<エージェント名> --yes
```

---

## 推奨エージェント一覧

### 開発チーム系

| エージェント | コマンド | 用途 |
|-------------|---------|------|
| フロントエンド開発者 | `--agent=development-team/frontend-developer` | React/Vue等のUI開発 |
| バックエンドアーキテクト | `--agent=development-team/backend-architect` | API設計・サーバー構築 |
| フルスタック開発者 | `--agent=development-team/fullstack-developer` | 全般的な開発 |
| UI/UXデザイナー | `--agent=development-team/ui-ux-designer` | デザイン・UX改善 |
| DevOpsエンジニア | `--agent=development-team/devops-engineer` | CI/CD・インフラ |

### 開発ツール系

| エージェント | コマンド | 用途 |
|-------------|---------|------|
| コードレビュアー | `--agent=development-tools/code-reviewer` | コードレビュー・品質チェック |
| デバッガー | `--agent=development-tools/debugger` | バグ調査・修正 |
| エラー探偵 | `--agent=development-tools/error-detective` | エラー原因特定 |
| テストエンジニア | `--agent=development-tools/test-engineer` | テスト設計・実装 |
| MCPエキスパート | `--agent=development-tools/mcp-expert` | MCP連携 |

### データベース系

| エージェント | コマンド | 用途 |
|-------------|---------|------|
| DBアーキテクト | `--agent=database/database-architect` | スキーマ設計 |
| DB最適化 | `--agent=database/database-optimization` | クエリ・パフォーマンス改善 |
| DB管理者 | `--agent=database/database-admin` | 運用・保守 |
| Supabaseアーキテクト | `--agent=database/supabase-schema-architect` | Supabase特化 |
| SQLプロ | `--agent=programming-languages/sql-pro` | SQL作成・最適化 |

### AI・データ系

| エージェント | コマンド | 用途 |
|-------------|---------|------|
| AIエンジニア | `--agent=data-ai/ai-engineer` | AI/ML実装 |
| データサイエンティスト | `--agent=data-ai/data-scientist` | データ分析 |
| タスク分解エキスパート | `--agent=ai-specialists/task-decomposition-expert` | 複雑タスクの分解 |

### 品質・セキュリティ系

| エージェント | コマンド | 用途 |
|-------------|---------|------|
| セキュリティ監査 | `--agent=security/security-auditor` | 脆弱性チェック |
| テスト自動化 | `--agent=performance-testing/test-automator` | 自動テスト構築 |
| アーキテクトレビュー | `--agent=expert-advisors/architect-review` | 設計レビュー |

### ドキュメント・Web系

| エージェント | コマンド | 用途 |
|-------------|---------|------|
| APIドキュメンター | `--agent=documentation/api-documenter` | API仕様書作成 |
| Next.jsエキスパート | `--agent=web-tools/nextjs-architecture-expert` | Next.js特化 |

---

## 一括インストールスクリプト

```bash
# 全エージェント一括インストール
npx claude-code-templates@latest --agent=development-tools/code-reviewer --yes
npx claude-code-templates@latest --agent=development-tools/debugger --yes
npx claude-code-templates@latest --agent=development-tools/test-engineer --yes
npx claude-code-templates@latest --agent=development-tools/error-detective --yes
npx claude-code-templates@latest --agent=development-tools/mcp-expert --yes
npx claude-code-templates@latest --agent=security/security-auditor --yes
npx claude-code-templates@latest --agent=development-team/frontend-developer --yes
npx claude-code-templates@latest --agent=development-team/backend-architect --yes
npx claude-code-templates@latest --agent=development-team/fullstack-developer --yes
npx claude-code-templates@latest --agent=development-team/ui-ux-designer --yes
npx claude-code-templates@latest --agent=development-team/devops-engineer --yes
npx claude-code-templates@latest --agent=database/database-architect --yes
npx claude-code-templates@latest --agent=database/database-optimization --yes
npx claude-code-templates@latest --agent=database/database-admin --yes
npx claude-code-templates@latest --agent=database/supabase-schema-architect --yes
npx claude-code-templates@latest --agent=programming-languages/sql-pro --yes
npx claude-code-templates@latest --agent=data-ai/ai-engineer --yes
npx claude-code-templates@latest --agent=data-ai/data-scientist --yes
npx claude-code-templates@latest --agent=ai-specialists/task-decomposition-expert --yes
npx claude-code-templates@latest --agent=expert-advisors/architect-review --yes
npx claude-code-templates@latest --agent=performance-testing/test-automator --yes
npx claude-code-templates@latest --agent=documentation/api-documenter --yes
npx claude-code-templates@latest --agent=web-tools/nextjs-architecture-expert --yes
```

---

## エージェントの使い方

インストール後、Claude Code内で以下のように呼び出し:

```
@code-reviewer このPRをレビューして
@debugger このエラーの原因を調査して
@test-engineer このモジュールのテストを作成して
```
