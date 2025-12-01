# ビルド方法

このプロジェクトは、テスト環境（GitHub Pages）と本番環境（ftttk.org）で異なる設定を使用します。

## 環境別設定

### テスト環境（GitHub Pages）
- **URL**: https://tkhugo.amana.top/
- **CNAME**: 含む
- **用途**: 開発・テスト

### 本番環境（ftttk.org）
- **URL**: https://ftttk.org/
- **CNAME**: 含まない
- **用途**: 一般公開

## ビルド方法

### GitHub Pages用（テスト環境）

```bash
./build-staging.sh
```

または

```bash
hugo --gc --minify --environment staging
```

このコマンドは：
- `baseURL` を `https://tkhugo.amana.top/` に設定
- `CNAME` ファイルを `docs/` に含める
- GitHub Pagesへのデプロイ用

### 本番サーバー用（ftttk.org）

```bash
./build-production.sh
```

または

```bash
hugo --gc --minify --environment production
```

このコマンドは：
- `baseURL` を `https://ftttk.org/` に設定
- `CNAME` ファイルを含めない
- 本番サーバーへのアップロード用

## デプロイフロー

### GitHub Pages（テスト）へのデプロイ

```bash
# 1. Staging用にビルド
./build-staging.sh

# 2. コミット＆プッシュ
git add -A
git commit -m "Build for staging"
git push origin public-build-2
```

### 本番サーバー（ftttk.org）へのデプロイ

#### 方法1: 半自動デプロイ（推奨）

```bash
# デプロイ準備スクリプトを実行
./deploy-to-production.sh
```

このスクリプトが：
1. Production用にビルド
2. 内容を検証（baseURL, CNAMEの有無など）
3. 次の手順を表示

その後、FTPクライアントで `docs/` の**中身**を本番サーバーにアップロード。

#### 方法2: 手動ビルド

```bash
# 1. Production用にビルド
./build-production.sh

# 2. docsフォルダの中身を本番サーバーにアップロード
# (FTP, rsync, またはお使いのデプロイツールを使用)
```

**重要**: `docs` フォルダ自体ではなく、**中身**をサーバーのルートにアップロードしてください。

## ローカル開発

```bash
# 開発サーバーを起動（ドラフトを含む）
hugo server -D

# または環境を指定
hugo server -D --environment staging
hugo server -D --environment production
```

## ディレクトリ構造

```
config/
├── production/    # 本番環境用設定
│   └── hugo.yaml
└── staging/       # テスト環境用設定
    └── hugo.yaml

static/            # 共通の静的ファイル
static-staging/    # GitHub Pages専用ファイル（CNAME）
```

## 注意事項

- `hugo.yaml` はベース設定（共通設定）
- 環境別設定は `config/<environment>/hugo.yaml` で上書き
- CNAMEファイルはGitHub Pages専用（本番ビルドには含まれない）

