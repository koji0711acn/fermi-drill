# Fermi Drill

フェルミ推定を毎日1問、テンポよく練習できるドリル型トレーニングアプリ。

## セットアップ手順

### 必要な環境

- Ruby 3.3+
- Bundler
- SQLite3
- Node.js (Tailwind CSS ビルド用)

### インストール

```bash
cd fermi_drill
bundle install
```

### 環境変数の設定

`.env` ファイルをプロジェクトルートに作成し、以下を設定:

```
OPENAI_API_KEY=your_openai_api_key_here
OPENAI_MODEL=gpt-4o-mini
```

- `OPENAI_API_KEY`: OpenAI APIキー（必須。未設定の場合、AI採点が失敗します）
- `OPENAI_MODEL`: 使用するモデル名（省略時は `gpt-4o-mini`）

### データベースのセットアップ

```bash
bundle exec rails db:create db:migrate db:seed
```

seed で 30 問のフェルミ推定問題が登録されます。

### ローカル起動

```bash
# Tailwind CSS のウォッチモードと Rails サーバーを同時起動
bin/dev

# または Rails サーバーのみ
bundle exec rails tailwindcss:build
bundle exec rails server
```

http://localhost:3000 にアクセス。

## 主な機能

- ユーザー登録・ログイン（Devise）
- フェルミ推定問題一覧（難易度・カテゴリフィルタ）
- 問題への回答入力（推定値 + 思考プロセス）
- OpenAI API による AI 採点（4項目）
  - 因数分解（decomposition）
  - 前提設定（assumptions）
  - 桁感（numeracy）
  - 伝達力（communication）
- 採点結果表示（スコア、良い点、改善点、模範アプローチ）
- 次のおすすめ問題の提示
- 練習履歴一覧・詳細
- ダッシュボード（累計回数、平均スコア、苦手項目、カテゴリ別回数）

## OpenAI API キー未設定時の挙動

- ユーザーの回答は `submitted` ステータスで保存されます
- 採点は失敗し、エラーメッセージが表示されます
- 「再採点」ボタンで後から採点をリトライできます

## 既知の制約

- **数値の正誤より思考プロセス重視**: 推定値が参考レンジからずれていても、因数分解・前提設定が優れていれば高評価
- **リアルタイム面接形式ではない**: 1問ずつ非同期で解くドリル形式
- **AI 評価は参考用**: 採点は完全ではなく、学習の参考として活用してください
- **採点にはネットワーク接続と有効な OpenAI API キーが必要**

## 技術スタック

- Ruby on Rails 8.1
- SQLite3
- Devise（認証）
- Tailwind CSS（UI）
- OpenAI API（採点）
- dotenv-rails（環境変数）
