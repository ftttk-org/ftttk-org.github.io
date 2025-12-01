#!/bin/bash
# 本番サーバー（ftttk.org）へのデプロイ準備スクリプト
# 
# 使い方:
#   1. このスクリプトを実行: ./deploy-to-production.sh
#   2. 生成された docs/ フォルダをFTPでアップロード

set -e  # エラーで停止

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  本番サーバー（ftttk.org）デプロイ準備"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# ステップ1: 本番用ビルド
echo "📦 [1/3] Production用にビルド中..."
./build-production.sh

# ステップ2: 検証
echo ""
echo "🔍 [2/3] ビルド内容を検証中..."

# CNAMEファイルがないことを確認
if [ -f "public/CNAME" ]; then
    echo "⚠️  警告: public/CNAME ファイルが存在します"
    echo "   （本番サーバーには不要です）"
else
    echo "✅ CNAMEファイル: なし（正常）"
fi

# baseURLを確認
if grep -q "https://ftttk.org" public/index.html 2>/dev/null; then
    echo "✅ Base URL: https://ftttk.org（正常）"
else
    echo "❌ エラー: Base URLが正しくありません"
    exit 1
fi

# ファイル数とサイズを表示
FILE_COUNT=$(find public -type f | wc -l | tr -d ' ')
TOTAL_SIZE=$(du -sh public | awk '{print $1}')

echo "✅ ファイル数: ${FILE_COUNT}個"
echo "✅ 合計サイズ: ${TOTAL_SIZE}"

# ステップ3: 次の手順を表示
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🎉 [3/3] ビルド完了！"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "📤 次の手順:"
echo ""
echo "1. FTPクライアントを開く（FileZilla, Cyberduck等）"
echo ""
echo "2. 以下のフォルダを選択:"
echo "   📁 $(pwd)/public"
echo ""
echo "3. フォルダの【中身】を本番サーバーのルートにアップロード"
echo "   ⚠️  publicフォルダ自体ではなく、中身をアップロード！"
echo ""
echo "   正しい構造:"
echo "   サーバー/"
echo "   ├── index.html"
echo "   ├── about/"
echo "   ├── testimonies/"
echo "   └── ..."
echo ""
echo "   ❌ 間違った構造:"
echo "   サーバー/"
echo "   └── public/"
echo "       ├── index.html"
echo "       └── ..."
echo ""
echo "4. アップロード完了後、確認:"
echo "   🌐 https://ftttk.org/"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

