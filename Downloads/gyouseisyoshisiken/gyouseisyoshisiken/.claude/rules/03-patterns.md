# 実践的な設計パターン

## 外部API連携の設計原則

### 1. 大量データ取得の分割戦略

```typescript
// ❌ NG: 1ヶ月分を一括取得（タイムアウト・メモリ問題）
const data = await fetchAllMonthData(month)

// ✅ OK: 5日分割で取得（負荷分散・リトライ容易）
for (let day = 1; day <= lastDay; day += 5) {
  const period = { start: day, end: Math.min(day + 4, lastDay) }
  await fetchPeriodData(period)
}
```

### 2. リトライ＆フォールバック機構

```typescript
// ✅ 必ず実装すべきパターン
const fetchWithRetry = async (fn, maxRetries = 3) => {
  for (let i = 0; i < maxRetries; i++) {
    try {
      return await fn()
    } catch (e) {
      if (i === maxRetries - 1) throw e
      await sleep(1000 * (i + 1)) // 指数バックオフ
    }
  }
}
```

### 3. APIトークンの安全な管理

```typescript
// ✅ 暗号化保存 + 環境変数でキー管理
const encryptToken = (token: string) => {
  const key = process.env.ENCRYPTION_KEY
  // AES-256-CTR で暗号化
}
```

### 4. データ型の動的変換

```typescript
// ✅ 外部APIの型不整合に対応
const integerFields = ['quantity', 'stock']
const decimalFields = ['price', 'tax']

Object.keys(data).forEach(key => {
  if (integerFields.includes(key)) {
    data[key] = parseInt(data[key]) || 0
  }
})
```

---

## 複雑なビジネスロジックの設計

### 1. 計算ロジックの分離

```typescript
// ✅ 計算ロジックは純粋関数として分離
// lib/calculators/payroll-calculator.ts
export const calculatePayroll = (params: PayrollParams): PayrollResult => {
  const basePay = calculateBasePay(params)
  const incentives = calculateIncentives(params)
  const deductions = calculateDeductions(params)
  return { basePay, incentives, deductions, total: basePay + incentives - deductions }
}
```

### 2. 設定のDB管理

```typescript
// ✅ ビジネスルールはDBで管理（コード変更不要）
// incentive_patterns テーブル
// | product_id | rate | type |
// | 487        | 1000 | fixed |
// | 536        | 0.1  | percentage |
```

---

## マルチロール・マルチテナント設計

```
ディレクトリ構成:
app/
├── admin/          # 管理者向け（全機能アクセス）
├── staff/          # 一般従業員向け（限定機能）
├── api/
│   ├── admin/      # 管理者専用API
│   └── public/     # 認証不要API
```

---

## 段階的な機能実装（推奨フェーズ）

```
Phase 1: 基盤構築
├── 認証・認可システム
├── DBスキーマ設計
├── 基本CRUD API
└── 管理画面の骨格

Phase 2: コア機能
├── メイン業務機能
├── データ可視化（ダッシュボード）
└── バリデーション強化

Phase 3: 統合・高度化
├── 外部API連携
├── レポート・PDF出力
├── 通知システム
└── パフォーマンス最適化
```
