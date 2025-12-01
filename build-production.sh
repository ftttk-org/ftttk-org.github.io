#!/bin/bash
# 本番サーバー用ビルドスクリプト
# Usage: ./build-production.sh

echo "🚀 Building for PRODUCTION (ftttk.org)..."
hugo --gc --minify --environment production

echo "✅ Production build completed!"
echo "📁 Output directory: docs/"
echo "🌐 Base URL: https://ftttk.org/"
echo ""
echo "Next steps:"
echo "1. Upload the 'docs' folder to your production server"
echo "2. Point ftttk.org to the uploaded files"

