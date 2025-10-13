# 東京全時間訓練 公式サイト

Hugo (PaperMod) を使用した東京全時間訓練の公式ウェブサイトです。

## 技術スタック

- **フレームワーク**: Hugo
- **テーマ**: PaperMod
- **ホスティング**: GitHub Pages
- **公開フォルダ**: `/docs`

## 開発環境

### 前提条件

- Hugo Extended (v0.151.0以上)
- Node.js (package.jsonがある場合)

### ローカル開発

```bash
# リポジトリをクローン
git clone https://github.com/ftttk-org/ftttk-org.github.io.git
cd ftttk-org.github.io

# Hugoサーバーを起動
hugo server -D
```

### ビルド

```bash
# サイトをビルド（/docsフォルダに出力）
hugo --gc --minify
```

## GitHub Pages デプロイ

このリポジトリはGitHub Actionsを使用して自動デプロイされます：

1. `main`ブランチにプッシュすると自動的にビルドが実行されます
2. ビルドされたサイトは`/docs`フォルダに出力されます
3. GitHub Pagesは`/docs`フォルダからサイトを公開します

### GitHub Pages設定

リポジトリの設定で以下を確認してください：

- **Source**: Deploy from a branch
- **Branch**: main
- **Folder**: /docs

## サイト構造

```
content/
├── about/          # 訓練について
├── admission/      # 訓練への参加
├── testimonies/    # 恵みの証し
└── resources/      # リソース

layouts/
├── _default/       # デフォルトレイアウト
├── testimonies/    # testimonies専用レイアウト
└── shortcodes/     # ショートコード

static/             # 静的ファイル
docs/               # ビルド出力（GitHub Pages用）
```

## ライセンス

このプロジェクトは東京全時間訓練の公式サイトです。
