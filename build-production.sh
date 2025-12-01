#!/bin/bash
# 本番サーバー用ビルドスクリプト
# Usage: ./build-production.sh

echo "🚀 Building for PRODUCTION (ftttk.org)..."

# publicフォルダをクリーンアップ
rm -rf public/*

# Hugoをproduction環境でビルド
hugo --gc --minify --environment production -d public

echo "✅ Production build completed!"
echo "📁 Output directory: public/"
echo "🌐 Base URL: https://ftttk.org/"
echo ""
echo "Next steps:"
echo "1. Upload the 'public' folder contents to your production server"
echo "2. Access https://ftttk.org/ to verify"

