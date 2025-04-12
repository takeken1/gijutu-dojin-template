#!/bin/bash

# 設定
BOOK_TITLE="技術同人誌タイトル"
VERSION=${VERSION:-"1.0"}
OUTPUT_FILE="$BOOK_TITLE-v$VERSION.pdf"

# 必要なディレクトリの作成
mkdir -p ./dist
mkdir -p ./tmp

# tmpディレクトリをクリーンアップ
echo "一時ファイルをクリーンアップしています..."
rm -f ./tmp/*.pdf

# 表紙のPNGファイルをPDFに変換
if [ -f ./src/images/hyoshi.png ]; then
  echo "表紙のPNGファイルをPDFに変換しています..."
  sips -s format pdf ./src/images/hyoshi.png --out ./tmp/00_hyoshi.pdf
else
  echo "表紙のPNGファイルが見つかりませんでした。スキップします。"
fi

# すべての章をPDFに変換
echo "Markdownファイルを変換しています..."
for md_file in ./src/chapters/*.md; do
  echo "変換中: $md_file"
  npx md-to-pdf "$md_file" --config-file config.json
done

# 変換したPDFをtmpディレクトリに移動
echo "一時ファイルを移動しています..."
mv ./src/chapters/*.pdf ./tmp/ 2>/dev/null || true

# PDFを結合
echo "PDFを結合しています..."

# すべてのPDFファイルをリストアップし、ソート
PDF_FILES=$(ls -v ./tmp/*.pdf 2>/dev/null)

# PDFファイルが存在する場合のみ結合
if [ -n "$PDF_FILES" ]; then
  qpdf --empty --pages $PDF_FILES -- ./dist/$OUTPUT_FILE
  echo "PDFが生成されました: ./dist/$OUTPUT_FILE"
else
  echo "エラー: 結合するPDFファイルがありません"
  exit 1
fi
