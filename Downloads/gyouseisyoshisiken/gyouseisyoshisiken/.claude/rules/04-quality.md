# 品質管理

## テスト戦略

### テストピラミッド

```
        /\
       /  \      E2E テスト (少数・重要フローのみ)
      /────\
     /      \    統合テスト (API, DB連携)
    /────────\
   /          \  ユニットテスト (多数・高速)
  /────────────\
```

### 必須テスト基準

| 種類 | 対象 | カバレッジ目標 |
|------|------|---------------|
| ユニット | ビジネスロジック、ユーティリティ | 80%以上 |
| 統合 | API エンドポイント | 主要パス100% |
| E2E | クリティカルユーザーフロー | 主要5-10フロー |

### テスト実行コマンド

<!-- [CUSTOMIZE] プロジェクトのコマンドに置き換え -->

```bash
# ユニットテスト
npm test              # or pytest tests/unit

# 統合テスト
npm run test:integration  # or pytest tests/integration

# E2Eテスト
npm run test:e2e      # or playwright test

# カバレッジレポート
npm run test:coverage
```

### テスト作成ルール

1. **テストファイルの配置**
   - コロケーション: `src/utils/format.ts` → `src/utils/format.test.ts`
   - または専用ディレクトリ: `tests/unit/utils/format.test.ts`

2. **テスト命名規則**
   ```typescript
   describe('formatDate', () => {
     it('should format ISO date to Japanese format', () => {})
     it('should return empty string for invalid date', () => {})
     it('should handle timezone correctly', () => {})
   })
   ```

3. **モック・スタブの原則**
   - 外部API、データベースはモック
   - 時間依存処理は固定値を注入
   - ファイルシステムは仮想化またはtmpdir使用

---

## セキュリティ基本ルール

### 入力検証

```typescript
// ✅ 全ての外部入力を検証
import { z } from 'zod'

const UserInput = z.object({
  email: z.string().email(),
  age: z.number().min(0).max(150),
})

const result = UserInput.safeParse(req.body)
if (!result.success) {
  return res.status(400).json({ error: result.error })
}
```

### 認証・認可

```typescript
// ✅ 全ての保護リソースで認証チェック
if (!session?.user) {
  return res.status(401).json({ error: 'Unauthorized' })
}

// ✅ リソースの所有者確認
const post = await getPost(id)
if (post.authorId !== session.user.id) {
  return res.status(403).json({ error: 'Forbidden' })
}
```

### 機密情報の取り扱い

```bash
# ❌ コミット禁止
.env, .env.local, *.pem, *credentials*, *secret*

# ✅ 環境変数で管理
DATABASE_URL=
API_SECRET_KEY=
```

### SQLインジェクション防止

```typescript
// ❌ NG: 文字列結合
const query = `SELECT * FROM users WHERE id = ${userId}`

// ✅ OK: パラメータ化クエリ
const user = await prisma.user.findUnique({ where: { id: userId } })
const [rows] = await db.execute('SELECT * FROM users WHERE id = ?', [userId])
```

### XSS防止

```typescript
// ❌ NG: 生HTMLの挿入
element.innerHTML = userInput

// ✅ OK: エスケープまたはフレームワーク機能を使用
element.textContent = userInput
// React: {userInput} は自動エスケープ
```

---

## CI/CD チェックリスト

### プルリクエスト前の確認

- [ ] `npm run lint` エラーなし
- [ ] `npm run typecheck` エラーなし
- [ ] `npm test` 全テスト通過
- [ ] `npm run build` ビルド成功
- [ ] CLAUDE.md に変更を記録（必要な場合）

### マージ前の確認

- [ ] コードレビュー承認
- [ ] CI パイプライン全て緑
- [ ] ステージング環境で動作確認（重要な変更の場合）
