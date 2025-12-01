#!/bin/bash
# GitHub Pages（テストサーバー）用ビルドスクリプト
# Usage: ./build-staging.sh

echo "🧪 Building for STAGING (tkhugo.amana.top)..."
hugo --gc --minify --environment staging

echo "✅ Staging build completed!"
echo "📁 Output directory: docs/"
echo "🌐 Base URL: https://tkhugo.amana.top/"
echo "📄 CNAME file: included"
echo ""
echo "Next steps:"
echo "1. git add -A"
echo "2. git commit -m 'Build for staging'"
echo "3. git push origin <branch-name>"

