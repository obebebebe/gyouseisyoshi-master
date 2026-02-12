# 絶対遵守ルール 詳細

## 0. 曖昧さの排除（最優先）

**曖昧な要件・不明点がある場合は、必ず `AskUserQuestionTool` でヒアリングしてから作業を開始すること。**

```
❌ 悪い例:
- 「たぶんこういう意味だろう」と推測して実装
- 詳細を聞かずに自分で決めて進める
- 後から「これでいいですか？」と聞く

✅ 良い例:
- 不明点を整理して AskUserQuestionTool で質問
- 選択肢を提示してユーザーに選んでもらう
- 確認してから実装に入る
```

**ヒアリングが必要な場面:**
- 要件の詳細が不明
- 複数の実装方法がある
- 技術選定が必要
- 既存機能への影響がある
- スコープが不明確

---

## 1. 正直さ・誠実さの原則

1. **絶対に嘘をつかない** - 推測で答えない、事実を確認してから答える
2. **わからないことは「わからない」と言う** - 曖昧なことを断定的に言わない
3. **必ず調べるか聞く** - ログ、データベース、ファイルを確認、それでも不明ならユーザーに確認
4. **エビデンスベースで回答** - 「たぶん」「おそらく」ではなく、証拠を示す

```
❌ 悪い例:
「この投稿はAIが作成しました」（確認せずに断定）
「2番目のアカウント（@xxxなど）」（ログにIDしかないのに推測）

✅ 良い例:
「ログを確認したところ、この時間には実行されていません」
「確認できません。ログや履歴を確認させてください」
「IDをデータベースで確認したところ、@xxxでした」
```

---

## 2. ハードコーディング禁止の原則

**根本原則: ビジネスロジックの判定をコードに埋め込むな**

### 許可されるもの

```javascript
// ✅ OK: 環境変数・設定ファイルで管理
const API_URL = process.env.API_URL
const MAX_UPLOAD_SIZE = config.maxUploadSize

// ✅ OK: 技術的な定数（変更頻度が極めて低い）
const HTTP_OK = 200
const HASH_ROUNDS = 10

// ✅ OK: UIの選択肢（設定ファイル推奨）
const SUPPORTED_LANGUAGES = ['ja', 'en', 'zh']
```

### 禁止されるもの

```javascript
// ❌ NG: ビジネスロジックの判定をハードコード
const FORBIDDEN_WORDS = ['やばい', 'まじ']  // → AI判定へ
if (text.includes('仕事')) return 'work'     // → AI分類へ
if (score > 70) return 'pass'                // → 設定ファイル or AI判定へ

// ✅ OK: AIで動的判定
const category = await classifyWithAI(text)
const isAppropriate = await moderateWithAI(text)
const result = await evaluateWithAI(content, criteria)
```

### 判断フローチャート

```
そのロジックは...
  │
  ├─ 技術的な制約？ (HTTP status, 暗号化rounds等)
  │    → ✅ 定数でOK
  │
  ├─ 環境依存？ (URL, API Key, 接続先等)
  │    → ✅ 環境変数・設定ファイル
  │
  ├─ ユーザーが変更する可能性？ (閾値, 制限値等)
  │    → ✅ 設定ファイル or データベース
  │
  └─ ビジネス判断が必要？ (分類, 判定, 評価等)
       → ✅ AI判定を使用
```

---

## 3. データ層アクセスの原則

**クエリを書く前に必ずスキーマ/型定義を確認せよ**

| 技術 | 確認すべきファイル |
|------|-------------------|
| Prisma | `prisma/schema.prisma` |
| TypeORM | Entity定義ファイル (`*.entity.ts`) |
| SQLAlchemy | Model定義ファイル (`models.py`) |
| Mongoose | Schema定義ファイル (`*.schema.ts`) |
| 生SQL | DDLファイル or データベーススキーマ |
| GraphQL | `schema.graphql` or 型定義 |
| REST API | OpenAPI/Swagger定義 or 型定義 |

### 過去の失敗例

```typescript
// ❌ スキーマを確認せず、推測でフィールド名を書いた
const posts = await prisma.post.findMany({
  where: { Operation: { id } },  // "Operation"は存在しない
  include: { Content: { select: { body: true } } }  // "body"は存在しない
})

// ✅ 正しい手順:
// 1. schema.prisma を開いて確認
// 2. 正確なフィールド名・リレーション名を使用
const posts = await prisma.post.findMany({
  where: { autoOperation: { id } },
  include: { content: { select: { text: true } } }
})
```

**教訓: 推測で書かない。必ずスキーマを確認してからクエリを書く。**

---

## 4. 構造化データの原則

1. **JSON/JSONB型でのメタデータ保存は避ける**
   - クエリで検索・集計する可能性のあるデータは個別カラムに
   - `updatedAt`, `count`, `status` 等は必ずカラム化

2. **JSON型を使って良いケース**
   - 構造が不定の配列データ
   - 外部APIからの生レスポンス保存
   - 頻繁に構造が変わる一時データ

```typescript
// ❌ NG: 検索可能であるべきデータをJSONに
const data = {
  items: [...],
  updatedAt: new Date(),  // ← カラムにすべき
  status: 'active'        // ← カラムにすべき
}

// ✅ OK: メタデータはカラム、可変データはJSON
model Result {
  id        String   @id
  status    String   // 検索用
  updatedAt DateTime @updatedAt
  rawData   Json     // 外部APIレスポンス等
}
```
