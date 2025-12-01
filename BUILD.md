# ビルド方法

このプロジェクトは、**Staging（GitHub Pages）** と **Production（本番サーバー）** で異なる環境を使用しています。

## 📁 ビルド先フォルダ

```
docs/   → Staging専用（GitHub Pages）
          Gitにコミット・プッシュする
          
public/ → Production専用（本番サーバー）
          Gitにコミットしない（.gitignoreに含まれる）
          FTPで手動アップロード
```

## 環境別設定

### Staging環境（GitHub Pages: tkhugo.amana.top）
- **設定ファイル**: `config/staging/hugo.yaml`
- **Base URL**: `https://tkhugo.amana.top/`
- **ビルド先**: `docs/`
- **CNAMEファイル**: 含む
- **用途**: 開発・テスト

### Production環境（本番サーバー: ftttk.org）
- **設定ファイル**: `config/production/hugo.yaml`
- **Base URL**: `https://ftttk.org/`
- **ビルド先**: `public/`
- **CNAMEファイル**: 含まない
- **用途**: 一般公開

---

## ビルド方法

### GitHub Pages用（テスト環境）

```bash
./build-staging.sh
```

このコマンドは：
- `baseURL` を `https://tkhugo.amana.top/` に設定
- `CNAME` ファイルを `docs/` に含める
- `docs/` フォルダにビルド
- GitHub Pagesへのデプロイ用

### 本番サーバー用（ftttk.org）

```bash
./build-production.sh
```

または、検証付きの推奨スクリプト：

```bash
./deploy-to-production.sh
```

このコマンドは：
- `baseURL` を `https://ftttk.org/` に設定
- `CNAME` ファイルを含めない
- `public/` フォルダにビルド
- 本番サーバーへのアップロード用

---

## デプロイフロー

### Staging（GitHub Pages）へのデプロイ

```bash
# 1. Staging用にビルド
./build-staging.sh

# 2. コミット＆プッシュ
git add -A
git commit -m "Update content for staging"
git push origin main
```

数分後に https://tkhugo.amana.top/ で確認できます。

### Production（本番サーバー）へのデプロイ

#### 方法1: 半自動デプロイ（推奨）

```bash
# デプロイ準備スクリプトを実行
./deploy-to-production.sh
```

このスクリプトが：
1. Production用にビルド（`public/` フォルダに出力）
2. 内容を検証（baseURL, CNAMEの有無など）
3. 次の手順を表示

その後、FTPクライアントで `public/` の**中身**を本番サーバーにアップロード。

#### 方法2: 手動ビルド

```bash
# 1. Production用にビルド
./build-production.sh

# 2. publicフォルダの中身を本番サーバーにアップロード
# (FTP, rsync, またはお使いのデプロイツールを使用)
```

**重要**: `public` フォルダ自体ではなく、**中身**をサーバーのルートにアップロードしてください。

---

## ローカル開発

```bash
# 開発サーバーを起動（ドラフトを含む）
hugo server -D

# または環境を指定
hugo server -D --environment staging
hugo server -D --environment production
```

---

## ディレクトリ構造

```
config/
├── production/    # 本番環境用設定
│   └── hugo.yaml
└── staging/       # テスト環境用設定
    └── hugo.yaml

static/            # 共通の静的ファイル
static-staging/    # GitHub Pages専用ファイル（CNAME）

docs/              # Staging用ビルド出力（Gitで管理）
public/            # Production用ビルド出力（Gitで管理しない）
```

---

## 注意事項

- `hugo.yaml` はベース設定（共通設定）
- 環境別設定は `config/<environment>/hugo.yaml` で上書き
- CNAMEファイルはGitHub Pages専用（本番ビルドには含まれない）
- `docs/` はGitで管理、`public/` は `.gitignore` で除外

---

## トラブルシューティング

### Stagingが更新されない

1. ビルドコマンドを確認: `./build-staging.sh`
2. Gitにコミット・プッシュ: `git push origin main`
3. GitHub Actionsの状態を確認
4. ブラウザのキャッシュをクリア: `Cmd+Shift+R` (Mac)

### 本番サーバーでリンクが壊れる

- `public/` フォルダでビルドしたか確認
- BaseURLが `https://ftttk.org/` になっているか確認
- FTPで上書きアップロードできているか確認
