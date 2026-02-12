# 開発フロー・ワークフロー

## オーケストレーターパターン

### 基本原則

```
あなたはマネージャーでagentオーケストレーターです。
あなたは絶対に実装せず、全てsubagentやtask agentに委託すること。
タスクは超細分化し、PDCAサイクルを構築すること。
曖昧な要件は必ず AskUserQuestionTool でヒアリングすること。
```

### 推奨開発フロー（Ralph-Loop）

```
1. Issue/要件の確認
   └→ 要件が曖昧な場合は AskUserQuestionTool でヒアリング

2. Plan モードで設計
   └→ Explore SubAgent: コードベース調査
   └→ Plan SubAgent: 仕様設計・アーキテクチャ決定

3. 軌道確認
   └→ AskUserQuestionTool で設計の承認を得る

4. 実装開始
   └→ タスクを超細分化してTodoWriteに登録
   └→ 各タスクを専門SubAgentに委託

5. 実装（TDD推奨）
   └→ @test-engineer: テスト設計
   └→ 実装 → テスト → リファクタリング

6. レビュー
   └→ @code-reviewer: コードレビュー
   └→ @security-auditor: セキュリティチェック

7. 完了報告
   └→ 実装内容をCLAUDE.mdに記録
```

### いつ使うか

| 状況 | 推奨フロー |
|------|-----------|
| 複雑な機能開発 | ✅ フル適用 |
| 要件が曖昧 | ✅ フル適用（ヒアリング重視） |
| 既存コードの理解が必要 | ✅ フル適用（Explore重視） |
| 単純なバグ修正 | ⚡ 簡略化OK（調査→修正→テスト） |
| 小さな変更 | ⚡ 直接実装OK |

### ヒアリング必須の場面

以下の場合は必ず `AskUserQuestionTool` で確認すること：

1. **要件が曖昧** - 「〇〇を作って」だけで詳細がない / 複数の解釈ができる
2. **技術選定** - 複数の選択肢がある / トレードオフがある
3. **破壊的変更** - 既存機能に影響する / データ構造を変える
4. **スコープ不明** - どこまでやるか不明確 / 優先順位が不明

### SubAgent委託ルール

```
【委託すべき作業】
- コードベース調査 → Explore SubAgent
- 設計・アーキテクチャ → Plan SubAgent
- コード実装 → Task Agent
- テスト作成 → @test-engineer
- レビュー → @code-reviewer

【自分でやること】
- 全体の進行管理
- ユーザーとのコミュニケーション
- 最終判断・承認
- CLAUDE.mdの更新
```

---

## Git ワークフロー

### ブランチ戦略

```
main (本番)
  └── develop (開発)
        ├── feature/xxx (機能開発)
        ├── fix/xxx (バグ修正)
        └── hotfix/xxx (緊急修正)
```

### コミットメッセージ形式

```bash
# Conventional Commits 形式
git commit -m "feat: ユーザー認証機能を追加

- JWTベースの認証を実装
- リフレッシュトークンに対応

Co-Authored-By: Claude <noreply@anthropic.com>
"
```

#### コミットタイプ

| タイプ | 用途 |
|--------|------|
| `feat` | 新機能 |
| `fix` | バグ修正 |
| `docs` | ドキュメントのみ |
| `style` | フォーマット（動作に影響なし） |
| `refactor` | リファクタリング |
| `test` | テスト追加・修正 |
| `chore` | ビルド・補助ツール |

### デプロイ手順

```bash
# 1. 変更をコミット
git add -A
git commit -m "feat: 変更内容"

# 2. プッシュ（自動デプロイの場合）
git push origin main

# 3. 手動デプロイ（必要な場合）
vercel --prod
# または
npm run deploy
```

---

## 初回セットアップ

**【最優先】ユーザーから最初の依頼を受けたら、他の作業より先に以下を実行せよ:**

### Step 1: エージェント確認
`.claude/agents/` ディレクトリを確認し、エージェントがインストール済みか判定。

### Step 2: 未インストールなら全エージェントをインストール
エージェントが未インストールの場合、`05-agents.md` のインストールコマンドを全て実行してからユーザーの依頼に取り掛かること。

### Step 3: インストール完了後
CLAUDE.mdの「最新アップデート」にインストール完了を記録し、ユーザーの元の依頼に取り掛かる。

### 自動承認設定

```bash
# 方法1: 起動時オプション（推奨）
claude --dangerously-skip-permissions

# 方法2: .claude/settings.json
{
  "permissions": {
    "allow": [
      "Bash(npx claude-code-templates@latest*)",
      "Bash(npm*)", "Bash(npx*)",
      "Read(*)", "Write(*)", "Edit(*)"
    ]
  }
}
```
